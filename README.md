# Twitch Control for Hades

* Twitch viewers can send commands in chat which will update the game state live
* Your Twitch bot can respond with helpful error messages
* Includes built-in configurable per-user and per-command cooldown timers

**For viewers looking for the list of available commands, scroll to the bottom of this page.**

## Credits

<b>Author:</b> Reviniere (come say hi on [Twitch](https://twitch.tv/reviniere), especially let me know if you're going to stream with this mod, I'd love to stop by)
<br><b>Lots of input from:</b> [MagicGonads](https://github.com/MagicGonads), this mod also wouldn't have been possible without all his work building StyxScribe.
<br><b>Weapon data:</b> [CGull's RunStartControl](https://github.com/cgu11/RunStartControl)


## Setup for Streamers

TwitchControl relies on a Twitch OAuth authentication token for chat to be present.
For security, it is recommended for the authentication to be for a Twitch user account set up as a bot in your channel, not as yourself.
The bot should be a mod in your channel to not be subject to chat sending limits.

These steps assume you've already set up modimporter and have ModUtil.

### Prerequisites
1) Minimum Python version 3.7
2) Python library [TwitchIO](https://github.com/TwitchIO/TwitchIO), can be installed with: `pip install twitchio`
3) You must have [ModImporter](https://github.com/SGG-Modding/ModImporter/releases) in your Hades/Content directory
4) You must have [ModUtil](https://github.com/SGG-Modding/ModUtil/releases/) in your Hades/Content/Mods folder
5) You must have the latest [StyxScribe](https://github.com/SGG-Modding/StyxScribe) mod for Hades installed

### Setup steps
1) Get a [Twitch Chat OAuth token](https://twitchapps.com/tmi/)
2) Update your bot's username, your Twitch channel, and the OAuth token in **TwitchControlConfig.json**
3) Place a copy of all the mod files in this repository in folder: Hades/Content/Mods/TwitchControl
4) Run `modimporter.exe` after updating your OAuth token and setting your Twitch username.

### Cooldown timer configuration changes
1) Update the cooldown timers listed in the TwitchControlConfig.lua file.
2) Run `modimporter.exe` again after making configuration changes to apply them.

### How to use
Once you have met the prerequisites and completed the setup steps, you must run Hades using the SubsumeHades.py file added during the StyxScribe installation.

## Commands for chat
[Go here](https://github.com/reviniere/TwitchControl/blob/main/Commands.md) for information about what commands are available and how to use them.
