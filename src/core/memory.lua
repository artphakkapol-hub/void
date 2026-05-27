--[[
  Persistent memory handler module
  Manages saving and loading of game state data tied to the current process.
  Automatically detects process switches and clears stale data.
]]

local File = import("java.io.File")

local memory = {
    ---Checks if the current GameGuardian session is still attached to the same process.
    ---Returns false if process changed (and clears old data), true if session is valid.
    ---@return boolean True if session is valid, false if process changed
    _checkSession = function(self)
        local target = gg.getTargetInfo()
        if not target then return false end

        local currentPid = target.pid
        local pidFile = gg.FILES_DIR .. "/" .. target.packageName

        local oldPid
        local f = io.open(pidFile, "r")
        if f then
            oldPid = tonumber(f:read("*all"))
            f:close()
        end

        if oldPid ~= currentPid then
            self.clearAll()
            f = io.open(pidFile, "w")
            if f then
                f:write(tostring(currentPid))
                f:close()
            end
            return false
        end
        return true
    end,

    ---Saves data to persistent storage for the current target package.
    ---@param id string Unique identifier for this data (e.g. "gamestatus", "toggle_states")
    ---@param data any The data to save (tables are serialized)
    ---@return boolean True if save succeeded, false otherwise
    save = function(self, id, data)
        self:_checkSession()
        local target = gg.getTargetInfo()
        if not (target and data) then return false end

        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local f = io.open(filePath, "w")
        if f then
            ---@local Recursively serializes a table to Lua table syntax
            local function serialize(t)
                local s = "{"
                for k, v in pairs(t) do
                    local key = type(k) == "number" and "["..k.."]" or string.format("[%q]", k)
                    local value = type(v) == "table" and serialize(v) or (type(v) == "string" and string.format("%q", v) or tostring(v))
                    s = s .. key .. "=" .. value .. ","
                end
                return s .. "}"
            end
            f:write("return " .. serialize(data))
            f:close()
            return true
        end
        return false
    end,

    ---Loads previously saved data from persistent storage.
    ---Returns nil if session changed or data doesn't exist.
    ---@param id string Unique identifier for the data to load
    ---@return any The loaded data, or nil if not found or session invalid
    load = function(self, id)
        if not self:_checkSession() then return nil end

        local target = gg.getTargetInfo()
        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local chunk = loadfile(filePath)
        return chunk and chunk() or nil
    end,

    ---Clears all saved data files for the current target package.
    ---Called automatically when process changes.
    ---@return nil
    clearAll = function()
        local target = gg.getTargetInfo()
        if not target then return end
        local prefix = target.packageName .. "-memoryHandlers-"
        local directory = File(gg.FILES_DIR)
        local files = directory:listFiles()
        if files then
            for i = 1, #files do
                local file = files[i]
                if file:getName():find(prefix, 1, true) == 1 then
                    file:delete()
                end
            end
        end
    end
}

return memory
