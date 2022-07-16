local TC = TwitchControl

-- All values below are measured in seconds.
-- If you find these values don't suit your needs, update them here then run modimporter.exe in your Hades/Content directory again to apply the changes.

TC.Config.PerUserCooldown = 10

TC.Config.FunctionTimers = {
  BounceDash = 60,
  EnemiesInvisible = 20,
  Speed = 20,
  ZagFreeze = 2,
  ZagInvisible = 20,
  ZagInvulnerable = 20
}

TC.Config.FunctionCooldowns = {
  AddMaxHealth = 10,
  AntiAnvil = 10,
  Anvil = 10,
  AssistAdd = 10,
  AssistAllow = 10,
  AssistBlock = 10,
  BounceDash = TC.Config.FunctionTimers.BounceDash*1.5,
  BuildCall = 10,
  DDAdd = 5,
  DDRemove = 5,
  DropBoon = 20,
  DropFood = 20,
  Dusa = 20,
  EnemiesHitShields = 10,
  EnemiesInvisible = TC.Config.FunctionTimers.EnemiesInvisible,
  EnemiesShields = 20,
  EquipKeepsake = 20,
  EquipSummon = 20,
  EquipWeapon = 20,
  EurydiceNectar = 30,
  Flashbang = 20,
  FocusIntensifies = 30,
  Money = 20,
  PactDown = 10,
  PactUp = 10,
  Rerolls = 10,
  Skelly = 20,
  Speed = TC.Config.FunctionTimers.Speed*2,
  ZagFreeze = TC.Config.FunctionTimers.ZagFreeze*2,
  ZagInvisible = TC.Config.FunctionTimers.ZagInvisible*1.5,
  ZagInvulnerable = TC.Config.FunctionTimers.ZagInvulnerable*1.5,
  Zoom = 10
}
