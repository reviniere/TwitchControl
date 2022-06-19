TwitchControl relies on a Twitch OAuth authentication token for chat to be present.
For security, it is recommended for the authentication to be for a Twitch user account set up as a bot in your channel, not as yourself.
The bot should be a mod in your channel to not be subject to chat sending limits.

Prerequisites:
1) Minimum Python version 3.7
2) Python library TwitchIO (https://github.com/TwitchIO/TwitchIO), can be installed with: pip install twitchio
3) You must have the StyxScribe mod for Hades installed per the setup steps at https://github.com/SGG-Modding/StyxScribe

Setup steps:
1) Get a Twitch Chat OAuth token from here: https://twitchapps.com/tmi/
2) Update your bot's username, your Twitch channel, and the OAuth token in TwitchControlConfig.json
3) Run modimporter.exe after updating your OAuth token and setting your Twitch username.

How to use:
Once you have met the prerequisites and completed the setup steps, you must run Hades using the subsume_hades.py file added during the StyxScribe installation.
