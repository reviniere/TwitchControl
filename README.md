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

####   > AddMaxHealth

`!hades AddMaxHealth`

*Per run*

Adds 25 to max health

####   > Anvil
`!hades Anvil`

*Per run*

Uses an Anvil of Fates

####   > AssistAdd
`!hades AssistAdd`

*Per run*

Adds an extra assist usage

####   > AssistAllow
`!hades AssistAllow`

*Per encounter*

Permits a summon to be used again in this encounter if you have uses remaining

####   > AssistBlock
`!hades AssistBlock`

*Per encounter*

Blocks a summon being used in this encounter even if it was otherwise allowed

####   > BuildCall
`!hades BuildCall`

*Per encounter*

Adds one segement to the player's call bar

####   > DeathDefianceAdd
`!hades DeathDefianceAdd`

*Per run*

Adds a death defiance and a new slot if needed

####   > DeathDefianceRemove
`!hades DeathDefianceRemove`

*Per run*

Removes a death defiance and its slot

####   > DropBoon
`!hades DropBoon god`

*Per encounter*

Drops a room reward boon of the specified god.

e.g. `!hades DropBoon Artemis`

Valid gods:
* Aphrodite
* Ares
* Artemis
* Athena
* Chaos
* Demeter
* Dionysus
* Hermes
* Poseidon
* Zeus

####   > DropFood
`!hades DropFood x`

*Per encounter*

Drops x number of food items, max 6.

e.g. `!hades DropFood 1`

####   > EnemiesHitShields
`!hades EnemiesHitShields`

*Per encounter*

Adds max hit shields to all active enemies, and heals them to full health

####   > EnemiesInvisible
`!hades EnemiesInvisible`

*Per encounter*

Makes all active enemies invisible

####   > EnemiesShields
`!hades EnemiesShields x`

*Per encounter*

Adds x amount of shield to all active enemies. Max 1000

e.g. `!hades EnemiesShields 200`

####   > EnemiesVisible
`!hades EnemiesVisible`

*Per encounter*

Makes all active enemies visible

####   > EquipKeepsake
`!hades EquipKeepsake gifter`

*Per run*

Change the currently equipped keepsake

e.g. `!hades EquipKeepsake Nyx`

Valid gifters you can equip keepsakes from (in order of display in game):
* Cerberus
* Achilles
* Nyx
* Thanatos
* Charon
* Hypnos
* Meg
* Orpheus
* Dusa
* Skelly
* Zeus
* Poseidon
* Athena
* Aphrodite
* Ares
* Artemis
* Dionysus
* Hermes
* Demeter
* Chaos
* Sisyphus
* Eurydice
* Patroclus
* Persephone
* Hades

####   > EquipSummon
`!hades EquipSummon gifter`

*Per run*

Change the currently equipped summon

e.g. `!hades EquipSummon Skelly`

Valid gifters you can equip summons from (in order of display in game):
* Meg
* Thanatos
* Sisyphus
* Skelly
* Dusa
* Achilles

####   > Flashbang
`!hades Flashbang`

*Per encounter*

Turns the screen white instantly then fades back to normal

####   > FocusIntensifies
`!hades FocusIntensifies`

*Per encounter*

Plays the screen effects and audio from the Cerberus summon

####   > GiveEurydiceNectar
`!hades GiveEurydiceNectar`

*Per run*

Gives the player the Eurydice powerup Refreshing Nectar (the next 3 Boons you find have upgraded Rarity)

####   > Money
`!hades Money x`

*Per run*

Gives or takes money from the player. Max gift: 1000. Max take: All of it

e.g. `!hades Money 100` or `!hades Money -100`

####   > Rerolls
`!hades Rerolls x`

*Per run*

Gives or takes rerolls to the player. Range: 5 to -5

e.g. `!hades Rerolls 1` or `!hades Rerolls -1`

####   > SendDusa
`!hades SendDusa`

*Per encounter*

Sends the Dusa summon regardless of which summon is equipped

####   > SendSkelly
`!hades SendSkelly`

*Per encounter*

Sends the Skelly summon regardless of which summon is equipped

####   > ZagFreeze
`!hades ZagFreeze`

*Per encounter*

Freezes Zag in place for 2 seconds

####   > ZagInvulnerable
`!hades ZagInvulnerable`

*Per encounter*

Makes Zag invulnerable

####   > ZagInvisible
`!hades ZagInvisible`

*Per encounter*

Makes Zag invisible

####   > ZagVulnerable
`!hades ZagVulnerable`

*Per encounter*

Makes Zag vulnerable (only has an effect if he was made invulnerable earlier in this encounter)

####   > ZagVisible
`!hades ZagVisible`

*Per encounter*

Makes Zag visible (only has an effect if he was made invisible earlier in this encounter)

####   > Zoom
`!hades Zoom x`

*Per encounter*

Changes zoom level of current room. Valid range: 0.2 to 3.0. 0.2 is way zoomed out, 3.0 is way zoomed in. 1 is default.

e.g. `!hades Zoom 0.5` or `!hades Zoom 1` or `!hades Zoom 2.2`