local TC = TwitchControl

function TC.Functions.AddMaxHealth()
  AddMaxHealth(25, "Twitch")
end

function TC.Functions.Anvil(username)
  TwitchControl.Functions.AntiAnvil(username, {NumNewTraits = 2, NumRemovedTraits = 1})
end

function TC.Functions.AntiAnvil(username, args)
  args = args or {}
	local hammerTraits = {}
	local addedTraits = {}
  local numRemovedTraits = args.NumRemovedTraits or 2
	local numNewTraits = args.NumNewTraits or 1
	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if LootData.WeaponUpgrade.TraitIndex[trait.Name] then
			table.insert(hammerTraits, trait.Name )
		end
	end

	local removedTraitNames = {}
  for i = 1 , numRemovedTraits do
    if not IsEmpty( hammerTraits ) then
      removedTraitName = RemoveRandomValue( hammerTraits )
      table.insert(removedTraitNames, removedTraitName)
      RemoveWeaponTrait( removedTraitName )
    end
  end

	for i = 1, numNewTraits do
		local validTraitNames = {}
		for i, traitName in pairs( LootData.WeaponUpgrade.Traits ) do
			if IsTraitEligible(CurrentRun, TraitData[traitName]) and not Contains(removedTraitNames, traitName) and not Contains(hammerTraits, traitName) then
				table.insert( validTraitNames, traitName )
			end
		end

		if not IsEmpty( validTraitNames ) then
			local newTraitName = RemoveRandomValue( validTraitNames )
			AddTraitToHero({ TraitName =  newTraitName })
			table.insert( hammerTraits, newTraitName )
			table.insert( addedTraits, newTraitName )
		end
	end
		
	thread( TwitchControl.Threads.AntiAnvilPresentation, removedTraitNames, addedTraits )
end

function TC.Functions.AssistAdd()
  for i, traitData in pairs( CurrentRun.Hero.Traits ) do
    if traitData.AddAssist then
      traitData.RemainingUses = traitData.RemainingUses + 1
    end
  end
  HideTraitUI()
  ShowTraitUI()
end

function TC.Functions.AssistAllow()
  CurrentRun.CurrentRoom.UsedAssist = false
end

function TC.Functions.AssistBlock()
  CurrentRun.CurrentRoom.UsedAssist = true
end

function TC.Functions.BounceDash()
  TwitchControl.BounceDash = true
  ModUtil.Hades.PrintOverhead("Bounce Enabled", 2)
  thread( TwitchControl.Threads.BounceDashDisable )
end
function TC.Functions.DashBounce()
  TC.Functions.BounceDash()
end

function TC.Functions.BuildCall()
  BuildSuperMeter(CurrentRun, CurrentRun.Hero.SuperMeterLimit)
end

function TC.Functions.DDAdd()
  local atMaxLastStands = CurrentRun.Hero.MaxLastStands == TableLength(CurrentRun.Hero.LastStands)
  AddLastStand({
    IncreaseMax = atMaxLastStands,
    Silent = true,
    WeaponName = 'LastStandMetaUpgradeShield',
    Icon = "ExtraLifeHeart",
    HealFraction = 0.5
  })
  UpdateLifePips()
end
function TC.Functions.DDUp()
  TC.Functions.DDAdd()
end

function TC.Functions.DDRemove()
  if CurrentRun.Hero.MaxLastStands > 0 then
    CurrentRun.Hero.MaxLastStands = CurrentRun.Hero.MaxLastStands - 1
  end
  if TableLength(CurrentRun.Hero.LastStands) > 0 then
    LostLastStandPresentation()
    RemoveLastStand()
    UpdateLifePips()
  end
end
function TC.Functions.DDDown()
  TC.Functions.DDRemove()
end


-- Removed Disable Input until investigated for bugfix, it seems to cause a crash a few seconds after it's called. Possibly something to do with the enable thread?
-- | Disable Input | `!h Disable x` | 10 sec | Disables a specified input for 10 seconds.<br>e.g. `!h DisableInput Attack`<br>Input options:<br>* Attack<br>* Special<br>* Cast<br>* Dash<br>* Call<br>* Summon |
--
-- function TC.Functions.Disable(username, input)
--   if not input then
--     TC.Reply('Input must be specified. Valid inputs: Attack, Special, Cast, Dash, Call, Summon')
--     return
--   end
--   inputMap = {
--     attack = 'Attack2',
--     special = 'Attack3',
--     cast = 'Attack1',
--     dash = 'Rush',
--     call = 'Shout',
--     summon = 'Assist'
--   }
--   local disableInput = inputMap[string.lower(input)]
--   local delaySec = 10
--   if disableInput then
--     ModUtil.Hades.PrintOverhead("Disabled " .. TC.titleize(input), 2)
--     ToggleControl({Names = {disableInput}, Enabled = false})
--     thread(TwitchControl.Threads.EnableInput, {input = disableInput, inputDesc = input, delaySeconds = delaySec})
--   else
--     TC.Reply('@' .. username .. ' Input type not found. Valid inputs: Attack, Special, Cast, Dash, Call, Summon')
--   end
-- end

function TC.Functions.DropBoon(username, god)
  -- Valid gods: Aphrodite, Ares, Artemis, Athena, Chaos, Demeter, Dionysus, Hermes, Poseidon, Zeus
  loot = TC.BoonMap[string.lower(god)]
  if loot then
    CreateLoot({Name = loot, OffsetX = 100})
  else
    validGods = {}
    for god,upgrade in pairs(TC.BoonMap) do
      table.insert(validGods, TC.titleize(god))
    end
    TC.Reply('@' .. username .. ' God ' .. god .. ' not valid. Valid options: ' .. table.rawconcat(validGods, ', '))
  end
end
function TC.Functions.Boon(username, god)
  TC.Functions.DropBoon(username, god)
end

function TC.Functions.DropFood(username, amount)
  if not amount then
    amount = 1
  end
  for i=0,math.min(math.max(amount-1,0), 6) do 
    DropHealth( "HealDropRange", CurrentRun.Hero.ObjectId, 300, random()*6, true ) 
  end
end
function TC.Functions.Food(username, amount)
  TC.Functions.DropFood(username, amount)
end

function TC.Functions.Dusa()
  DusaAssist({Duration=10})
end

function TC.Functions.EnemiesHitShields()
  for id, enemy in pairs( ActiveEnemies ) do
    enemy.HitShields = enemy.MaxHitShields
    Heal(enemy, {HealFraction=1})
  end
end

function TC.Functions.EnemiesInvisible()
  for i, enemy in pairs( ActiveEnemies ) do
    SetAlpha({Id = i, Fraction = 0, Duration = 0.5})
  end
  thread( TwitchControl.Threads.EnemiesVisible )
end

function TC.Functions.EnemiesShields(username, amount)
  amount = math.min(math.max(0,amount),1000)
  for id, enemy in pairs( ActiveEnemies ) do
    enemy.HealthBuffer = amount
    Heal(enemy, {HealFraction=1})
  end
end
function TC.Functions.EnemyShields(username, amount)
  TC.Functions.EnemiesShields(username, amount)
end

function TC.Functions.EquipKeepsake(username, newKeepsake)
  
  local newKeepsakeName = TC.KeepsakeMap[string.lower(newKeepsake)]
  if newKeepsakeName then
    local currentKeepsake = nil
    for i,trait in pairs(CurrentRun.Hero.Traits) do
      if trait.Slot == 'Keepsake' then
        currentKeepsake = trait.Title
      end
    end
    if currentKeepsake then
      UnequipKeepsake(CurrentRun.Hero, currentKeepsake)
      if currentKeepsake == "ReincarnationTrait" or currentKeepsake == "HadesShoutKeepsake" then
        HideHealthUI()
        ShowHealthUI()
      end
    end
    EquipKeepsake(CurrentRun.Hero, newKeepsakeName, {})
  else
    validGifters = {}
    for gifter,trait in pairs(TC.KeepsakeMap) do
      table.insert(validGifters, TC.titleize(gifter))
    end
    TC.Reply('@' .. username .. ' Keepsake ' .. TC.titleize(newKeepsake) .. ' not valid. Valid options: ' .. table.rawconcat(validGifters, ', '))
  end
end
function TC.Functions.Keepsake(username, newKeepsake)
  TC.Functions.EquipKeepsake(username, newKeepsake)
end

function TC.Functions.EquipSummon(username, newSummon)
  -- Valid summons: Meg, Thanatos, Sisyphus, Skelly, Dusa, Achilles
  local summonName = string.lower(newSummon)
  if TC.SummonMap[summonName] then
    for i, traitData in pairs( CurrentRun.Hero.Traits ) do
      if traitData.AddAssist then
        UnequipAssist(CurrentRun.Hero, traitData.Title)
      end
    end
    EquipAssist(CurrentRun.Hero, TC.SummonMap[summonName])
  else
    validSummons = {}
    for summoner,trait in pairs(TC.SummonMap) do
      table.insert(validSummons, TC.titleize(summoner))
    end
    TC.Reply('@' .. username .. ' Summon ' .. TC.titleize(newSummon) .. ' not valid. Valid options: ' .. table.rawconcat(validSummons, ', '))
  end
end
function TC.Functions.Summon(username, newSummon)
  TC.Functions.EquipSummon(username, newSummon)
end

function TC.Functions.EquipWeapon(username, newWeapon)
  local currentWeapon = TC.GetEquippedWeaponAspect()
  local newWeaponData = TC.WeaponMap[string.lower(newWeapon)]
  if newWeaponData then
    RemoveTrait(CurrentRun.Hero, currentWeapon.Aspect)
    EquipPlayerWeapon( WeaponData[newWeaponData.Weapon], { PreLoadBinks = true } )
    AddTraitToHero({ TraitName = newWeaponData.Aspect, Rarity = "Legendary" })
  else
    validWeapons = {}
    for weapon,trait in pairs(TC.WeaponMap) do
      table.insert(validWeapons, TC.titleize(weapon))
    end
    TC.Reply('@' .. username .. ' Weapon ' .. TC.titleize(newWeapon) .. ' not valid. Valid options: ' .. table.rawconcat(validWeapons, ', '))
  end
end
function TC.Functions.Weapon(username, newWeapon)
  TC.Functions.EquipWeapon(username, newWeapon)
end

function TC.Functions.Flashbang()
  FadeOut({Color = Color.White, Duration = 0})
  FadeIn({Duration = 5})
end

function TC.Functions.FocusIntensifies()
  DoCerberusAssistPresentation()
end

function TC.Functions.EurydiceNectar()
  AddSuperRarityBoost()
end

function TC.Functions.Money(username, amount)
  amount = tonumber(amount)
  if amount > 0 then
    -- Cap max money at 1000 per gift
    local max_amount = 1000
    GushMoney({Delay = 0, Amount = math.min(math.max(amount,0),max_amount), LocationId = CurrentRun.Hero.ObjectId, Source = "Twitch"})
  else
    -- Don't allow spending more than you have.
    -- Negative money results in a softlock, you can't collect room rewards because you "can't afford them".
    local max_amount = CurrentRun.Money
    SpendMoney(math.min(math.max(amount*-1,0), max_amount), "Twitch")
  end
end

function TC.Functions.PactDown(username, pact)
  adjustPact = TC.PactMap[string.lower(pact)]
  if adjustPact then
    currentPact = GameState.MetaUpgrades[adjustPact.Name]
    if currentPact > 0 then
      GameState.MetaUpgrades[adjustPact.Name] = GameState.MetaUpgrades[adjustPact.Name] - 1
      BuildMetaupgradeCache()
      GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
      UpdateActiveShrinePoints()
    else
      TC.Reply('@' .. username .. ' Pact ' .. TC.titleize(pact) .. ' is already at 0.')
    end
  else
    validPacts = {}
    for pactCondition,pactOptions in pairs(TC.PactMap) do
      table.insert(validPacts, TC.titleize(pactCondition))
    end
    TC.Reply('@' .. username .. ' Pact ' .. TC.titleize(pact) .. ' not valid. Valid options: ' .. table.rawconcat(validPacts, ', '))
  end
end

function TC.Functions.PactUp(username, pact)
  adjustPact = TC.PactMap[string.lower(pact)]
  if adjustPact then
    currentPact = GameState.MetaUpgrades[adjustPact.Name]
    if currentPact < adjustPact.Max then
      GameState.MetaUpgrades[adjustPact.Name] = GameState.MetaUpgrades[adjustPact.Name] + 1
      BuildMetaupgradeCache()
      GameState.SpentShrinePointsCache = GetTotalSpentShrinePoints()
      UpdateActiveShrinePoints()
    else
      TC.Reply('@' .. username .. ' Pact ' .. TC.titleize(pact) .. ' is already at max.')
    end
  else
    validPacts = {}
    for pactCondition,pactOptions in pairs(TC.PactMap) do
      table.insert(validPacts, TC.titleize(pactCondition))
    end
    TC.Reply('@' .. username .. ' Pact ' .. TC.titleize(pact) .. ' not valid. Valid options: ' .. table.rawconcat(validPacts, ', '))
  end
end

function TC.Functions.Rerolls(username, amount)
  amount = math.max(math.min(amount,5), -5)
  AddRerolls(amount, "Twitch", { IgnoreMetaUpgrades = true })
end
function TC.Functions.Reroll(username, amount)
  TC.Functions.Rerolls(username, amount)
end

function TC.Functions.Skelly()
  SkellyAssist()
end

-- SpawnBoss and SpawnMiniboss functions work, but I don't want them active until I find a way to balance them more fairly.
-- Perhaps only allowing bosses from the previous biomes, meaning in Tartarus it won't work, and in future ones it'll only bring back past bosses.
-- Currently it could spawn a boss with far more health than the player's current build is designed to deal with, which isn't fun.
--
-- function TC.Functions.SpawnBoss()
--   local bosses = { 
--     "Charon",
--     "Harpy", 
--     "Harpy2", 
--     "Harpy3", 
--     "Minotaur",
--     "Minotaur2", 
--     "Theseus" 
--   }
--   local boss = RemoveRandomValue( bosses )
--   local enemyData = EnemyData[boss]
--   if enemyData then
--     local newEnemy = DeepCopyTable( enemyData )
--     newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
--     SetupEnemyObject( newEnemy, CurrentRun, { SkipSpawnVoiceLines = true } )
--     UseableOff({ Id = newEnemy.ObjectId })
--   end
-- end

-- function TC.Functions.SpawnMiniboss()
--   local minibosses = {
--     "HeavyRangedForkedMiniboss",
--     "HeavyRangedSplitterMiniboss",
--     "MedusaShadowMiniboss",
--     "ShieldRangedMiniBoss",
--     "SpreadShotUnitMiniboss",
--     "ThiefImpulseMineLayerMiniboss",
--     "WretchAssassinMiniboss"
--   }
--   local miniboss = RemoveRandomValue( minibosses )
--   local enemyData = EnemyData[miniboss]
--   if enemyData then
--     local newEnemy = DeepCopyTable( enemyData )
--     newEnemy.ObjectId = SpawnUnit({ Name = enemyData.Name, Group = "Standing", DestinationId = CurrentRun.Hero.ObjectId, OffsetX = 0, OffsetY = 0 })
--     SetupEnemyObject( newEnemy, CurrentRun, { SkipSpawnVoiceLines = true } )
--     UseableOff({ Id = newEnemy.ObjectId })
--   end
-- end

function TC.Functions.Speed(username, amount)
  amount = tonumber(amount)
  if amount then
    amount = math.min(math.max(amount,0.5),3)
    ModUtil.Hades.PrintOverhead("Speed Change", 1.5*amount)
    TwitchControl.speedExpiresAt = _worldTime + (TwitchControl.Config.FunctionTimers.Speed*amount)
  else
    TC.Reply('@' .. username .. ' Speed amount not a valid number. Please try again.')
  end
  TwitchControl.speed = amount
  thread( TwitchControl.Threads.SimulationSpeed )
end

function TC.Functions.ZagFreeze()
  FreezePlayerUnit('Twitch')
  ModUtil.Hades.PrintOverhead("Frozen", 2)
  thread( TwitchControl.Threads.ZagUnfreeze )
end

function TC.Functions.ZagInvulnerable()
  SetPlayerInvulnerable('Twitch')
  ModUtil.Hades.PrintOverhead("Invulnerable for 10s", 2)
  thread( TwitchControl.Threads.ZagVulnerable )
end

function TC.Functions.ZagInvisible()
  SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.5 })
  thread(TwitchControl.Threads.ZagVisible )
end

function TC.Functions.Zoom(username, fraction)
  AdjustZoom({Fraction = math.max(0.2,math.min(3, fraction)), LerpTime = 0.4})
end