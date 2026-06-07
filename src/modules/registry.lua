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
        -- Already failed before, show error card and bail
        if loaded[id] == false then
            addModule(container, id .. "_err", id,
                "Module failed to load. Check logs for details.", "ro", "Error", nil)
            return
        end

        -- Load if not yet attempted
        if not loaded[id] then
            local ok, result = pcall(loadModule, path)

            if ok and type(result) == "function" then
                loaded[id] = result
                LOG.info("Loader", "Module loaded OK: " .. id)
            else
                LOG.error("Loader", "Failed to load module [" .. id .. "]: " .. tostring(result))
                loaded[id] = false  -- mark as permanently failed, not nil
                addModule(container, id .. "_err", id,
                    "Module failed to load. Check logs for details.", "ro", "Error", nil)
                return
            end
        end

        -- Execute with its own pcall so a runtime crash doesn't take down the whole UI
        local ok, err = pcall(loaded[id], container)
        if not ok then
            LOG.error("Loader", "Runtime error in module [" .. id .. "]: " .. tostring(err))
            addModule(container, id .. "_err", id,
                "Runtime error: " .. tostring(err), "ro", "Error", nil)
        end
    end
end

return tabHandlers, categoryHandlers
