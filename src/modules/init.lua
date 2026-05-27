--[[
  Init Module - Initializes the UI by registering tabs and their handlers.
  
  @module returns tabHandlers, categoryHandlers
    tabHandlers: List of {id, displayName} for each tab, used to build the UI.
    categoryHandlers: Map of id to handler function for each tab, called to populate the tab's content.
]]

local tabHandlers = {
    {"account",   "ACCOUNT MENU"   },
    {"player",    "PLAYER MENU"    },
    {"adventure", "ADVENTURE MENU" },
    {"cups",      "CUPS MENU"      },
    {"team",      "TEAM MENU"      },
    {"event",     "EVENT MENU"     },
    {"creative",  "CREATIVE MENU"  },
    {"shop",      "SHOP MENU"      },
    {"tool",      "TOOLS MENU"     },
    {"other",     "OTHER MENU"     },
    {"settings",  "SETTINGS MENU"  },
}

local categoryHandlers = {}

for _, entry in ipairs(tabHandlers) do
    local id   = entry[1]
    local path = "modules/tabs/" .. id .. ".lua"
    local ok, result = pcall(function() return loadModule(path) end)
    if ok and type(result) == "function" then
        categoryHandlers[id] = result
    else
        categoryHandlers[id] = function(container)
            -- surface load errors as a read-only card so the UI stays alive
            addModule(container, id .. "_err", id, "Failed to load: " .. tostring(result), "ro", "Error", nil)
        end
    end
end

return tabHandlers, categoryHandlers
