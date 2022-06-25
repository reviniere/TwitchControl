local TC = TwitchControl

function TC.GetEquippedWeaponAspect()
  for i, weaponData in ipairs(TC.WeaponAspectData) do
      for i, aspectTrait in ipairs(weaponData.Aspects) do
          if HeroHasTrait(aspectTrait) then
              return {
                  Weapon = weaponData.Name,
                  Aspect = aspectTrait,
              }
          end
      end
  end 
end

function TC.split(pString, pPattern)
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

function TC.titleize(str)
  return string.lower(str).gsub(" "..str, "%W%l", string.upper):sub(2)
end

TC.BoonMap = {
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

TC.KeepsakeMap = {
  cerberus = "MaxHealthKeepsakeTrait",
  achilles = "DirectionalArmorTrait",
  nyx = "BackstabAlphaStrikeTrait",
  thanatos = "PerfectClearDamageBonusTrait",
  charon = "ShopDurationTrait",
  hypnos = "BonusMoneyTrait",
  meg = "LowHealthDamageTrait",
  orpheus = "DistanceDamageTrait",
  dusa = "LifeOnUrnTrait",
  skelly = "ReincarnationTrait",
  zeus = "ForceZeusBoonTrait",
  poseidon = "ForcePoseidonBoonTrait",
  athena = "ForceAthenaBoonTrait",
  aphrodite = "ForceAphroditeBoonTrait",
  ares = "ForceAresBoonTrait",
  artemis = "ForceArtemisBoonTrait",
  dionysus = "ForceDionysusBoonTrait",
  hermes = "FastClearDodgeBonusTrait",
  demeter = "ForceDemeterBoonTrait",
  chaos = "ChaosBoonTrait",
  sisyphus = "VanillaTrait",
  eurydice = "ShieldBossTrait",
  patroclus = "ShieldAfterHitTrait",
  persephone = "ChamberStackTrait",
  hades = "HadesShoutKeepsake"
}

TC.SummonMap = {
  meg = "FuryAssistTrait",
  thanatos = "ThanatosAssistTrait",
  sisyphus = "SisyphusAssistTrait",
  skelly = "SkellyAssistTrait",
  dusa = "DusaAssistTrait",
  achilles = "AchillesPatroclusAssistTrait"
}

TC.WeaponMap = {
  zagsword = {Weapon="SwordWeapon",Aspect="SwordBaseUpgradeTrait"},
  nemsword = {Weapon="SwordWeapon",Aspect="SwordCriticalParryTrait"},
  posisword = {Weapon="SwordWeapon",Aspect="DislodgeAmmoTrait"},
  arthsword = {Weapon="SwordWeapon",Aspect="SwordConsecrationTrait"},
  zagspear = {Weapon="SpearWeapon",Aspect="SpearBaseUpgradeTrait"},
  achspear = {Weapon="SpearWeapon",Aspect="SpearTeleportTrait"},
  hadesspear = {Weapon="SpearWeapon",Aspect="SpearWeaveTrait"},
  gyspear = {Weapon="SpearWeapon",Aspect="SpearSpinTravel"},
  zagshield = {Weapon="ShieldWeapon",Aspect="ShieldBaseUpgradeTrait"},
  chaosshield = {Weapon="ShieldWeapon",Aspect="ShieldRushBonusProjectileTrait"},
  zeusshield = {Weapon="ShieldWeapon",Aspect="ShieldTwoShieldTrait"},
  beoshield = {Weapon="ShieldWeapon",Aspect="ShieldLoadAmmoTrait"},
  zagbow = {Weapon="BowWeapon",Aspect="BowBaseUpgradeTrait"},
  chibow = {Weapon="BowWeapon",Aspect="BowMarkHomingTrait"},
  herabow = {Weapon="BowWeapon",Aspect="BowLoadAmmoTrait"},
  ramabow = {Weapon="BowWeapon",Aspect="BowBondTrait"},
  zagfist = {Weapon="FistWeapon",Aspect="FistBaseUpgradeTrait"},
  talosfist = {Weapon="FistWeapon",Aspect="FistVacuumTrait"},
  demfist = {Weapon="FistWeapon",Aspect="FistWeaveTrait"},
  gilgafist = {Weapon="FistWeapon",Aspect="FistDetonateTrait"},
  zagrail = {Weapon="GunWeapon",Aspect="GunBaseUpgradeTrait"},
  erisrail = {Weapon="GunWeapon",Aspect="GunGrenadeSelfEmpowerTrait"},
  hestiarail = {Weapon="GunWeapon",Aspect="GunManualReloadTrait"},
  lucirail = {Weapon="GunWeapon",Aspect="GunLoadedGrenadeTrait"}
}

TC.WeaponAspectData = {
  [1] = {
      Name = "SwordWeapon",
      Aspects = {
         [1] = "SwordBaseUpgradeTrait",
         [2] = "SwordCriticalParryTrait",
         [3] = "DislodgeAmmoTrait",
         [4] = "SwordConsecrationTrait",
      }
  },
  [2] = {
      Name = "SpearWeapon",
      Aspects = {
          [1] = "SpearBaseUpgradeTrait",
          [2] = "SpearTeleportTrait",
          [3] = "SpearWeaveTrait",
          [4] = "SpearSpinTravel",            
      }
  },
  [3] = {
      Name = "ShieldWeapon",
      Aspects = {
          [1] = "ShieldBaseUpgradeTrait",
          [2] = "ShieldRushBonusProjectileTrait",
          [3] = "ShieldTwoShieldTrait",
          [4] = "ShieldLoadAmmoTrait",
      }
  },
  [4] = {
      Name = "BowWeapon",
      Aspects = {
          [1] = "BowBaseUpgradeTrait",
          [2] = "BowMarkHomingTrait",
          [3] = "BowLoadAmmoTrait",
          [4] = "BowBondTrait",
      }
  },
  [5] = {
      Name = "FistWeapon",
      Aspects = {
          [1] = "FistBaseUpgradeTrait",
          [2] = "FistVacuumTrait",
          [3] = "FistWeaveTrait",
          [4] = "FistDetonateTrait",
      }
  },
  [6] = {
      Name = "GunWeapon",
      Aspects = {
          [1] = "GunBaseUpgradeTrait",
          [2] = "GunGrenadeSelfEmpowerTrait",
          [3] = "GunManualReloadTrait",
          [4] = "GunLoadedGrenadeTrait",
      }
  },
}