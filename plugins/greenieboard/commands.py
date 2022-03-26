import discord
import psycopg2
import shutil
from contextlib import closing
from core import Plugin, DCSServerBot, PluginRequiredError, utils, Report
from discord.ext import commands
from os import path
from typing import Optional, Union, List
from . import get_element, GRADES, const
from .listener import GreenieBoardEventListener


class GreenieBoard(Plugin):

    def get_config(self):
        return self.locals['configs'][0]

    @staticmethod
    def format_comments(data, marker, marker_emoji):
        embed = discord.Embed(title=f"Latest Carrier Landings for user {data[0]['name']}", color=discord.Color.blue())
        ids = landings = grades = ''
        for i in range(0, len(data)):
            ids += (chr(0x31 + i) + '\u20E3' + '\n')
            landings += f"{data[i]['time']:%y-%m-%d %H:%M:%S} - {data[i]['unit_type']}@{data[i]['place']}\n"
            grades += f"{data[i]['grade']}\n"
        embed.add_field(name='ID', value=ids)
        embed.add_field(name='Landing', value=landings)
        embed.add_field(name='Grade', value=grades)
        embed.set_footer(text='Press a number to display details about that specific landing.')
        return embed

    @commands.command(description='Show carrier landing qualifications', usage='[member]')
    @utils.has_role('DCS')
    @commands.guild_only()
    async def carrier(self, ctx, member: Optional[Union[discord.Member, str]], *params):
        if not member:
            member = ctx.message.author
        elif isinstance(member, str):
            name = member
            if len(params) > 0:
                name += ' ' + ' '.join(params)
            ucid = utils.find_user(self, name)
        landings = List[dict]
        conn = self.pool.getconn()
        try:
            with closing(conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)) as cursor:
                if isinstance(member, discord.Member):
                    cursor.execute('SELECT ucid FROM players WHERE discord_id = %s ORDER BY last_seen DESC LIMIT 1',
                                   (member.id, ))
                    ucid = cursor.fetchone()['ucid']
                cursor.execute("SELECT p.name, g.grade, g.unit_type, g.place, g.time FROM greenieboard g, players p "
                               "WHERE p.ucid = %s AND g.player_ucid = p.ucid ORDER BY ID DESC LIMIT %s",
                               (ucid, self.get_config()['num_landings']))
                if cursor.rowcount == 0:
                    await ctx.send('No carrier landings recorded for this user.')
                    return
                landings = [dict(row) for row in cursor.fetchall()]
        except (Exception, psycopg2.DatabaseError) as error:
            self.log.exception(error)
        finally:
            self.pool.putconn(conn)
        n = await utils.selection_list(self, ctx, landings, self.format_comments)
        if n != -1:
            report = Report(self.bot, self.plugin, 'lsoRating.json')
            grade = landings[n]['grade']
            comment = get_element(landings[n]['comment'], 'comment').replace('_', '\\_')
            wire = get_element(landings[n]['comment'], 'wire')
            env = await report.render(landing=landings[n], grade=GRADES[grade], comment=comment, wire=wire)
            await ctx.send(embed=env.embed)

    def render_board(self):
        conn = self.pool.getconn()
        try:
            with closing(conn.cursor(cursor_factory=psycopg2.extras.RealDictCursor)) as cursor:
                cursor.execute('SELECT g.player_ucid, p.name, AVG(g.points) AS points FROM greenieboard g, players p '
                               'WHERE g.player_ucid = p.ucid GROUP BY 1, 2 ORDER BY 3 DESC LIMIT %s',
                               (self.get_config()['num_rows'], ))
                if cursor.rowcount > 0:
                    embed = discord.Embed(title=f"Greenieboard (TOP {self.get_config()['num_rows']})",
                                          color=discord.Color.blue())
                    pilots = points = landings = ''
                    for row in cursor.fetchall():
                        pilots += row['name'] + '\n'
                        points += f"{row['points']:.2f}\n"
                        cursor.execute('SELECT grade, night FROM greenieboard WHERE player_ucid = %s ORDER BY time '
                                       'DESC LIMIT 15', (row['player_ucid'], ))
                        i = 0
                        landings += '**|'
                        for landing in cursor.fetchall():
                            if landing['night']:
                                landings += const.NIGHT_EMOJIS[landing['grade']] + '|'
                            else:
                                landings += const.DAY_EMOJIS[landing['grade']] + '|'
                            i += 1
                        for i in range(i, 15):
                            landings += const.DAY_EMOJIS[None] + '|'
                        landings += '**\n'
                    embed.add_field(name='Pilot', value=pilots)
                    embed.add_field(name='Avg', value=points)
                    embed.add_field(name='|:one:|:two:|:three:|:four:|:five:|:six:|:seven:|:eight:|:nine:|:zero:|:one'
                                         ':|:two:|:three:|:four:|:five:|', value=landings)
                    footer = ''
                    for grade, text in const.GRADES.items():
                        footer += const.DAY_EMOJIS[grade] + ' ' + text + '\n'
                    footer += '\nNight landings shown by round markers.'
                    embed.set_footer(text=footer)
                    return embed
                else:
                    return None
        except (Exception, psycopg2.DatabaseError) as error:
            self.log.exception(error)
        finally:
            self.pool.putconn(conn)

    @commands.command(description='Display the current greenieboard', aliases=['greenie'])
    @utils.has_role('DCS')
    @commands.guild_only()
    async def greenieboard(self, ctx):
        embed = self.render_board()
        if embed:
            await ctx.send(embed=embed)
        else:
            await ctx.send('No carrier landings recorded yet.')


def setup(bot: DCSServerBot):
    if 'missionstats' not in bot.plugins:
        raise PluginRequiredError('missionstats')
    # make sure that we have a proper configuration, take the default one if none is there
    if not path.exists('config/greenieboard.json'):
        bot.log.info('No greenieboard.json found, copying the sample.')
        shutil.copyfile('config/greenieboard.json.sample', 'config/greenieboard.json')
    bot.add_cog(GreenieBoard(bot, GreenieBoardEventListener))