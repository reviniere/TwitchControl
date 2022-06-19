ModUtil.Mod.Register( "TwitchControl" )

TwitchControl.Functions = {}

-- Change PrintStack height to take up less screen estate
-- Default PrintStackHeight = 10
ModUtil.Table.Merge( ModUtil.Hades, {
	PrintStackHeight = 2
} )

function TwitchControl.Send(message)
  ModUtil.DebugPrint('Message received: ' .. message)
  message = string.sub(message, 1, 60) -- Limit max length of messages to avoid people spamming things
  message = string.gsub(message, '[^0-9a-zA-Z _-]', '') -- filter message to whitelisted characters
  msg = split(message, ' ')
  username = table.remove(msg, 1)
  sentCommand = table.remove(msg, 1)
  args = msg -- After removing username and function, all remaining pieces are arguments

  -- For each command, search case insensitive for matching function.
  local validCommand = nil
  for cmd, func in pairs(TwitchControl.Functions) do
    if (string.lower(cmd) == string.lower(sentCommand)) then
      validCommand = func
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
      local logLine = username .. " sent " .. sentCommand
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