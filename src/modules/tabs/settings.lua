--[[
  Settings Tab - Script settings and UI customization
  Features: Memory info, background opacity, background RGB,
            accent RGB, logo RGB, sub-text RGB

  All color preferences are saved globally (PID-independent) via
  memory:save_global so they survive game restarts without being cleared
  by a process change.
]]

return function(container)
    local function saveAndRefresh()
        LOG.info("Settings", "UI preferences saved and refresh triggered")
        memory:save_global("ui_prefs", UI)
        MainHandler.post(function()
            if menuView then
                menuView.setBackground(getSkin(UI.BG, 16, 0, UI.STROKE))
            end
            if activeTabView then
                loadCategory("settings", activeTabView)
            end
        end)
    end
    -- ── Read-only info ────────────────────────────────────────────────────────

    local function regionName()
        if BaseRegion == -2080896 then return "O: Other"
        elseif BaseRegion == 4 then return "Ca: C++ alloc"
        else return "U: Unknown" end
    end

    addModule(container, "memory_range", "Memory Range", "Current selected memory range\n(automatically chosen by script)", "ro", regionName(), nil)
    addModule(container, "gamestatus_address", "GameStatus", "Current gamestatus address\n(automatically chosen by script)", "ro", string.format("0x%X", BaseGameStatus or 0), nil)
    addModule(container, "gamestatus_raw_address", "GameStatus (Raw)", "Current gamestatus (raw) address\n(automatically chosen by script)", "ro", string.format("0x%X", BaseGameStatusRaw or 0), nil)
    
    -- ── Session Control or smth ────────────────────────────────────────────────────────
    addModule(container, "clear_memory", "Clear Saved Memory", "Clear all VOID saved memory without needed to restart the whole game.", "button", nil, function(done)
        LOG.info("Settings", "User triggered clear_all()")
        memory:clear_all()
        done()
    end)
    
    -- ── Custom Colors Info ────────────────────────────────────────────────────
    -- Allow user to changes colors of this script.
    addModule(container, "colors_info", "About Custom Colors", "Let's you customize this script menu colors, restart this script after customizing for better results.", "ro", "", nil)
    
    -- Helper to serialize the current UI table for cloud storage
    local function serializeTable(t)
        local elements = {}
        for k, v in pairs(t) do
            -- Only serialize strings, numbers, and booleans to avoid functions/userdata crashing
            if type(v) == "string" then
                table.insert(elements, string.format('["%s"]="%s"', k, v))
            elseif type(v) == "number" or type(v) == "boolean" then
                table.insert(elements, string.format('["%s"]=%s', k, tostring(v)))
            end
        end
        return "return {" .. table.concat(elements, ",") .. "}"
    end
    
    -- Export Theme
    addModule(container, "export_theme", "Export Theme", "Export custom theme to cloud.", "button", nil, function(done)
        showToast("Uploading theme configuration...")
            
        local payload = serializeTable(UI)
        local link, err = paste.post(payload)
            
        if link then
            local pasteId = link:match("[^/]+$") -- Extracts just the short key
            gg.copyText(pasteId)
            showDialog("Success", "Theme uploaded successfully!\n\nShare ID: " .. pasteId .. "\n\nThe ID has been copied to your clipboard.", {"OK"})
        else
            showDialog("Failed", "Failed to export theme:\n" .. tostring(err), {"OK"})
        end
            
        done()
    end)
    
    -- Import Theme
    addModule(container, "import_theme", "Import Theme", "Import custom theme from cloud.", "input", {
        { hint = "Enter Share ID", value = "", type = "text" }
    }, function(done, val)
        if not val or val == "" then 
            done()
            return
        end
        
        showToast("Downloading theme...")
        local rawText, err = paste.get("https://paste.rs/" .. val) -- Note: Ensure val[1] index is targetted if 'val' is a table
        
        if rawText then
            local loadedChunk, compileErr = load(rawText)
            if loadedChunk then
                local imported_prefs = loadedChunk()
                
                -- Apply the imported values onto the live UI state
                for k, v in pairs(imported_prefs) do
                    if UI[k] ~= nil then 
                        UI[k] = v 
                    end
                end
                
                -- Auto-save to global memory so it persists natively on next boot
                memory:save_global("ui_prefs", UI)
                saveAndRefresh()
                showDialog("Success", "Theme successfully imported and saved!", {"OK"})
            else
                showDialog("Failed", "Failed to parse theme data:\n" .. tostring(compileErr), {"OK"})
            end
        else
            showDialog("Failed", "Failed to fetch data from cloud:\n" .. tostring(err), {"OK"})
        end
        
        done()
    end)
    
    -- ── Background Opacity ────────────────────────────────────────────────────
    -- Writes to the alpha byte of UI.BG; HEADER, CARD, and GLASS track it at
    -- fixed ratios so the visual hierarchy stays consistent.

    local function getAlpha(color)
        return (color >> 24) & 0xFF
    end

    local function setLayerAlpha(a)
        local function recolor(base, ratio)
            return (math.min(math.floor(a * ratio), 0xFF) << 24) | (base & 0x00FFFFFF)
        end
        UI.BG = recolor(UI.BG, 1.00)
        UI.HEADER = recolor(UI.HEADER, 1.25)
        UI.CARD = recolor(UI.CARD, 1.55)
        UI.GLASS = recolor(UI.GLASS, 0.75)
    end

    addModule(container, "bg_opacity", "Background Opacity",
        "Transparency of panels, cards, and header",
        "slider",
        {min = 1, max = 255, current = getAlpha(UI.BG), title = "Alpha"},
        function(done, val)
            setLayerAlpha(val)
            saveAndRefresh()
            done()
        end
    )

    -- ── Background RGB ────────────────────────────────────────────────────────
    -- Adjusts the R, G, B hue of UI.BG. HEADER and CARD are derived at fixed
    -- brightness ratios so the layer hierarchy stays intact. Alphas are
    -- preserved as-is (use Background Opacity to change them).

    local function setBgRgb(r, g, b)
        local function recolorRgb(base, ratio)
            local a = (base >> 24) & 0xFF
            local nr = math.min(math.floor(r * ratio), 0xFF)
            local ng = math.min(math.floor(g * ratio), 0xFF)
            local nb = math.min(math.floor(b * ratio), 0xFF)
            return (a << 24) | (nr << 16) | (ng << 8) | nb
        end
        UI.BG = recolorRgb(UI.BG, 1.00)
        UI.HEADER = recolorRgb(UI.HEADER, 1.30)
        UI.CARD = recolorRgb(UI.CARD, 1.55)
    end

    addModule(container, "bg_rgb", "Background RGB",
        "Hue for panel backgrounds (Header and Card scale automatically)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.BG >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.BG >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.BG & 0xFF, title = "B"},
        },
        function(done, vals)
            setBgRgb(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Accent RGB ────────────────────────────────────────────────────────────
    -- ACCENT uses fixed alpha 0x60 (38% opaque).
    -- MUTED is derived automatically at alpha 0x4D with each channel halved.

    local function buildAccent(r, g, b)
        UI.ACCENT = (0x60 << 24) | (r << 16) | (g << 8) | b
        UI.MUTED = (0x4D << 24) | ((r >> 1) << 16) | ((g >> 1) << 8) | (b >> 1)
    end

    addModule(container, "accent_rgb", "Accent RGB",
        "Tint for buttons, toggles, and active cards (muted color auto-derived)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.ACCENT >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.ACCENT >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.ACCENT & 0xFF, title = "B"},
        },
        function(done, vals)
            buildAccent(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Logo (Highlight) RGB ──────────────────────────────────────────────────
    -- LOGO is always fully opaque (alpha 0xFF).
    -- Used for labels, icons, slider arrows, and the wordmark.

    local function buildLogo(r, g, b)
        UI.LOGO = (0xFF << 24) | (r << 16) | (g << 8) | b
    end

    addModule(container, "logo_rgb", "Highlight RGB",
        "Color for labels, icons, and interactive text (always fully opaque)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.LOGO >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.LOGO >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.LOGO & 0xFF, title = "B"},
        },
        function(done, vals)
            buildLogo(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Sub-text RGB ──────────────────────────────────────────────────────────
    -- SUB uses fixed alpha 0xDD (87% opaque).
    -- Used for descriptions and inactive tab labels.

    local function buildSub(r, g, b)
        UI.SUB = (0xDD << 24) | (r << 16) | (g << 8) | b
    end

    addModule(container, "sub_rgb", "Sub-text RGB",
        "Color for descriptions and inactive tab labels",
        "slider",
        {
            {min = 0, max = 255, current = (UI.SUB >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.SUB >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.SUB & 0xFF, title = "B"},
        },
        function(done, vals)
            buildSub(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )
    
    -- ── Text RGB ──────────────────────────────────────────────────────────────
    -- Main text color used throughout the menu.
    
    local function buildText(r, g, b)
        UI.TEXT = (0xFF << 24) | (r << 16) | (g << 8) | b
        UI.LOGO = UI.TEXT
    end
    
    addModule(container, "text_rgb", "Text RGB",
        "Color for main menu text",
        "slider",
        {
            {min = 0, max = 255, current = (UI.TEXT >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.TEXT >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.TEXT & 0xFF, title = "B"},
        },
        function(done, vals)
            buildText(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Window Size ───────────────────────────────────────────────────────────
    
    addModule(container, "win_width", "Menu Width",
        "Width of the floating menu (" .. RESIZE_MIN_W .. " – " .. RESIZE_MAX_W .. " dp)",
        "slider",
        {min = RESIZE_MIN_W, max = RESIZE_MAX_W, current = WIN_W, title = "Width"},
        function(done, val)
            applyWindowResize(val, WIN_H)
            done()
        end
    )

    addModule(container, "win_height", "Menu Height",
        "Height of the scrollable content area (" .. RESIZE_MIN_H .. " – " .. RESIZE_MAX_H .. " dp)",
        "slider",
        {min = RESIZE_MIN_H, max = RESIZE_MAX_H, current = WIN_H, title = "Height"},
        function(done, val)
            applyWindowResize(WIN_W, val)
            done()
        end
    )

end
