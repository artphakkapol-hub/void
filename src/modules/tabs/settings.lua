--[[
  Settings Tab - Script settings and UI customization
  Features: Memory info, background opacity, background RGB,
            accent RGB, logo RGB, sub-text RGB

  All color preferences are saved globally (PID-independent) via
  memory:saveGlobal so they survive game restarts without being cleared
  by a process change.
]]

return function(container)
    local saved = memory:loadGlobal("ui_prefs")
    if saved then
        LOG.info("INIT", "User preferences RE-APPLIED")
        for k, v in pairs(saved) do
            if UI[k] ~= nil then UI[k] = v end
        end
    end
    
    local function saveAndRefresh()
        memory:saveGlobal("ui_prefs", UI)
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

    addModule(container, "memory_range", "Memory Range", "Current selected memory range", "ro", regionName(), nil)
    addModule(container, "gamestatus_address", "GameStatus", "Current gamestatus address", "ro", string.format("0x%X", BaseGameStatus or 0), nil)

    -- ── Custom Colors Info ────────────────────────────────────────────────────
    -- Allow user to changes colors of this script.
    addModule(container, "colors_info", "About Custom Colors", "Let's you customize this script menu colors, restart this script for better results.", "ro", "", nil)
    
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
