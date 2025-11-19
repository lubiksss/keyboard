-- Credit for this implementation goes to @arbelt and @jasoncodes 🙇⚡️😻
--
--   https://gist.github.com/arbelt/b91e1f38a0880afb316dd5b5732759f1
--   https://github.com/jasoncodes/dotfiles/blob/ac9f3ac/hammerspoon/control_escape.lua
keyUpDown = function(modifiers, key)
  -- Un-comment & reload config to log each keystroke that we're triggering
  -- log.d('Sending keystroke:', hs.inspect(modifiers), key)

  hs.eventtap.keyStroke(modifiers, key, 0)
end

sendEscape = false
lastMods = {}

ctrlKeyHandler = function()
  sendEscape = false
end

ctrlKeyTimer = hs.timer.delayed.new(0.20, ctrlKeyHandler)

ctrlHandler = function(evt)
  local newMods = evt:getFlags()
  if lastMods["ctrl"] == newMods["ctrl"] then
    return false
  end
  if not lastMods["ctrl"] then
    lastMods = newMods
    sendEscape = true
    ctrlKeyTimer:start()
  else
    if sendEscape then
      keyUpDown({}, 'escape')
    end
    lastMods = newMods
    ctrlKeyTimer:stop()
  end
  return false
end

ctrlTap = hs.eventtap.new({hs.eventtap.event.types.flagsChanged}, ctrlHandler)
ctrlTap:start()

otherHandler = function(evt)
  sendEscape = false
  return false
end

otherTap = hs.eventtap.new({hs.eventtap.event.types.keyDown}, otherHandler)
otherTap:start()
