import requests
import json

def where(city):
    r = requests.get(
        'https://maps.googleapis.com/maps/api/geocode/json',
        params={"address": city}
    ).content
    return json.loads(r)['results'][0]['geometry']['location']

[where(thing) for thing in
    ['London', 'Berlin', 'Milan', 'my plane ticket', 'my keys']
]

import asyncio
import aiohttp
import json

async def where(city):
    async with aiohttp.ClientSession() as session:
        r = await session.get(
            'https://maps.googleapis.com/maps/api/geocode/json',
            params={"address": city})
        c = await r.text()
        return json.loads(c)['results'][0]['geometry']['location']

inputs = ['London', 'Berlin', 'Milan', 'my plane ticket', 'my keys']

loop = asyncio.get_event_loop()
tasks = [loop.create_task(where(thing)) for thing in inputs]
loop.run_until_complete(asyncio.gather(*tasks))
