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

### Format

Chat commands can be used by typing in chat in this format: `!h command value`.

All commands start with `!h`.

e.g. `!h money 100` will give the player 100 gold and `!h money -100` will take 100 gold from the player.

Commands are not case sensitive.

Some commands persist until the end of the run, some will revert as soon as the player leaves the current chamber.

### Cooldown timers

There are cooldown timers per user and per command which are configurable by the streamer.
To see the default values, check [TwitchControlConfig.lua](TwitchControlConfig.lua)

### Commands

| Command | Format | Effect duration | Description |
| --- | --- | --- | --- |
| Add Max Health | `!h AddMaxHealth` | Run | Adds 25 to max health |
| Anti Anvil | `!h AntiAnvil` | Run | Reverse of Anvil of fates (Take two hammer upgrades, add one) |
| Anvil | `!h Anvil` | Run | Uses an Anvil of Fates (Take one hammer upgrade, add two) |
| Assist Add | `!h AssistAdd` | Run | Adds an extra assist usage |
| Assist Allow | `!h AssistAllow` | Encounter | Permits a summon to be used again in this encounter if you have uses remaining |
| Assist Block | `!h AssistBlock` | Encounter | Blocks a summon being used in this encounter even if it was otherwise allowed |
| Bounce Dash | `!h BounceDash` | 60 sec<br>*Streamer*<br>*Configurable* | Bounces the player in the opposite direction of their dash |
| Build Call | `!h BuildCall` | Encounter | Adds one segement to the player's call bar |
| Death Defiance Add | `!h DDAdd` | Run | Adds a death defiance and a new slot if needed |
| Death Defiance Remove | `!h DDRemove` | Run | Removes a death defiance and its slot |
| Drop Boon | `!h DropBoon god` | Encounter | Drops a room reward boon of the specified god.<br>e.g. `!h DropBoon Artemis`<br>Valid gods:<br>* Aphrodite<br>* Ares<br>* Artemis<br>* Athena<br>* Chaos<br>* Demeter<br>* Dionysus<br>* Hermes<br>* Poseidon<br>* Zeus<br> |
| Drop Food | `!h DropFood x` | Encounter | Drops x number of food items, max 6<br>e.g. `!h DropFood 1` |
| Enemies Hit Shields | `!h EnemiesHitShields` | Encounter | Adds max hit shields to all active enemies, and heals them to full health |
| Enemies Invisible | `!h EnemiesInvisible` | 30 sec<br>*Streamer*<br>*Configurable* | Makes all active enemies invisible |
| Enemies Shields | `!h EnemiesShields x` | Encounter | Adds x amount of shield to all active enemies. Max 1000<br>e.g. `!h EnemiesShields 200` |
| Equip Keepsake | `!h EquipKeepsake gifter` | Run | Change the currently equipped keepsake<br>e.g. `!h EquipKeepsake Nyx`<br>Valid gifters you can equip keepsakes from (in order of display in game):<br>* Cerberus<br>* Achilles<br>* Nyx<br>* Thanatos<br>* Charon<br>* Hypnos<br>* Meg<br>* Orpheus<br>* Dusa<br>* Skelly<br>* Zeus<br>* Poseidon<br>* Athena<br>* Aphrodite<br>* Ares<br>* Artemis<br>* Dionysus<br>* Hermes<br>* Demeter<br>* Chaos<br>* Sisyphus<br>* Eurydice<br>* Patroclus<br>* Persephone<br>* Hades |
| Equip Summon | `!h EquipSummon gifter` | Run | Change the currently equipped summon<br>e.g. `!h EquipSummon Skelly`<br>Valid gifters you can equip summons from (in order of display in game):<br>* Meg<br>* Thanatos<br>* Sisyphus<br>* Skelly<br>* Dusa<br>* Achilles |
| Equip Weapon | `!h EquipWeapon weapon` | Run | Change the currently equipped weapon<br>e.g. `!h EquipWeapon ErisRail` or `!h EquipWeapon BeoShield`<br>Valid weapons to equip:<br>* ZagSword<br>* NemSword<br>* PosiSword<br>* ArthSword<br>* ZagSpear<br>* AchSpear<br>* HadesSpear<br>* GySpear<br>* ZagShield<br>* ChaosShield<br>* ZeusShield<br>* BeoShield<br>* ZagBow<br>* ChiBow<br>* HeraBow<br>* RamaBow<br>* ZagFist<br>* TalosFist<br>* DemFist<br>* GilgaFist<br>* ZagRail<br>* ErisRail<br>* HestiaRail<br>* LuciRail |
| Eurydice Nectar | `!h EurydiceNectar` | Run | Gives the player the Eurydice powerup Refreshing Nectar (the next 3 Boons you find have upgraded Rarity) |
| Flashbang | `!h Flashbang` | Encounter | Turns the screen white instantly then fades back to normal over 5 seconds |
| Focus Intensifies | `!h FocusIntensifies` | Encounter | Plays the screen effects and audio from the Cerberus summon |
| Money | `!h Money x` | Run | Gives or takes money from the player. Max gift: 1000. Max take: All of it<br>e.g. `!h Money 100` or `!h Money -100` |
| Pact Down | `!h PactDown pact` | Run | Adjusts a Pact of Punishment condition down a level<br>e.g. `!h PactDown Extrememeasures`<br>Valid pact conditions:<br>* Hardlabor<br>* Lastingconsequences<br>* Conveniencefee<br>* Jurysummons<br>* Extrememeasures<br>* Calisthenics<br>* Benefitspackage<br>* Middlemanagement<br>* Underworldcustoms<br>* Forcedovertime<br>* Heightenedsecurity<br>* Routineinspection<br>* Damagecontrol<br>* Approvalprocess<br>* Tightdeadline |
| Pact Up | `!h PactUp pact` | Run | Adjusts a Pact of Punishment condition up a level<br>e.g. `!h PactUp Forcedovertime`<br>For valid options, see <i>Pact Down</i> |
| Rerolls | `!h Rerolls` | Run | Gives or takes rerolls to the player. Range: 5 to -5<br>e.g. `!h Rerolls 1` or `!h Rerolls -1` |
| Send Dusa Summon | `!h Dusa` | Encounter | Sends the Dusa summon regardless of which summon is equipped |
| Send Skelly Summon | `!h Skelly` | Encounter | Sends the Skelly summon regardless of which summon is equipped |
| Speed | `!h Speed x` | 20 sec<br>*Streamer*<br>*Configurable* | Changes the game speed multiplier for 20 seconds. 1 is normal speed. Higher numbers go faster, lower goes slower. Range: 0.5 to 3<br>e.g. `!h Speed 3` or `!h Speed 0.5` |
| ZagFreeze | `!h ZagFreeze` | 2 sec<br>*Streamer*<br>*Configurable* | Freezes Zag in place for 2 seconds |
| ZagInvulnerable | `!h ZagInvulnerable` | 10 sec<br>*Streamer*<br>*Configurable* | Makes Zag invulnerable for 10 seconds |
| ZagInvisible | `!h ZagInvisible` | 30 sec<br>*Streamer*<br>*Configurable* | Makes Zag invisible for 30 seconds |
| Zoom | `!h Zoom x` | Encounter | Changes zoom level of current room. Valid range: 0.2 to 3.0. 0.2 is way zoomed out, 3.0 is way zoomed in. 1 is default.<br>e.g. `!h Zoom 0.5` or `!h Zoom 1` or `!h Zoom 2.2` |