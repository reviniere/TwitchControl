import json
import os
import threading
from twitchio.ext import commands

StyxScribePrefix = 'TwitchControl: '

class Bot(commands.Bot):
  def __init__(self):
    config = None
    with open(os.path.relpath('Content/StyxScribeScripts/TwitchControlConfig.json')) as f:
      config = json.load(f)
    self.default_channel = config['joinChannel']
    super().__init__(token=config['oauthToken'], prefix='!', initial_channels=[self.default_channel])
    scribe.add_hook(self.handle_reply, StyxScribePrefix + "Reply", __name__)
    scribe.ignore_prefixes.append(StyxScribePrefix)

  async def event_ready(self):
    print(f'Twitch Bot logged in as: {self.nick} to channel {self.default_channel}')

  def handle_reply(self, s):
    print('Handle reply')
    print(s)
    channel = self.get_channel(self.default_channel)
    #await channel.send(s)

  @commands.command()
  async def hades(self, ctx: commands.Context):
    msg = ctx.message.content
    cmd = msg.replace('!hades ','')
    scribe.send(StyxScribePrefix + ctx.author.name + ' ' + cmd)
    #await ctx.send(f'Hey {ctx.author.name}!')

def load():
  bot = Bot()
  th = threading.Thread(target=bot.run)
  th.start()
