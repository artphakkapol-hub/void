--[[
  Settings Tab - Script settings and UI customization
  Features: Memory info, background opacity, background RGB,
            accent RGB, logo RGB, sub-text RGB

  All color preferences are saved globally (PID-independent) via
  memory:save_global so they survive game restarts without being cleared
  by a process change.
]]

return function(container)
    -- =========================
    -- Helpers
    -- =========================
    
    local function deepCopy(orig, seen)
        if type(orig) ~= "table" then
            return orig
        end
    
        if seen and seen[orig] then
            return seen[orig]
        end
    
        local copy = {}
        seen = seen or {}
        seen[orig] = copy
    
        for k, v in pairs(orig) do
            copy[deepCopy(k, seen)] = deepCopy(v, seen)
        end
    
        return copy
    end
    
    local function getFileName(path)
        path = tostring(path or "")
        local name = path:match("([^/\\]+)$") or "wallpaper.png"
        name = name:gsub("[^%w%._%-]", "_")
        if name == "" then
            name = "wallpaper.png"
        end
        return name
    end
    
    local function safeJoinPath(folder, name)
        folder = tostring(folder or "")
        name = getFileName(name)
        if folder:sub(-1) == "/" then
            return folder .. name
        end
        return folder .. "/" .. name
    end
    
    local function bytesToHex(data)
        if type(data) ~= "string" then
            return nil
        end
        return (data:gsub(".", function(c)
            return string.format("%02x", string.byte(c))
        end))
    end
    
    local function hexToBytes(hex)
        if type(hex) ~= "string" then
            return nil
        end
    
        hex = hex:gsub("%s+", "")
        if hex == "" then
            return ""
        end
    
        if #hex % 2 ~= 0 then
            return nil
        end
    
        local out = hex:gsub("..", function(cc)
            local n = tonumber(cc, 16)
            if not n then
                return ""
            end
            return string.char(n)
        end)
    
        return out
    end
    
    local function serializeValue(v, seen)
        local t = type(v)
    
        if t == "string" then
            return string.format("%q", v)
        elseif t == "number" or t == "boolean" then
            return tostring(v)
        elseif t == "table" then
            if seen and seen[v] then
                return "nil"
            end
    
            seen = seen or {}
            seen[v] = true
    
            local parts = {}
            for k, val in pairs(v) do
                local keyType = type(k)
                local keyStr
    
                if keyType == "string" then
                    keyStr = "[" .. string.format("%q", k) .. "]"
                elseif keyType == "number" then
                    keyStr = "[" .. tostring(k) .. "]"
                elseif keyType == "boolean" then
                    keyStr = "[" .. tostring(k) .. "]"
                else
                    goto continue
                end
    
                local valueStr = serializeValue(val, seen)
                if valueStr ~= nil then
                    parts[#parts + 1] = keyStr .. "=" .. valueStr
                end
    
                ::continue::
            end
    
            return "{" .. table.concat(parts, ",") .. "}"
        end
    
        return nil
    end
    
    local function serializeTable(t)
        return "return " .. serializeValue(t)
    end
    
    local function rebuildMenu()
        MainHandler.post(function()
            if menuView then
                pcall(function() windowManager.removeView(menuView) end)
                menuView = nil
                activeView = nil
            end
    
            -- Rebuild and re-show
            createMenuView("settings")
            switchToMenu()
        end)
    end
    
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
    
    -- --- Updater ────────────────────────────────────────────────────────
    
    addModuleSep(container, "Updates")
    
    -- ── Auto Update switch ────────────────────────────────────────────────────────
    addModule(container, "auto_update", "Auto Update", "Auto update VOID on startup", "switch", nil, function(done, state)
        if IS_DEV then
            showDialog("Dev Mode", "Auto update is disabled for main.lua (dev build).", {"OK"})
            toggleStates["auto_update"] = false
            done()
            return
        end
        memory:save_global("auto_update", state)
        done()
    end)
    
    -- ── Check for Update button ───────────────────────────────────────────────────
    addModule(container, "check_updates", "Check for Update", "Check for the latest VOID release on GitHub", "button", nil, function(done)
        if IS_DEV then
            showDialog("Dev Mode", "Update check is disabled for main.lua (dev build).\n\nPull from the repo manually.", {"OK"})
            done()
            return
        end
    
        showToast("Checking for updates...")
        local remote_ver, download_url, release_body = fetchLatestVersion()

        if not remote_ver then
            showDialog("Update Check Failed", "Could not reach GitHub:\n" .. tostring(download_url), {"OK"})
            done()
            return
        end
    
        if not versionNewer(remote_ver, CURRENT_VERSION) then
            showDialog("Up to date", "You are already on the latest version (v" .. CURRENT_VERSION .. ").", {"OK"})
            done()
            return
        end
    
        local msg = "v" .. remote_ver .. "  (current: v" .. CURRENT_VERSION .. ")\n\n" .. (release_body or "No changelog available.") .. "\n\nDownload and replace this script?"
        showDialog("Update Available", msg, {"UPDATE", function()
            if not download_url then
                showDialog("Failed", "No .lua asset found in the release.", {"OK"})
                return
            end
    
            showToast("Downloading v" .. remote_ver .. "...")
            local content, err = paste.get(download_url)
            if not content then
                showDialog("Download Failed", tostring(err), {"OK"})
                return
            end
    
            local f = io.open(SCRIPT_PATH, "w")
            if not f then
                showDialog("Write Failed", "Could not write to:\n" .. SCRIPT_PATH, {"OK"})
                return
            end
            f:write(content)
            f:close()
    
            showDialog("Done", "Updated to v" .. remote_ver .. ". Restart the script to apply.", {"Restart", function()
                MainHandler.post(function() os.exit() end)
            end}, {"Later"})
        end}, {"Cancel"})
    
        done()
    end)
    
    -- ── Read-only info ────────────────────────────────────────────────────────

    local function regionName()
        if BaseRegion == -2080896 then return "O: Other"
        elseif BaseRegion == 4 then return "Ca: C++ alloc"
        else return "U: Unknown" end
    end
    
    addModuleSep(container, "Memory")

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
    addModuleSep(container, "UI Customizations")
    
    addModule(container, "export_theme", "Export Theme", "Export custom theme and wallpaper to cloud.", "button", nil, function(done)
        local TAG = "ExportTheme"
        local exportUI = deepCopy(UI)
    
        local function finalizeExport(imageUrl)
            local exportData = {
                version = 5,
                kind = "theme_bundle_url",
                ui = exportUI,
                img_url = imageUrl
            }
    
            local payload = serializeTable(exportData)
            local link, err = paste.post(payload)
    
            if link then
                local pasteId = link:match("[^/]+$")
                gg.copyText(pasteId)
                showDialog("Success", "Share ID: " .. pasteId .. "\n\nCopied to clipboard.", "OK")
            else
                showDialog("Failed", "Upload failed: " .. tostring(err), "OK")
            end
            done()
        end
    
        if UI.BG_IMAGE and UI.BG_IMAGE.PATH and UI.BG_IMAGE.PATH ~= "no_media" then
            showDialog("Upload Size Warning", "Include custom wallpaper? It will increase the Upload Size depending what size is your image is.",
            {"Yes", function()
                showToast("Uploading wallpaper to Catbox...")
                local url, err = catbox.upload(UI.BG_IMAGE.PATH)
                if url then finalizeExport(url) else showDialog("Error", "Image upload failed: " .. err, "OK"); done() end
            end},
            {"No"})
        else
            finalizeExport(nil)
        end
        
        done()
    end)
        
    addModule(container, "import_theme", "Import Theme", "Import custom theme from cloud.", "input", {
        { hint = "Enter Share ID", value = "", type = "text" }
    }, function(done, val)
        local TAG = "ImportTheme"
        local shareId = (type(val) == "table") and val[1] or val
        
        if shareId and shareId ~= "" then
            local rawText, err = paste.get("https://paste.rs/" .. shareId)
            
            if rawText then
                local ok, exportData = pcall(load(rawText))
                if ok and type(exportData) == "table" and exportData.version then
                    for k, v in pairs(exportData.ui) do if UI[k] ~= nil then UI[k] = deepCopy(v) end end
    
                    if exportData.img_url then
                        showToast("Downloading wallpaper...")
                        local dest = gg.FILES_DIR .. "/imported_bg_" .. os.time() .. ".png"
                        local path, dErr = catbox.download(exportData.img_url, dest)
                        if path then UI.BG_IMAGE.PATH = path else LOG.error(TAG, "Wallpaper download failed") end
                    else
                        UI.BG_IMAGE.PATH = "no_media"
                    end
    
                    memory:save_global("ui_prefs", UI)
                    saveAndRefresh()
                    showDialog("Success", "Theme imported!", "OK")
                else
                    showDialog("Failed", "Invalid bundle format.", "OK")
                end
            else
                showDialog("Failed", "Cloud error: " .. tostring(err), "OK")
            end
        end
    
        done()
        rebuildMenu()
    end)
    
    -- Tabs icon
    addModule(container, "tabs_icon", "Tabs Icon", "Change tabs icon", "input", {
        { hint = "Enter Icon", value = UI.TABS_ICON, type = "text" }
    }, function(done, val)
        if val == nil or val == "" then
            showToast("Cannot be empty")
            done()
        else
            UI.TABS_ICON = val
            saveAndRefresh()
            done()
            rebuildMenu()
        end
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
    
    -- ── Background Image Opacity ─────────────────────
    addModule(container, "bg_image_opacity", "Background Image Opacity",
        "Adjust visibility alpha settings directly using pure integer channels.",
        "slider",
        {min = 0, max = 255, current = UI.BG_IMAGE.ALPHA & 0xFF, title = "Alpha"},
        function(done, val) 
            UI.BG_IMAGE.ALPHA = val & 0xFF
            
            saveAndRefresh()
            done()
        end
    )

    -- ── Background Image ────────────────────────────────────────────────
    -- Updates the absolute storage location path pointing to the wallpaper image.

    addModule(container, "bg_image_picker", "Background Image", "Tap to modify the absolute file path destination for your custom layout wallpaper.", "button", nil, function(done)
        local response = gg.prompt(
            { "Absolute Image File Path (.jpg or .png):", "Remove BG Image" },
            { UI.BG_IMAGE.PATH == "no_media" and gg.EXT_STORAGE or UI.BG_IMAGE.PATH, false },
            { "file", "checkbox" }
        )
        
        if response then
            if response[2] == true then
                UI.BG_IMAGE.PATH = "no_media"
                saveAndRefresh()
                showDialog("Successfully", "Restart this script to see the results", {"OK"})
            else
                if response[1] then
                    local parsedPath = response[1]:gsub("^%s*(.-)%s*$", "%1")
        
                    if parsedPath ~= "" then
                        local verificationHandle = io.open(parsedPath, "r")
                        
                        if verificationHandle then
                            verificationHandle:close()
                            
                            UI.BG_IMAGE.PATH = parsedPath
                            saveAndRefresh()
                            showDialog("Successfully", "Restart this script to see the results", {"OK"})
                        else
                            showDialog("Failed", "File not found or read operation refused:\n" .. tostring(parsedPath), {"OK"})
                        end
                    end
                end
            end
        end
        
        done()
        rebuildMenu()
    end)

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
