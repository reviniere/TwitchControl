## Commands for chat

### Format

Chat commands can be used by typing in chat in this format: `!h command value`.

All commands start with `!h`.

e.g. `!h money 100` will give the player 100 gold and `!h money -100` will take 100 gold from the player.

Commands are not case sensitive.

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
| Drop Food | `!h DropFood` | Encounter | Drops 3 food items |
| Enemies Hit Shields | `!h EnemiesHitShields` | Encounter | Adds max hit shields to all active enemies, and heals them to full health |
| Enemies Invisible | `!h EnemiesInvisible` | 30 sec<br>*Streamer*<br>*Configurable* | Makes all active enemies invisible |
| Equip Keepsake | `!h EquipKeepsake gifter` | Run | Change the currently equipped keepsake<br>e.g. `!h EquipKeepsake Nyx`<br>Valid gifters you can equip keepsakes from (in order of display in game):<br>* Cerberus<br>* Achilles<br>* Nyx<br>* Thanatos<br>* Charon<br>* Hypnos<br>* Meg<br>* Orpheus<br>* Dusa<br>* Skelly<br>* Zeus<br>* Poseidon<br>* Athena<br>* Aphrodite<br>* Ares<br>* Artemis<br>* Dionysus<br>* Hermes<br>* Demeter<br>* Chaos<br>* Sisyphus<br>* Eurydice<br>* Patroclus<br>* Persephone<br>* Hades |
| Equip Summon | `!h EquipSummon gifter` | Run | Change the currently equipped summon<br>e.g. `!h EquipSummon Skelly`<br>Valid gifters you can equip summons from (in order of display in game):<br>* Meg<br>* Thanatos<br>* Sisyphus<br>* Skelly<br>* Dusa<br>* Achilles |
| Eurydice Nectar | `!h EurydiceNectar` | Run | Gives the player the Eurydice powerup Refreshing Nectar (the next 3 Boons you find have upgraded Rarity) |
| Flashbang | `!h Flashbang` | Encounter | Turns the screen white instantly then fades back to normal over 5 seconds |
| Focus Intensifies | `!h FocusIntensifies` | Encounter | Plays the screen effects and audio from the Cerberus summon |
| Money | `!h Money x` | Run | Gives or takes money from the player. Max gift: 1000. Max take: All of it<br>e.g. `!h Money 100` or `!h Money -100` |
| Pact Down | `!h PactDown pact` | Run | Adjusts a Pact of Punishment condition down a level<br>e.g. `!h PactDown Extrememeasures`<br>Valid pact conditions:<br>* Hardlabor<br>* Lastingconsequences<br>* Conveniencefee<br>* Jurysummons<br>* Extrememeasures<br>* Calisthenics<br>* Benefitspackage<br>* Middlemanagement<br>* Underworldcustoms<br>* Forcedovertime<br>* Heightenedsecurity<br>* Routineinspection<br>* Damagecontrol<br>* Approvalprocess<br>* Tightdeadline |
| Pact Up | `!h PactUp pact` | Run | Adjusts a Pact of Punishment condition up a level<br>e.g. `!h PactUp Forcedovertime`<br>For valid options, see <i>Pact Down</i> |
| Rerolls | `!h Rerolls` | Run | Gives or takes rerolls to the player. Range: 5 to -5<br>e.g. `!h Rerolls 1` or `!h Rerolls -1` |
| Random Weapon | `!h RandomWeapon` | Encounter | Randomizes the player's weapon and hammers when they enter the next room |
| Send Dusa Summon | `!h Dusa` | Encounter | Sends the Dusa summon regardless of which summon is equipped |
| Send Skelly Summon | `!h Skelly` | Encounter | Sends the Skelly summon regardless of which summon is equipped |
| Speed | `!h Speed x` | 20 sec<br>*Streamer*<br>*Configurable* | Changes the game speed multiplier for 20 seconds. 1 is normal speed. Higher numbers go faster, lower goes slower. Range: 0.5 to 3<br>e.g. `!h Speed 3` or `!h Speed 0.5` |
| ZagFreeze | `!h ZagFreeze` | 2 sec<br>*Streamer*<br>*Configurable* | Freezes Zag in place for 2 seconds |
| ZagInvulnerable | `!h ZagInvulnerable` | 10 sec<br>*Streamer*<br>*Configurable* | Makes Zag invulnerable for 10 seconds |
| ZagInvisible | `!h ZagInvisible` | 30 sec<br>*Streamer*<br>*Configurable* | Makes Zag invisible for 30 seconds |
| Zoom | `!h Zoom x` | Encounter | Changes zoom level of current room. Valid range: 0.2 to 3.0. 0.2 is way zoomed out, 3.0 is way zoomed in. 1 is default.<br>e.g. `!h Zoom 0.5` or `!h Zoom 1` or `!h Zoom 2.2` |
