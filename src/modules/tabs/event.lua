
--[[
  Event Tab - Event mode features
  Features: Event Rewards Patch / Restore
  
  @module callback Receives container View to populate with modules
]]

return function(container)

    -- Helper: get file size in bytes, returns -1 if unreadable
    local function fileSize(path)
        local f = io.open(path, "rb")
        if not f then return -1 end
        local size = f:seek("end")
        f:close()
        return size or -1
    end

    -- Helper: check if root is available
    local function checkRoot()
        local result = Shell.su("id")
        return result and result:find("uid=0") ~= nil
    end

    -- Helper: check if file exists (files only, not dirs)
    local function fileExists(path)
        local f = io.open(path, "rb")
        if f then f:close(); return true end
        return Shell.su("[ -f \"" .. path .. "\" ] && echo yes || echo no") == "yes"
    end

    -- Helper: check if directory exists
    local function dirExists(path)
        return Shell.su("[ -d \"" .. path .. "\" ] && echo yes || echo no") == "yes"
    end

    addModule(container, "patch_rewards", "Event Rewards Patch", "Patch the current public event rewards to custom one provided by VOID (require game restart)", "button", nil, function(done)
        gg.toast("Checking environment permissions...")
        local hasRoot = checkRoot()

        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")

        local eventsPaths = {
            hcr2path .. "/files/content_cache/json/events/"
        }

        local successList = {}
        local failedList = {}

        local custom_rewards = loadModule("configs/rewards.lua")
        local jsonMod = nil
        local ok, err = pcall(function()
            jsonMod = json.decode(custom_rewards)
        end)
        if not ok or not jsonMod then
            table.insert(failedList, "Failed to decode rewards JSON")
            jsonMod = nil
        end

        -- Workspace for root file operations
        local safeWorkspace = gg.EXT_FILES_DIR .. "/.void_cache/"
        if hasRoot then
            Shell.su("mkdir -p \"" .. safeWorkspace .. "\"")
            Shell.su("chmod 777 \"" .. safeWorkspace .. "\"")
            if not dirExists(safeWorkspace) then
                table.insert(failedList, "FATAL: Workspace creation failed: " .. safeWorkspace)
                showDialog("Patch Results", "FATAL: Could not create workspace directory.\n" .. safeWorkspace, {"OK"})
                done()
                return
            end
            LOG.dbg("EventPatch", "Workspace verified: " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            -- Check if file is directly readable (Virtual Space)
            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                Shell.su("cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"")
                Shell.su("chmod 777 \"" .. secureActiveCopy .. "\"")

                if not fileExists(secureActiveCopy) then
                    LOG.warn("EventPatch", "Root copy verification FAILED for: " .. secureActiveCopy)
                    table.insert(failedList, "Root copy failed: " .. active)
                    goto continue_path
                end

                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                table.insert(failedList, "File inaccessible at path: " .. path)
                goto continue_path
            end

            if not fileExists(targetActivePath) then
                table.insert(failedList, "Pre-decrypt: source not found: " .. targetActivePath)
                goto continue_path
            end
            if fileSize(targetActivePath) <= 0 then
                table.insert(failedList, "Pre-decrypt: source is empty (0 bytes): " .. targetActivePath)
                goto continue_path
            end

            local meta = Crypto.decrypt(targetActivePath, active_decrypted)
            if activeMovedViaRoot then os.remove(targetActivePath) end

            if meta then
                local activeFile = io.open(active_decrypted, "r")
                if activeFile then
                    local activeContent = activeFile:read("*a")
                    activeFile:close()
                    os.remove(active_decrypted)

                    local jsonActive = nil
                    local ok2, err2 = pcall(function()
                        jsonActive = json.decode(activeContent)
                    end)
                    if not ok2 or not jsonActive then
                        table.insert(failedList, "Failed to decode active_events.json at path: " .. path)
                        goto continue_path
                    end

                    local gameEvents = jsonActive.gameEvents or {}
                    if #gameEvents == 0 then
                        table.insert(failedList, "No active events found at path: " .. path)
                        goto continue_path
                    end

                    local labels = {}
                    for i = 1, #gameEvents do labels[i] = tostring(gameEvents[i]) end

                    local selections = gg.multiChoice(labels, nil, "Select events to patch:\nPath: " .. path)
                    if not selections then
                        table.insert(failedList, "User cancelled selection for path: " .. path)
                        goto continue_path
                    end

                    if not jsonMod then
                        table.insert(failedList, "Embedded rewards not available, skipping patches for path: " .. path)
                        goto continue_path
                    end
                    local eventRewards = jsonMod.eventRewards

                    local selectionsExist = false
                    for _, selected in pairs(selections) do
                        if selected then selectionsExist = true; break end
                    end

                    if selectionsExist then
                        local fileTaskDone = false

                        scheduler:add(function(finish_task)
                            local loopOk, loopErr = pcall(function()
                                for idx, selected in pairs(selections) do
                                    if selected then
                                        local eventName = gameEvents[idx]
                                        if eventName then
                                            local eventPath = path .. eventName .. ".json"
                                            local targetEventPath = eventPath
                                            local secureEventCopy = safeWorkspace .. eventName .. ".json"
                                            local decryptedPath = hasRoot and (safeWorkspace .. "." .. eventName) or (path .. "." .. eventName)
                                            local eventMovedViaRoot = false

                                            local testEventOpen = io.open(eventPath, "r")
                                            if testEventOpen then
                                                testEventOpen:close()
                                            elseif hasRoot then
                                                Shell.su("cp \"" .. eventPath .. "\" \"" .. secureEventCopy .. "\"")
                                                Shell.su("chmod 777 \"" .. secureEventCopy .. "\"")

                                                if not fileExists(secureEventCopy) then
                                                    LOG.warn("EventPatch", "Root event copy FAILED for: " .. secureEventCopy)
                                                    table.insert(failedList, "Root copy failed: " .. eventPath)
                                                    goto next_event
                                                end

                                                targetEventPath = secureEventCopy
                                                eventMovedViaRoot = true
                                            else
                                                table.insert(failedList, "Skipped unreadable event: " .. eventName)
                                                goto next_event
                                            end

                                            if not fileExists(targetEventPath) then
                                                table.insert(failedList, "Pre-decrypt: event not found: " .. targetEventPath)
                                                goto next_event
                                            end
                                            if fileSize(targetEventPath) <= 0 then
                                                table.insert(failedList, "Pre-decrypt: event is empty (0 bytes): " .. targetEventPath)
                                                goto next_event
                                            end

                                            local eventMeta = Crypto.decrypt(targetEventPath, decryptedPath)
                                            if eventMovedViaRoot then os.remove(targetEventPath) end

                                            if eventMeta then
                                                local eventFile = io.open(decryptedPath, "r+")
                                                if eventFile then
                                                    local writeOk, writeErr = pcall(function()
                                                        local eventContent = eventFile:read("*a")
                                                        local jsonEvent = json.decode(eventContent)

                                                        jsonEvent.eventRewards = eventRewards
                                                        jsonEvent.minRankToJoin = 0
                                                        jsonEvent.rankBrackets = 2

                                                        local function patchText(v)
                                                            local text = type(v) == "table" and (v.value or "") or (v or "")
                                                            local localize = type(v) == "table" and (v.localize or "") or ""
                                                            text = text:gsub("%s*%(Patched%)", "")
                                                            text = text .. " (Patched)"
                                                            return { value = text, localize = localize }
                                                        end

                                                        jsonEvent.name = patchText(jsonEvent.name)
                                                        jsonEvent.description = patchText(jsonEvent.description)

                                                        local encodedEvent = json.encode(jsonEvent)
                                                        eventFile:seek("set", 0)
                                                        eventFile:write(encodedEvent)
                                                        eventFile:flush()
                                                        eventFile:close()

                                                        if eventMovedViaRoot and hasRoot then
                                                            local secureEncryptedOut = safeWorkspace .. eventName .. "_patched.json"
                                                            Crypto.encrypt(decryptedPath, secureEncryptedOut, eventMeta)
                                                            Shell.su("cp \"" .. secureEncryptedOut .. "\" \"" .. eventPath .. "\"")
                                                            Shell.su("chmod 660 \"" .. eventPath .. "\"")
                                                            os.remove(secureEncryptedOut)
                                                        else
                                                            Crypto.encrypt(decryptedPath, eventPath, eventMeta)
                                                        end

                                                        table.insert(successList, eventName)
                                                    end)

                                                    if not writeOk then
                                                        pcall(function() eventFile:close() end)
                                                        table.insert(failedList, "Failed processing " .. eventName .. ": " .. tostring(writeErr))
                                                    end
                                                    os.remove(decryptedPath)
                                                else
                                                    table.insert(failedList, "Cannot open decrypted file: " .. decryptedPath)
                                                end
                                            else
                                                table.insert(failedList, "Failed to decrypt event: " .. eventName)
                                            end
                                        end
                                    end
                                    ::next_event::
                                end
                            end)

                            if not loopOk then
                                table.insert(failedList, "Critical file processing loop crash: " .. tostring(loopErr))
                            end

                            finish_task()
                            fileTaskDone = true
                        end)

                        while not fileTaskDone do gg.sleep(50) end
                    end
                else
                    table.insert(failedList, "Cannot open active_events.json at path: " .. path)
                end
            else
                table.insert(failedList, "Failed to decrypt active_events.json at path: " .. path)
            end
            ::continue_path::
        end

        -- Cleanup workspace
        if hasRoot then
            Shell.su("rm -rf \"" .. safeWorkspace .. "\"")
        end

        local resultMsg = ""
        if #successList > 0 then
            resultMsg = resultMsg .. "Successfully:\n"
            for _, name in ipairs(successList) do
                resultMsg = resultMsg .. "- " .. name .. "\n"
            end
            resultMsg = resultMsg .. "\n"
        end
        if #failedList > 0 then
            resultMsg = resultMsg .. "Failed:\n"
            for _, e in ipairs(failedList) do
                resultMsg = resultMsg .. "- " .. e .. "\n"
            end
        end

        showDialog("Patch Results", resultMsg, {"OK"})
        done()

        if #successList > 0 then
            print(resultMsg)
            showDialog("Restart Required", "Game is killed and this script gonna exit, start it again and see the patch effects", {"OK"})

            if scheduler:getQueueCount() > 0 or scheduler:isProcessing() then
                gg.toast("Finishing pending background tasks... Please wait.")
                while scheduler:getQueueCount() > 0 or scheduler:isProcessing() do
                    gg.sleep(100)
                end
            end

            gg.processKill()
            gg.sleep(1000)
            exitScript()
        else
            showDialog("Failed", "Failed to patch, try again.", {"OK"})
        end
    end)

    addModule(container, "restore_events", "Event Rewards Restore", "Delete modified event JSONs to force game server recovery (requires game restart)", "button", nil, function(done)
        gg.toast("Checking environment permissions...")
        local hasRoot = checkRoot()

        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")

        local eventsPaths = {
            hcr2path .. "/files/content_cache/json/events/"
        }

        local successList = {}
        local failedList = {}

        local safeWorkspace = gg.EXT_FILES_DIR .. "/.void_cache/"
        if hasRoot then
            Shell.su("mkdir -p \"" .. safeWorkspace .. "\"")
            Shell.su("chmod 777 \"" .. safeWorkspace .. "\"")
            if not dirExists(safeWorkspace) then
                table.insert(failedList, "FATAL: Workspace creation failed: " .. safeWorkspace)
                showDialog("Restore Results", "FATAL: Could not create workspace directory.\n" .. safeWorkspace, {"OK"})
                done()
                return
            end
            LOG.dbg("EventRestore", "Workspace verified: " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                Shell.su("cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"")
                Shell.su("chmod 777 \"" .. secureActiveCopy .. "\"")

                if not fileExists(secureActiveCopy) then
                    LOG.warn("EventRestore", "Root copy verification FAILED for: " .. secureActiveCopy)
                    table.insert(failedList, "Root copy failed: " .. active)
                    goto continue_path
                end

                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                table.insert(failedList, "File inaccessible at path: " .. path)
                goto continue_path
            end

            if not fileExists(targetActivePath) then
                table.insert(failedList, "Pre-decrypt: source not found: " .. targetActivePath)
                goto continue_path
            end
            if fileSize(targetActivePath) <= 0 then
                table.insert(failedList, "Pre-decrypt: source is empty (0 bytes): " .. targetActivePath)
                goto continue_path
            end

            local meta = Crypto.decrypt(targetActivePath, active_decrypted)
            if activeMovedViaRoot then os.remove(targetActivePath) end

            if meta then
                local activeFile = io.open(active_decrypted, "r")
                if activeFile then
                    local activeContent = activeFile:read("*a")
                    activeFile:close()
                    os.remove(active_decrypted)

                    local jsonActive = nil
                    local ok, err = pcall(function()
                        jsonActive = json.decode(activeContent)
                    end)

                    if ok and jsonActive then
                        local gameEvents = jsonActive.gameEvents or {}
                        if #gameEvents > 0 then
                            local labels = {}
                            for i = 1, #gameEvents do labels[i] = tostring(gameEvents[i]) end

                            local selections = gg.multiChoice(labels, nil, "Select files to restore (delete):\nPath: " .. path)

                            if selections then
                                local fileTaskDone = false

                                scheduler:add(function(finish_task)
                                    pcall(function()
                                        for idx, selected in pairs(selections) do
                                            if selected then
                                                local eventName = gameEvents[idx]
                                                if eventName then
                                                    local eventPath = path .. eventName .. ".json"

                                                    local removed, remErr = os.remove(eventPath)

                                                    if not removed and hasRoot then
                                                        Shell.su("rm \"" .. eventPath .. "\"")
                                                        local check = Shell.su("[ -f \"" .. eventPath .. "\" ] && echo yes || echo no")
                                                        if check == "no" then
                                                            removed = true
                                                        else
                                                            remErr = "Root removal failed or rejected"
                                                        end
                                                    end

                                                    if removed then
                                                        table.insert(successList, eventName)
                                                    else
                                                        table.insert(failedList, "Failed to delete " .. eventName .. ": " .. tostring(remErr))
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                    finish_task()
                                    fileTaskDone = true
                                end)

                                while not fileTaskDone do gg.sleep(50) end
                            end
                        else
                            table.insert(failedList, "No active events found at path: " .. path)
                        end
                    else
                        table.insert(failedList, "Failed to decode active_events.json at path: " .. path)
                    end
                else
                    table.insert(failedList, "Cannot open active_events.json at path: " .. path)
                end
            else
                table.insert(failedList, "Failed to decrypt active_events.json at path: " .. path)
            end
            ::continue_path::
        end

        -- Cleanup workspace
        if hasRoot then
            Shell.su("rm -rf \"" .. safeWorkspace .. "\"")
        end

        local resultMsg = ""
        if #successList > 0 then
            resultMsg = resultMsg .. "Successfully Removed (Will Restore on Restart):\n"
            for _, name in ipairs(successList) do
                resultMsg = resultMsg .. "- " .. name .. ".json\n"
            end
            resultMsg = resultMsg .. "\n"
        end
        if #failedList > 0 then
            resultMsg = resultMsg .. "Failed:\n"
            for _, e in ipairs(failedList) do
                resultMsg = resultMsg .. "- " .. e .. "\n"
            end
        end

        showDialog("Restore Results", resultMsg, {"OK"})
        done()

        if #successList > 0 then
            print(resultMsg)
            showDialog("Restart Required", "Game will now close to allow server file synchronization.", {"OK"})

            if scheduler:getQueueCount() > 0 or scheduler:isProcessing() then
                gg.toast("Finishing pending background tasks...")
                while scheduler:getQueueCount() > 0 or scheduler:isProcessing() do
                    gg.sleep(100)
                end
            end

            gg.processKill()
            gg.sleep(1000)
            exitScript()
        end
    end)
end
