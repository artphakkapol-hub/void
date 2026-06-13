-- modules/registry.lua — Lazy tab module registry
-- Returns: tabHandlers (ordered list), categoryHandlers (id → render fn)
--
-- Tab modules are NOT loaded here. Each is loaded exactly once, the first
-- time its tab is opened by the user. This keeps startup allocation flat
-- regardless of how many tabs or features exist.
--
-- To add a tab:
--   1. Append an entry to TAB_DEFS.
--   2. Create the corresponding file in modules/tabs/.
--   3. Add icons to _TAB_ICONS in ui/ui.lua.

local TAB_DEFS = {
    -- { id, display_name }
    { "separator", "GAME MENU" },
    { "account", "ACCOUNT MENU" },
    { "player", "PLAYER MENU" },
    { "adventure", "ADVENTURE MENU" },
    { "cups", "CUPS MENU" },
    { "team", "TEAM MENU" },
    { "event", "EVENT MENU" },
    { "creative", "CREATIVE MENU" },
    { "shop", "SHOP MENU" },
    { "other", "OTHER MENU" },
    { "separator", "SCRIPT MENU" },
    { "settings", "SETTINGS" },
    { "about", "ABOUT" },
}

-- tabHandlers: ordered list of { id, display_name } used by ui.lua for the sidebar.
local tabHandlers = {}
for _, def in ipairs(TAB_DEFS) do
    tabHandlers[#tabHandlers + 1] = def
end

-- loadCache: id → render function on success, false on permanent failure.
local loadCache = {}

-- categoryHandlers[id](container) — called by ui.lua when a tab is first rendered.
-- Lazily loads the tab file and delegates to its returned render function.
local categoryHandlers = {}

for _, def in ipairs(TAB_DEFS) do
    local id   = def[1]
    local path = "modules/tabs/" .. id .. ".lua"

    categoryHandlers[id] = function(container)
        -- Previously failed — show a permanent error card.
        if loadCache[id] == false then
            addModule(container, id .. "_err", id,
                "Module failed to load. Check logs for details.", "ro", "Error", nil)
            return
        end

        -- First access: attempt to load.
        if not loadCache[id] then
            local ok, result = pcall(loadModule, path)

            if ok and type(result) == "function" then
                loadCache[id] = result
                LOG.info("Registry", "Module loaded OK: " .. id)
            else
                LOG.error("Registry", "Failed to load module [" .. id .. "]: " .. tostring(result))
                loadCache[id] = false
                addModule(container, id .. "_err", id,
                    "Module failed to load. Check logs for details.", "ro", "Error", nil)
                return
            end
        end

        -- Run the module; isolate crashes so they don't bring down the whole UI.
        local ok, err = pcall(loadCache[id], container)
        if not ok then
            LOG.error("Registry", "Runtime error in module [" .. id .. "]: " .. tostring(err))
            addModule(container, id .. "_err", id,
                "Runtime error: " .. tostring(err), "ro", "Error", nil)
        end
    end
end

return tabHandlers, categoryHandlers
