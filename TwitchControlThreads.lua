local TC = TwitchControl

function TC.Threads.AntiAnvilPresentation( traitsRemoved, traitsAdded )
  local offsetY = -80
  for _, traitRemoved in pairs( traitsRemoved ) do
    CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
    thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilRemove_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitRemoved }})
    wait(0.75)
    offsetY = offsetY - 60
  end
  for _, traitName in pairs( traitsAdded ) do
    PlaySound({ Name = "/SFX/WeaponUpgradeHammerPickup", DestinationId = CurrentRun.Hero.ObjectId })
    CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
    thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilAdd_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
    wait(0.75)
    offsetY = offsetY - 60
  end
end

OnControlPressed{ "Rush",
  function (args)
    thread(TwitchControl.Threads.Dash)
  end
}

function TC.Threads.Dash()
  if TwitchControl.BounceDash then
    local currentAngle = GetPlayerAngle()
    wait(0.25)
    ApplyForce({Id = CurrentRun.Hero.ObjectId, Speed = 2000, MaxSpeed = 2000, Angle = currentAngle + 180})
  end
end

function TC.Threads.BounceDashDisable()
  wait(TwitchControl.Config.FunctionTimers.BounceDash)
  TwitchControl.BounceDash = false
  ModUtil.Hades.PrintOverhead("Bounce Disabled", 2)
end

function TC.Threads.EnableInput(args)
  args = args or {}
  local input = args.input
  local inputDesc = args.inputDesc
  local delay = args.delaySeconds or 10
  wait(delay)
  ModUtil.Hades.PrintOverhead("Enabled " .. TC.Helpers.titleize(inputDesc), 2)
  ToggleControl({Names = {input}, Enabled = true})
end

function TC.Threads.EnemiesVisible()
  wait(TwitchControl.Config.FunctionTimers.EnemiesInvisible)
  for i, enemy in pairs( ActiveEnemies ) do
    SetAlpha({Id = i, Fraction = 1, Duration = 0.5})
  end
end

function TC.Threads.SimulationSpeed()
  while TwitchControl.speed do
    AdjustSimulationSpeed({Fraction = TwitchControl.speed, LerpTime = 0})
    wait(0.05)
    if TwitchControl.speedExpiresAt <= _worldTime then
      break
    end
  end
  AdjustSimulationSpeed({Fraction = 1, LerpTime = 0.25})
  ModUtil.Hades.PrintOverhead("Normal Speed", 1.5)
end

function TC.Threads.ZagUnfreeze()
  wait( TwitchControl.Config.FunctionTimers.ZagFreeze )
  ModUtil.Hades.PrintOverhead("Unfrozen", 2)
  UnfreezePlayerUnit('Twitch')
end

function TC.Threads.ZagVisible()
  wait(TwitchControl.Config.FunctionTimers.ZagInvisible)
  SetAlpha({ Id = CurrentRun.Hero.ObjectId, Fraction = 1, Duration = 0.5 })
end

function TC.Threads.ZagVulnerable()
  wait(TwitchControl.Config.FunctionTimers.ZagInvulnerable)
  SetPlayerVulnerable('Twitch')
  ModUtil.Hades.PrintOverhead("Vulnerable", 2)
end