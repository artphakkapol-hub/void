--[[
  Cups Tab - Cup racing modes
  Features: Auto-win races
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    local autoWinPatches = {
        {scan = "h E8 5F 5B A9 15 61 40 B9", offset = 4, patch = "h 55 00 80 52", unpatch = "h 15 61 40 B9"},
        {scan = "h E8 2B 40 F9 0A 4D 40 BD", offset = 4, patch = "h 0A 90 32 1E", unpatch = "h 0A 4D 40 BD"},
        {scan = "h 00 00 48 42 00 00 40 40 00 00 C8 42", offset = 4, patch = "h 00 00 00 00", unpatch = "h 00 00 40 40"},
    }

    --addArchModule(container, "auto_win", "Auto Win", "Automatically win no matter what your race results is", "switch", nil, autoWinPatches)
end
