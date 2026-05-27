--[[
  Settings Tab - Script settings
  Features: Display current memory range, gamestatus address
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    local getRegionName = function()
        if BaseRegion == -2080896 then return "O: Other"
        elseif BaseRegion == 4 then return "Ca: C++ alloc"
        else return "U: Unknown" end
    end

    addModule(container, "memory_range",       "Memory Range",   "Current selected memory range",       "ro", getRegionName(),                              nil)
    addModule(container, "gamestatus_address",  "GameStatus",     "Current loaded gamestatus address",   "ro", string.format("0x%X", BaseGameStatus),        nil)
end
