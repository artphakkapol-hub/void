-- modules/registry.lua — Lazy tab module registry
-- Returns: tabHandlers (ordered list), categoryHandlers (id → render fn)
--
-- Tab modules are NOT loaded here. Each is loaded exactly once, the first
-- time its tab is opened by the user. This keeps startup allocation flat
-- regardless of how many tabs/features exist.
--
-- To add a tab:
--   1. Append an entry to TAB_DEFS.
--   2. Create the corresponding file in modules/tabs/.
--   3. Add icons to _TAB_ICONS in ui/ui.lua

local TAB_DEFS = {
    -- { id, display_name }
    { "account", "ACCOUNT MENU" },
    { "player", "PLAYER MENU" },
    { "adventure", "ADVENTURE MENU" },
    { "cups", "CUPS MENU" },
    { "team", "TEAM MENU" },
    { "event", "EVENT MENU" },
    { "creative", "CREATIVE MENU" },
    { "shop", "SHOP MENU" },
    { "other", "OTHER MENU" },
    { "settings", "SETTINGS" },
    { "about", "ABOUT" },
}

local loaded      = {}   -- id → render function (cached after first load)
local tabHandlers = {}

for _, def in ipairs(TAB_DEFS) do
    tabHandlers[#tabHandlers + 1] = def
end

-- categoryHandlers[id](container) — called by ui.lua when a tab is first rendered.
-- Loads the tab file lazily and delegates to the returned render function.
local categoryHandlers = {}

for _, def in ipairs(TAB_DEFS) do
    local id   = def[1]
    local path = "modules/tabs/" .. id .. ".lua"

    categoryHandlers[id] = function(container)
        if not loaded[id] then
            local ok, result = pcall(function() return loadModule(path) end)
            if ok and type(result) == "function" then
                loaded[id] = result
            else
                -- Surface load errors as a read-only card so the rest of the UI stays alive.
                addModule(container, id .. "_err", id,
                    "Load error: " .. tostring(result), "ro", "Error", nil)
                return
            end
        end
        loaded[id](container)
    end
end

return tabHandlers, categoryHandlers
