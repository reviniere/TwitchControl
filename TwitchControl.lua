ModUtil.Mod.Register( "TwitchControl" )

TwitchControl.Functions = {}
TwitchControl.Threads = {}

-- Change PrintStack height to take up less screen estate
-- Default PrintStackHeight = 10
ModUtil.Table.Merge( ModUtil.Hades, {
	PrintStackHeight = 2
} )

function TwitchControl.Send(message)
  ModUtil.DebugPrint('Message received: ' .. message)
  message = string.sub(message, 1, 60) -- Limit max length of messages to avoid people spamming things
  message = string.gsub(message, '[^0-9a-zA-Z ._-]', '') -- filter message to whitelisted characters
  msg = split(message, ' ')
  username = table.remove(msg, 1)
  sentCommand = table.remove(msg, 1)
  sentFunction = ""
  args = msg -- After removing username and function, all remaining pieces are arguments

  -- For each command, search case insensitive for matching function.
  local validCommand = nil
  for cmd, func in pairs(TwitchControl.Functions) do
    if (string.lower(cmd) == string.lower(sentCommand)) then
      validCommand = func
      sentFunction = cmd
      nparams = debug.getinfo(func).nparams
      while TableLength(args) > nparams do
        -- Remove end objects from args until number of args matches number that the function expects
        table.remove(args)
      end
      break
    end
  end

  if validCommand then
    local ret, err = pcall(validCommand, table.unpack(args))

    if not err then
      -- Print notification on screen of who did what
      -- Only print notification after function successfully called, don't notify any which fail
      local logLine = username .. " sent " .. sentFunction
      if TableLength(args) > 0 then
        logLine = logLine .. ' : ' .. table.concat(args, ', ')
      end
      ModUtil.Hades.PrintStack(logLine)

      ------------------------- TODO: Send reply back to Twitch chat with @ of person who sent message if applicable
    end
  else
    ModUtil.DebugPrint("Debug:: TwitchControl: Reply @" .. username .. " the command '" .. sentCommand .. "'was not found, please try again.")
    print("TwitchControl: Reply @" .. username .. " the command '" .. sentCommand .. "' was not found, please try again.")
    --------------------------- TODO: Send reply back to Twitch chat saying invalid command
    return
  end
end

function TwitchControl.Functions.AddMaxHealth()
  AddMaxHealth(25, "Twitch")
end

function TwitchControl.Functions.Anvil()
  ChaosHammerUpgrade()
end

function TwitchControl.Functions.AssistAllow()
  CurrentRun.CurrentRoom.UsedAssist = false
end

function TwitchControl.Functions.AssistBlock()
  CurrentRun.CurrentRoom.UsedAssist = true
end

function TwitchControl.Functions.AssistMore()
  for i, traitData in pairs( CurrentRun.Hero.Traits ) do
    if traitData.AddAssist then
      traitData.RemainingUses = traitData.RemainingUses + 1
    end
  end
  HideTraitUI()
  ShowTraitUI()
end

function TwitchControl.Functions.BuildCall()
  BuildSuperMeter(CurrentRun, CurrentRun.Hero.SuperMeterLimit)
end

function TwitchControl.Functions.DropBoon(god)
  -- Valid gods: Aphrodite, Ares, Artemis, Athena, Chaos, Demeter, Dionysus, Hermes, Poseidon, Zeus
  godMap = {
    aphrodite = "AphroditeUpgrade",
    ares = "AresUpgrade",
    artemis = "ArtemisUpgrade",
    athena = "AthenaUpgrade",
    chaos = "TrialUpgrade",
    demeter = "DemeterUpgrade",
    dionysus = "DionysusUpgrade",
    hermes = "HermesUpgrade",
    poseidon = "PoseidonUpgrade",
    zeus = "ZeusUpgrade"
  }
  loot = godMap[string.lower(god)]
  if loot then
    CreateLoot({Name = loot, OffsetX = 100})
  else
    -------------------------- TODO: Error output, list valid gods
    ModUtil.DebugPrint('God ' .. god .. ' is not a valid option')
  end
end

function TwitchControl.Functions.DropFood(amount)
  if not amount then
    amount = 1
  end
  for i=0,math.min(math.max(amount-1,0), 6) do 
    DropHealth( "HealDropRange", CurrentRun.Hero.ObjectId, 300, random()*6, true ) 
  end
end

function TwitchControl.Functions.EnemiesHitShields()
  for id, enemy in pairs( ActiveEnemies ) do
    enemy.HitShields = enemy.MaxHitShields
    Heal(enemy, {HealFraction=1})
  end
end

function TwitchControl.Functions.EnemiesInvisible()
  for i, enemy in pairs( ActiveEnemies ) do
    SetAlpha({Id = i, Fraction = 0, Duration = 0.5})
  end
end

function TwitchControl.Functions.EnemiesShields(amount)
  amount = math.min(math.max(0,amount),1000)
  for id, enemy in pairs( ActiveEnemies ) do
    enemy.HealthBuffer = amount
    Heal(enemy, {HealFraction=1})
  end
end

function TwitchControl.Functions.EnemiesVisible()
  for i, enemy in pairs( ActiveEnemies ) do
    SetAlpha({Id = i, Fraction = 1, Duration = 0.5})
  end
end

function TwitchControl.Functions.Flashbang()
  FadeOut({Color = Color.White, Duration = 0})
  FadeIn({Duration = 5})
end

function TwitchControl.Functions.FocusIntensifies()
  DoCerberusAssistPresentation()
end

function TwitchControl.Functions.GiveEuridiceNectar()
  AddSuperRarityBoost()
end

function TwitchControl.Functions.Money(amount)
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

function TwitchControl.Functions.Rerolls(amount)
  amount = math.max(math.min(amount,5), -5)
  AddRerolls(amount, "Twitch", { IgnoreMetaUpgrades = true })
end

function TwitchControl.Functions.SendDusa()
  DusaAssist({Duration=10})
end

function TwitchControl.Functions.SendSkelly()
  SkellyAssist()
end

function TwitchControl.Functions.Summon(newSummon)
  -- Valid summons: Meg, Thanatos, Sisyphus, Skelly, Dusa, Achilles
  summonMap = {
    meg = "FuryAssistTrait",
    thanatos = "ThanatosAssistTrait",
    sisyphus = "SisyphusAssistTrait",
    skelly = "SkellyAssistTrait",
    dusa = "DusaAssistTrait",
    achilles = "AchillesPatroclusAssistTrait"
  }
  summonName = string.lower(newSummon)
  if summonMap[summonName] then
    for i, traitData in pairs( CurrentRun.Hero.Traits ) do
      if traitData.AddAssist then
        UnequipAssist(CurrentRun.Hero, traitData.Title)
      end
    end
    EquipAssist(CurrentRun.Hero, summonMap[summonName])
  else
    --------------------------------- TODO: Return message stating invalid argument, with valid options listed
    ModUtil.DebugPrint('Invalid summon requested')
  end
end

function TwitchControl.Functions.ZagFreeze()
  FreezePlayerUnit('Twitch')
  ModUtil.Hades.PrintOverhead("Frozen", 2)
  thread( TwitchControl.Threads.ZagUnfreeze )
end

function TwitchControl.Threads.ZagUnfreeze()
  wait( 2.0 )
  ModUtil.Hades.PrintOverhead("Unfrozen", 2)
  UnfreezePlayerUnit('Twitch')
end

function TwitchControl.Functions.ZagInvulnerable()
  SetPlayerInvulnerable('Twitch')
end

function TwitchControl.Functions.ZagInvisible()
  SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 0, Duration = 0.5 })
end

function TwitchControl.Functions.ZagVulnerable()
  SetPlayerVulnerable('Twitch')
end

function TwitchControl.Functions.ZagVisible()
  SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1, Duration = 0.5 })
end

function TwitchControl.Functions.Zoom(fraction)
  AdjustZoom({Fraction = math.max(0.2,math.min(3, fraction)), LerpTime = 0.4})
end

function split(pString, pPattern)
  local Table = {}
  local fpat = "(.-)" .. pPattern
  local last_end = 1
  local s, e, cap = pString:find(fpat, 1)
  while s do
     if s ~= 1 or cap ~= "" then
    table.insert(Table,cap)
     end
     last_end = e+1
     s, e, cap = pString:find(fpat, last_end)
  end
  if last_end <= #pString then
     cap = pString:sub(last_end)
     table.insert(Table, cap)
  end
  return Table
end

StyxScribe.AddHook(TwitchControl.Send, "TwitchControl: ", TwitchControl)