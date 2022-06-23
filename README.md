# Twitch Control for Hades

## Setup for Streamers

TwitchControl relies on a Twitch OAuth authentication token for chat to be present.
For security, it is recommended for the authentication to be for a Twitch user account set up as a bot in your channel, not as yourself.
The bot should be a mod in your channel to not be subject to chat sending limits.

These steps assume you've already set up modimporter and have ModUtil.

### Prerequisites
1) Minimum Python version 3.7
2) Python library [TwitchIO](https://github.com/TwitchIO/TwitchIO), can be installed with: `pip install twitchio`
3) You must have the [StyxScribe](https://github.com/SGG-Modding/StyxScribe) mod for Hades

### Setup steps
1) Get a [Twitch Chat OAuth token](https://twitchapps.com/tmi/)
2) Update your bot's username, your Twitch channel, and the OAuth token in **TwitchControlConfig.json**
3) Run `modimporter.exe` after updating your OAuth token and setting your Twitch username.

### How to use
Once you have met the prerequisites and completed the setup steps, you must run Hades using the subsume_hades.py file added during the StyxScribe installation.

## Commands for chat

### Format

Chat commands can be used by typing in chat in this format: `!hades command value`

e.g. `!hades money 100` will give the player 100 gold and `!hades money -100` will take 100 gold from the player.

Commands are not case sensitive.

Some commands persist until the end of the run, some will revert as soon as the player leaves the current chamber.

### Commands

| Command | Format | Per run/encounter | Description |
| --- | --- | --- | --- |
| AddMaxHealth | `!hades AddMaxHealth` | Run | Adds 25 to max health |
| AntiAnvil | `!hades AntiAnvil` | Run | Reverse of Anvil of fates (Take two hammer upgrades, add one) |
| Anvil | `!hades Anvil` | Run | Uses an Anvil of Fates (Take one hammer upgrade, add two) |
| AssistAdd | `!hades AssistAdd` | Run | Adds an extra assist usage |
| AssistAllow | `!hades AssistAllow` | Encounter | Permits a summon to be used again in this encounter if you have uses remaining |
| AssistBlock | `!hades AssistBlock` | Encounter | Blocks a summon being used in this encounter even if it was otherwise allowed |
| BuildCall | `!hades BuildCall` | Encounter | Adds one segement to the player's call bar |
| DeathDefianceAdd | `!hades DeathDefianceAdd` | Run | Adds a death defiance and a new slot if needed |
| DeathDefianceRemove | `!hades DeathDefianceRemove` | Run | Removes a death defiance and its slot |
| DropBoon | `!hades DropBoon god` | Encounter | Drops a room reward boon of the specified god.<br>e.g. `!hades DropBoon Artemis`<br>Valid gods:<br>* Aphrodite<br>* Ares<br>* Artemis<br>* Athena<br>* Chaos<br>* Demeter<br>* Dionysus<br>* Hermes<br>* Poseidon<br>* Zeus<br> |
| DropFood | `!hades DropFood x` | Encounter | Drops x number of food items, max 6<br>e.g. `!hades DropFood 1` |
| EnemiesHitShields | `!hades EnemiesHitShields` | Encounter | Adds max hit shields to all active enemies, and heals them to full health |
| EnemiesInvisible | `!hades EnemiesInvisible` | Encounter | Makes all active enemies invisible |
| EnemiesShields | `!hades EnemiesShields x` | Encounter | Adds x amount of shield to all active enemies. Max 1000<br>e.g. `!hades EnemiesShields 200` |
| EnemiesVisible | `!hades EnemiesVisible` | Encounter | Makes all active enemies visible |
| EquipKeepsake | `!hades EquipKeepsake gifter` | Run | Change the currently equipped keepsake<br>e.g. `!hades EquipKeepsake Nyx`<br>Valid gifters you can equip keepsakes from (in order of display in game):<br>* Cerberus<br>* Achilles<br>* Nyx<br>* Thanatos<br>* Charon<br>* Hypnos<br>* Meg<br>* Orpheus<br>* Dusa<br>* Skelly<br>* Zeus<br>* Poseidon<br>* Athena<br>* Aphrodite<br>* Ares<br>* Artemis<br>* Dionysus<br>* Hermes<br>* Demeter<br>* Chaos<br>* Sisyphus<br>* Eurydice<br>* Patroclus<br>* Persephone<br>* Hades |
| EquipSummon | `!hades EquipSummon gifter` | Run | Change the currently equipped summon<br>e.g. `!hades EquipSummon Skelly`<br>Valid gifters you can equip summons from (in order of display in game):<br>* Meg<br>* Thanatos<br>* Sisyphus<br>* Skelly<br>* Dusa<br>* Achilles |
| Flashbang | `!hades Flashbang` | Encounter | Turns the screen white instantly then fades back to normal over 5 seconds |
| FocusIntensifies | `!hades FocusIntensifies` | Encounter | Plays the screen effects and audio from the Cerberus summon |
| GiveEurydiceNectar | `!hades GiveEurydiceNectar` | Run | Gives the player the Eurydice powerup Refreshing Nectar (the next 3 Boons you find have upgraded Rarity) |
| Money | `!hades Money x` | Run | Gives or takes money from the player. Max gift: 1000. Max take: All of it<br>e.g. `!hades Money 100` or `!hades Money -100` |
| Rerolls | `!hades Rerolls` | Run | Gives or takes rerolls to the player. Range: 5 to -5<br>e.g. `!hades Rerolls 1` or `!hades Rerolls -1` |
| SendDusa | `!hades SendDusa` | Encounter | Sends the Dusa summon regardless of which summon is equipped |
| SendSkelly | `!hades SendSkelly` | Encounter | Sends the Skelly summon regardless of which summon is equipped |
| ZagFreeze | `!hades ZagFreeze` | Encounter | Freezes Zag in place for 2 seconds |
| ZagInvulnerable | `!hades ZagInvulnerable` | Encounter | Makes Zag invulnerable |
| ZagInvisible | `!hades ZagInvisible` | Encounter | Makes Zag invisible |
| ZagVulnerable | `!hades ZagVulnerable` | Encounter | Makes Zag vulnerable (only has an effect if he was made invulnerable earlier in this encounter) |
| ZagVisible | `!hades ZagVisible` | Encounter | Makes Zag visible (only has an effect if he was made invisible earlier in this encounter) |
| Zoom | `!hades Zoom x` | Encounter | Changes zoom level of current room. Valid range: 0.2 to 3.0. 0.2 is way zoomed out, 3.0 is way zoomed in. 1 is default.<br>e.g. `!hades Zoom 0.5` or `!hades Zoom 1` or `!hades Zoom 2.2` |