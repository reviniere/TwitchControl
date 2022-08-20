local TC = TwitchControl

function TC.GetEquippedWeaponAspect()
  for i, currentWeaponData in ipairs(TC.WeaponAspectData) do
    for i, aspectTrait in ipairs(currentWeaponData.Aspects) do
      if HeroHasTrait(aspectTrait.Name) then
        return {
          Weapon = currentWeaponData.Name,
          Aspect = aspectTrait.Name,
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

TC.PactMap = {
  hardlabor = {Name = 'EnemyDamageShrineUpgrade', Max = 5}, 
  lastingconsequences = {Name = 'HealingReductionShrineUpgrade', Max = 4},
  conveniencefee = {Name = 'ShopPricesShrineUpgrade', Max = 2}, 
  jurysummons = {Name = 'EnemyCountShrineUpgrade', Max = 3},
  extrememeasures = {Name = 'BossDifficultyShrineUpgrade', Max = 4},
  calisthenics = {Name = 'EnemyHealthShrineUpgrade', Max = 2},
  benefitspackage = {Name = 'EnemyEliteShrineUpgrade', Max = 2},
  middlemanagement = {Name = 'MinibossCountShrineUpgrade', Max = 2},
  underworldcustoms = {Name = 'ForceSellShrineUpgrade', Max = 1},
  forcedovertime = {Name = 'EnemySpeedShrineUpgrade', Max = 2},
  heightenedsecurity = {Name = 'TrapDamageShrineUpgrade', Max = 1},
  routineinspection = {Name = 'MetaUpgradeStrikeThroughShrineUpgrade', Max = 2},
  damagecontrol = {Name = 'EnemyShieldShrineUpgrade', Max = 1},
  approvalprocess = {Name = 'ReducedLootChoicesShrineUpgrade', Max = 2},
  tightdeadline = {Name = 'BiomeSpeedShrineUpgrade', Max = 3}
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
         [1] = { 
          Name="SwordBaseUpgradeTrait",
          FriendlyName="Zagreus Sword"
         },
         [2] = { 
          Name="SwordCriticalParryTrait",
          FriendlyName="Nemesis Sword"
         },
         [3] = { 
          Name="DislodgeAmmoTrait",
          FriendlyName="Poseidon Sword"
         },
         [4] = { 
          Name="SwordConsecrationTrait",
          FriendlyName="Arthur Sword"
         }
      }
  },
  [2] = {
      Name = "SpearWeapon",
      Aspects = {
          [1] = { 
            Name="SpearBaseUpgradeTrait",
            FriendlyName="Zagreus Spear"
           },
          [2] = { 
            Name="SpearTeleportTrait",
            FriendlyName="Achilles Spear"
           },
          [3] = { 
            Name="SpearWeaveTrait",
            FriendlyName="Hades Spear"
           },
          [4] = { 
            Name="SpearSpinTravel", 
            FriendlyName="Guan Yu Spear"
           }      
      }
  },
  [3] = {
      Name = "ShieldWeapon",
      Aspects = {
          [1] = { 
            Name="ShieldBaseUpgradeTrait",
            FriendlyName="Zagreus Shield"
           },
          [2] = { 
            Name="ShieldRushBonusProjectileTrait",
            FriendlyName="Chaos Shield"
           },
          [3] = { 
            Name="ShieldTwoShieldTrait",
            FriendlyName="Zeus Shield"
           },
          [4] = { 
            Name="ShieldLoadAmmoTrait",
            FriendlyName="Beowulf Shield"
           }
      }
  },
  [4] = {
      Name = "BowWeapon",
      Aspects = {
          [1] = { 
            Name="BowBaseUpgradeTrait",
            FriendlyName="Zagreus Bow"
           },
          [2] = { 
            Name="BowMarkHomingTrait",
            FriendlyName="Chiron Bow"
           },
          [3] = { 
            Name="BowLoadAmmoTrait",
            FriendlyName="Hera Bow"
           },
          [4] = { 
            Name="BowBondTrait",
            FriendlyName="Rama Bow"
           }
      }
  },
  [5] = {
      Name = "FistWeapon",
      Aspects = {
          [1] = { 
            Name="FistBaseUpgradeTrait",
            FriendlyName="Zagreus Fists"
           },
          [2] = { 
            Name="FistVacuumTrait",
            FriendlyName="Talos Fists"
           },
          [3] = { 
            Name="FistWeaveTrait",
            FriendlyName="Demeter Fists"
           },
          [4] = { 
            Name="FistDetonateTrait",
            FriendlyName="Gilgamesh Fists"
           }
      }
  },
  [6] = {
      Name = "GunWeapon",
      Aspects = {
          [1] = { 
            Name="GunBaseUpgradeTrait",
            FriendlyName="Zagreus Rail"
           },
          [2] = { 
            Name="GunGrenadeSelfEmpowerTrait",
            FriendlyName="Eris Rail"
           },
          [3] = { 
            Name="GunManualReloadTrait",
            FriendlyName="Hestia Rail"
           },
          [4] = { 
            Name="GunLoadedGrenadeTrait",
            FriendlyName="Lucifer Rail"
           }
      }
  }
}