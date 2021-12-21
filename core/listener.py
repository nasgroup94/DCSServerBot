# listener.py
import asyncio
from typing import List, Union


class EventListener:

    def __init__(self, bot):
        self.bot = bot
        self.log = bot.log
        self.pool = bot.pool
        self.config = bot.config
        self.loop = asyncio.get_event_loop()

    def registeredEvents(self) -> List[str]:
        return [m for m in dir(self) if m not in dir(EventListener) and not m.startswith('_')]

    async def processEvent(self, data: dict[str, Union[str, int]]) -> None:
        if data['command'] in self.registeredEvents():
            return await getattr(self, data['command'])(data)
        else:
            return None