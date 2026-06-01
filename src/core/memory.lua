--[[
  Persistent memory handler module
  Manages saving and loading of game state data.

  Two storage scopes:
    Process-scoped  (save / load)       — tied to the current target PID.
                                          Data is wiped automatically when
                                          the process changes (game restart).
    Global-scoped   (saveGlobal / loadGlobal) — PID-independent; survives
                                          across restarts. Intended for user
                                          preferences such as UI colors that
                                          should never be cleared by a process
                                          switch.
]]

local File = import("java.io.File")

-- Shared serializer used by both save scopes.
-- Handles tables (recursively), strings, and scalar values.
local function serialize(v)
    if type(v) == "table" then
        local s = "{"
        for k, val in pairs(v) do
            local key = type(k) == "number" and "[" .. k .. "]" or string.format("[%q]", k)
            s = s .. key .. "=" .. serialize(val) .. ","
        end
        return s .. "}"
    elseif type(v) == "string" then
        return string.format("%q", v)
    else
        return tostring(v)
    end
end

local memory = {
    -- ── Process-scoped helpers ────────────────────────────────────────────────

    ---Checks whether the current GG session is still attached to the same PID.
    ---Clears all process-scoped data automatically when the process changes.
    ---@return boolean True if session is valid (same PID), false if it changed.
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
            self:clearAll()
            f = io.open(pidFile, "w")
            if f then
                f:write(tostring(currentPid))
                f:close()
            end
            return false
        end
        return true
    end,

    ---Saves data to process-scoped persistent storage.
    ---Keyed by package name + PID; automatically invalidated on process change.
    ---@param id string Unique identifier (e.g. "gamestatus", "toggle_states")
    ---@param data any Data to persist (tables are serialized recursively)
    ---@return boolean True if the write succeeded
    save = function(self, id, data)
        self:_checkSession()
        local target = gg.getTargetInfo()
        if not (target and data ~= nil) then return false end

        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local f = io.open(filePath, "w")
        if f then
            f:write("return " .. serialize(data))
            f:close()
            return true
        end
        return false
    end,

    ---Loads previously saved process-scoped data.
    ---Returns nil if the session changed or the data file does not exist.
    ---@param id string Unique identifier for the data to load
    ---@return any Loaded data, or nil
    load = function(self, id)
        if not self:_checkSession() then return nil end

        local target = gg.getTargetInfo()
        if not target then return nil end
        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local chunk = loadfile(filePath)
        return chunk and chunk() or nil
    end,

    ---Deletes all process-scoped data files for the current package.
    ---Called automatically when a PID change is detected.
    ---@return nil
    clearAll = function(self)
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
    end,

    -- ── Global-scoped helpers ─────────────────────────────────────────────────

    ---Saves data to global persistent storage.
    ---Not tied to any process or package; survives game restarts and
    ---process switches. Intended for user preferences (UI colors, etc.).
    ---@param id string Unique identifier (e.g. "ui_prefs")
    ---@param data any Data to persist (tables are serialized recursively)
    ---@return boolean True if the write succeeded
    saveGlobal = function(self, id, data)
        if data == nil then return false end
        local filePath = gg.FILES_DIR .. "/void-global-" .. id
        local f = io.open(filePath, "w")
        if f then
            f:write("return " .. serialize(data))
            f:close()
            return true
        end
        return false
    end,

    ---Loads previously saved global data.
    ---Returns nil if the file does not exist or cannot be parsed.
    ---@param id string Unique identifier for the data to load
    ---@return any Loaded data, or nil
    loadGlobal = function(self, id)
        local filePath = gg.FILES_DIR .. "/void-global-" .. id
        local chunk = loadfile(filePath)
        return chunk and chunk() or nil
    end,
}

return memory
