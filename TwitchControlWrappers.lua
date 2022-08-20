local TC = TwitchControl

function TC.Helpers.RandomizeWeapon()
  local currentWeapon = TC.GetEquippedWeaponAspect()
  local newWeaponData = GetRandomValue( TC.WeaponAspectData )
  local newWeaponAspect = GetRandomValue( newWeaponData.Aspects )
  if newWeaponData then
    RemoveTrait(CurrentRun.Hero, currentWeapon.Aspect)
    EquipPlayerWeapon( WeaponData[newWeaponData.Name], { PreLoadBinks = true } )
    AddTraitToHero({ TraitName = newWeaponAspect.Name, Rarity = "Legendary" })
    ModUtil.Hades.PrintOverhead("Equipped " .. newWeaponAspect.FriendlyName, 2)
  end
end

function TC.Helpers.ReplaceAnvils()
  local hammerTraits = {}
	local addedTraits = {}
  local numTraits = 0

	for i, trait in pairs( CurrentRun.Hero.Traits ) do
		if LootData.WeaponUpgrade.TraitIndex[trait.Name] then
			table.insert(hammerTraits, trait.Name )
      numTraits = numTraits + 1
		end
	end

	local removedTraitNames = {}
  for i = 1 , numTraits do
    if not IsEmpty( hammerTraits ) then
      removedTraitName = RemoveRandomValue( hammerTraits )
      table.insert(removedTraitNames, removedTraitName)
      RemoveWeaponTrait( removedTraitName )
    end
  end

	for i = 1, numTraits do
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
		
	thread( TC.ReplaceAnvilsPresentation, removedTraitNames, addedTraits )
end

function TC.ReplaceAnvilsPresentation( traitsRemoved, traitsAdded )
  wait(0.5)
  local offsetY = -80
  for _, traitRemoved in pairs( traitsRemoved ) do
    CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
    thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilRemove_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitRemoved }})
    wait(0.1)
    offsetY = offsetY - 60
  end
  wait(1.5)
  for _, traitName in pairs( traitsAdded ) do
    PlaySound({ Name = "/SFX/WeaponUpgradeHammerPickup", DestinationId = CurrentRun.Hero.ObjectId })
    CreateAnimation({ Name = "ItemGet_PomUpgraded", DestinationId = CurrentRun.Hero.ObjectId, Scale = 2.0 })
    thread( InCombatTextArgs, { TargetId = CurrentRun.Hero.ObjectId, Text = "ChaosAnvilAdd_CombatText", SkipRise = false, SkipFlash = false, ShadowScale = 0.75, OffsetY = offsetY, Duration = 1.5, LuaKey = "TempTextData", LuaValue = { Name = traitName }})
    wait(0.1)
    offsetY = offsetY - 60
  end
end

ModUtil.Path.Wrap( "LeaveRoom",
  function ( base, ... )
    if (TC.RandomWeapon) then
      TC.Helpers.RandomizeWeapon()
    end
    TC.BetweenRooms = true
    base(...)
  end
)

ModUtil.Path.Wrap( "StartRoom", 
  function ( base, ... )
    if (TC.RandomWeapon) then
      TC.Helpers.ReplaceAnvils()
      TC.RandomWeapon = false
    end
    TC.BetweenRooms = false
    base(...)
  end
)