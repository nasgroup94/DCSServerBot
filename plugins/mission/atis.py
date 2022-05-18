import itertools
import re
from core import report, utils, const


class Main(report.EmbedElement):
    def render(self, airbase: dict, data: dict):
        d, m, s, f = utils.dd_to_dms(airbase['lat'])
        lat = ('N' if d > 0 else 'S') + '{:02d}°{:02d}\'{:02d}"'.format(int(abs(d)), int(abs(m)), int(abs(s)))
        d, m, s, f = utils.dd_to_dms(airbase['lng'])
        lng = ('E' if d > 0 else 'W') + '{:03d}°{:02d}\'{:02d}"'.format(int(abs(d)), int(abs(m)), int(abs(s)))
        self.add_field(name='Code', value=airbase['code'])
        self.add_field(name='Position', value=f'{lat}\n{lng}')
        alt = int(airbase['alt'] * const.METER_IN_FEET)
        self.add_field(name='Altitude', value='{} ft'.format(alt))
        self.add_field(name='▬' * 30, value='_ _', inline=False)
        self.add_field(name='Tower Frequencies', value='\n'.join(
            '{:.3f} MHz'.format(x / 1000000) for x in airbase['frequencyList']))
        weather = data['weather']
        active_runways = utils.get_active_runways(airbase['runwayList'], weather['wind']['atGround'])
        self.add_field(name='Runways (# = active)',
                       value='\n'.join([(x + '#' if x in active_runways else x) for x in airbase['runwayList']]))
        self.add_field(name='Heading', value='{}°\n{}°'.format(
            (airbase['rwy_heading'] + 180) % 360, airbase['rwy_heading']))
        self.add_field(name='▬' * 30, value='_ _', inline=False)
        self.add_field(name='Temperature', value='{:.2f}° C'.format(data['temp']))
        self.add_field(name='Surface Wind',
                       value='{}° @ {} kts'.format(int(weather['wind']['atGround']['dir'] + 180) % 360,
                                                   int(weather['wind']['atGround']['speed'] * const.METER_PER_SECOND_IN_KNOTS)))
        visibility = weather['visibility']['distance']
        if weather['enable_fog'] is True:
            visibility = weather['fog']['visibility']
        self.add_field(name='Visibility', value='{:,} m'.format(
            int(visibility)) if visibility < 10000 else '10 km (+)')
        if 'clouds' in data:
            if 'preset' in data['clouds']:
                readable_name = data['clouds']['preset']['readableName']
                metar = readable_name[readable_name.find('METAR:') + 6:]
                self.add_field(name='Cloud Cover',
                               value=re.sub(' ', lambda m, c=itertools.count(): m.group() if not next(c) % 2 else '\n',
                                            metar))
            else:
                self.add_field(name='Clouds', value='Base:\u2002\u2002\u2002\u2002 {:,} ft\nThickness: {:,} ft'.format(
                    int(data['clouds']['base'] * const.METER_IN_FEET + 0.5),
                    int(data['clouds']['thickness'] * const.METER_IN_FEET + 0.5)))
        else:
            self.add_field(name='Clouds', value='n/a')
        self.add_field(name='QFE', value='{} hPa\n{:.2f} inHg\n{} mmHg'.format(
            int(data['pressureHPA']), data['pressureIN'], int(data['pressureMM'])))
        self.add_field(name='QNH', value='{} hPa\n{:.2f} inHg\n{} mmHg'.format(
            int(data['pressureHPA'] - const.QFE_TO_QNH_MB * alt + 0.5),
            data['pressureIN'] - const.QFE_TO_QNH_INHG * alt,
            int(data['pressureMM'] - const.QFE_TO_QNH_MB * alt + 0.5)))
