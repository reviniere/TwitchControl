ModUtil.Mod.Register( "TwitchControl" )

local TC = TwitchControl

TC.Config = {}
TC.Cooldowns = {
  Functions = {},
  Users = {}
}
TC.Functions = {}
TC.Helpers = {}
TC.Threads = {}

-- Change PrintStack height to take up less screen estate
-- Default PrintStackHeight = 10
ModUtil.Table.Merge( ModUtil.Hades, {
	PrintStackHeight = 2
} )

function TC.Send(message)
  print('Message received: ' .. message)
  local message = string.sub(message, 1, 60) -- Limit max length of messages to avoid people spamming things
  local msg = TC.split(message, ' ')
  local username = table.remove(msg, 1)
  local sentCommand = table.remove(msg, 1)
  local sentFunction = ""
  local args = msg -- After removing username and function, all remaining pieces are arguments

  -- For each command, search case insensitive for matching function.
  local validCommand = nil
  for cmd, func in pairs(TwitchControl.Functions) do
    if (string.lower(cmd) == string.lower(sentCommand)) then
      validCommand = func
      sentFunction = cmd
      local nparams = debug.getinfo(func).nparams
      while TableLength(args) > nparams do
        -- Remove end objects from args until number of args matches number that the function expects
        table.remove(args)
      end
      break
    end
  end

  if validCommand then
    -- Check if user is allowed to trigger commands per cooldown timer
    local userCooldownTimer = TC.Cooldowns.Users[username]
    if userCooldownTimer then
      local userCooldownRemaining = math.ceil(userCooldownTimer - _worldTime)
      if userCooldownRemaining > 0 then
        local plural = 's'
        if userCooldownRemaining == 1 then
          plural = ''
        end
        TC.Reply('@' .. username .. ' You can send another command in ' .. userCooldownRemaining .. ' second' .. plural)
        return
      else
        TC.Cooldowns.Users[username] = nil
      end
    end
    
    -- Check if command is permitted to be used per cooldown timer
    local cmdCooldownTimer = TC.Cooldowns.Functions[sentFunction]
    if cmdCooldownTimer then
      local funcCooldownRemaining = math.ceil(cmdCooldownTimer - _worldTime)
      if funcCooldownRemaining > 0 then
        local plural = 's'
        if funcCooldownRemaining == 1 then
          plural = ''
        end
        TC.Reply('@' .. username .. ' ' .. sentFunction .. ' can be used again in ' .. funcCooldownRemaining .. ' second' .. plural ..'. You can use another command in the meantime.')
        return
      else
        TC.Cooldowns.Functions[sentFunction] = nil
      end
    end

    if CurrentRun.CurrentRoom.Encounter.EncounterType == 'NonCombat' then
      TC.Reply('@' .. username .. ' Commands can only be run in combat rooms, try again in the next room.')
      return
    end

    if TC.BetweenRooms then
      print('Message was received between rooms, trying again soon: ' .. message)
      thread(TC.RetryCommand, message)
      return
    end
    
    local cooldownTime = 0
    if TwitchControl.Config.FunctionCooldowns[sentFunction] then
      cooldownTime = TwitchControl.Config.FunctionCooldowns[sentFunction]
    end

    TC.Cooldowns.Users[username] = _worldTime + TwitchControl.Config.PerUserCooldown
    TC.Cooldowns.Functions[sentFunction] = _worldTime + cooldownTime

    local ret, err = pcall(validCommand, username, table.unpack(args))

    if not err then
      local logLine = username .. " sent " .. sentFunction
      if TableLength(args) > 0 then
        logLine = logLine .. ' : ' .. table.rawconcat(args, ', ')
      end
      ModUtil.Hades.PrintStack(logLine)
    end
  else
    TC.Reply("@" .. username .. " the command '" .. sentCommand .. "' was not found, please try again.")
    return
  end
end

function TC.Reply(msg)
  print("TwitchControl: Reply " .. msg)
end

function TC.RetryCommand(message)
  wait(1.0)
  TC.Send(message)
end

StyxScribe.AddHook(TC.Send, "TwitchControl: ", TwitchControl)
