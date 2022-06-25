ModUtil.Mod.Register( "TwitchControl" )

local TC = TwitchControl

TC.Functions = {}
TC.Helpers = {}
TC.Threads = {}

-- Change PrintStack height to take up less screen estate
-- Default PrintStackHeight = 10
ModUtil.Table.Merge( ModUtil.Hades, {
	PrintStackHeight = 2
} )

StyxScribe.AddHook(TwitchControl.Send, "TwitchControl: ", TwitchControl)

function TC.Send(message)
  ModUtil.DebugPrint('Message received: ' .. message)
  message = string.sub(message, 1, 60) -- Limit max length of messages to avoid people spamming things
  msg = TC.Helpers.split(message, ' ')
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
    local ret, err = pcall(validCommand, username, table.unpack(args))

    if not err then
      local logLine = username .. " sent " .. sentFunction
      if TableLength(args) > 0 then
        logLine = logLine .. ' : ' .. table.concat(args, ', ')
      end
      ModUtil.Hades.PrintStack(logLine)
    end
  else
    ModUtil.DebugPrint("Debug:: TwitchControl: Reply @" .. username .. " the command '" .. sentCommand .. "'was not found, please try again.")
    TC.Reply("@" .. username .. " the command '" .. sentCommand .. "' was not found, please try again.")
    return
  end
end

function TC.Reply(msg)
  print("TwitchControl: Reply " .. msg)
end