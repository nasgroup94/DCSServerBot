from core import EventListener, event, Server, Player, Plugin, get_translation, Side
from typing import Optional

from plugins.mission.commands import Mission

_ = get_translation(__name__.split('.')[1])


class SRSEventListener(EventListener):

    def __init__(self, plugin: Plugin):
        super().__init__(plugin)
        self.mission: Mission = self.bot.cogs['Mission']
        self.srs_users: dict[str, dict[str, dict]] = {}

    def _get_player(self, server: Server, data: dict) -> Optional[Player]:
        if data['unit_id'] in range(100000000, 100000099):
            player = server.get_player(name=data['player_name'])
        else:
            player = server.get_player(unit_id=data['unit_id'])
        return player

    def _add_or_update_srs_user(self, server: Server, data: dict) -> None:
        if server.name not in self.srs_users:
            self.srs_users[server.name] = {}
        self.srs_users[server.name][data['player_name']] = data

    def _del_srs_user(self, server: Server, data: dict) -> None:
        if server.name in self.srs_users:
            return
        self.srs_users[server.name].pop(data['player_name'], None)

    @event(name="onPlayerStart")
    async def onPlayerStart(self, server: Server, data: dict) -> None:
        if data['id'] == 1 or 'ucid' not in data:
            return
        if self.get_config(server).get('enforce_srs', False):
            player: Player = server.get_player(ucid=data['ucid'])
            if player.name not in self.srs_users.get(server.name, {}):
                server.send_to_dcs({"command": "disableSRS", "name": player.name})

    @event(name="onSRSConnect")
    async def onSRSConnect(self, server: Server, data: dict) -> None:
        if data['player_name'] == '"LotAtc"' or data['unit'] == 'EAM':
            return
        self._add_or_update_srs_user(server, data)
        if self.get_config(server).get('enforce_srs', False):
            server.send_to_dcs({"command": "enableSRS", "name": data['player_name']})
        self.mission.eventlistener.display_player_embed(server)

    @event(name="onSRSUpdate")
    async def onSRSUpdate(self, server: Server, data: dict) -> None:
        if data['player_name'] == '"LotAtc"' or data['unit'] == 'EAM':
            return
        self._add_or_update_srs_user(server, data)

    @event(name="onSRSDisconnect")
    async def onSRSDisconnect(self, server: Server, data: dict) -> None:
        if data['player_name'] == '"LotAtc"':
            return
        self._del_srs_user(server, data)
        if self.get_config(server).get('enforce_srs', False):
            server.send_to_dcs({"command": "disableSRS", "name": data['player_name']})
            if self.get_config(server).get('move_to_spec', False):
                player = server.get_player(name=data['player_name'])
                if player and player.side != Side.SPECTATOR:
                    server.move_to_spectators(player, reason=self.get_config(server).get(
                        'message_no_srs', 'You need to use SRS to play on this server!'))
        self.mission.eventlistener.display_player_embed(server)
