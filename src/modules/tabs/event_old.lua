--[[
  Event Tab - Event mode features
  Features: Event Rewards Patch / Restore
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    -- Helper function to safely execute root commands across both modules
    local function shellAsRoot(cmd)
        local output = gg.shell("su -c '" .. cmd .. "'")
        return output or "" -- Guarantee a string is returned, never nil
    end

    addModule(container, "patch_rewards", "Event Rewards Patch", "Patch the current public event rewards to custom one provided by VOID (require game restart)", "button", nil, function(done)
        -- Determine if environment is natively Rooted or using a Virtual Space safely
        gg.toast("Checking environment permissions...")
        local suCheck = shellAsRoot("id")
        
        local hasRoot = false
        if suCheck and suCheck:find("uid=0") then
            hasRoot = true
        end
        
        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")
    
        local eventsPaths = {
            "/data/data/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/"
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
    
        -- Workspace allocated for root escalation adjustments
        local safeWorkspace = "/storage/emulated/0/.void_cache/"
        if hasRoot then
            gg.shell("mkdir -p " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            -- Check if file is directly readable (Virtual Space environment scenario)
            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                -- File blocked but root exists: Pull to public space
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                shellAsRoot("cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"")
                shellAsRoot("chmod 777 \"" .. secureActiveCopy .. "\"")
                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                -- Inaccessible and no root (Virtual Space misconfiguration or path missing)
                table.insert(failedList, "File inaccessible at path: " .. path)
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
                                                shellAsRoot("cp \"" .. eventPath .. "\" \"" .. secureEventCopy .. "\"")
                                                shellAsRoot("chmod 777 \"" .. secureEventCopy .. "\"")
                                                targetEventPath = secureEventCopy
                                                eventMovedViaRoot = true
                                            else
                                                table.insert(failedList, "Skipped unreadable event: " .. eventName)
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
                                                            if type(v) == "table" then
                                                                return {
                                                                    value = (v.value or "") .. " (Patched)",
                                                                    localize = v.localize or ""
                                                                }
                                                            end
                                                        
                                                            return {
                                                                value = (v or "") .. " (Patched)",
                                                                localize = ""
                                                            }
                                                        end
                                                        
                                                        jsonEvent.name = patchText(jsonEvent.name)
                                                        jsonEvent.description = patchText(jsonEvent.description)
                                                        
                                                        local encodedEvent = json.encode(jsonEvent)
                                                        eventFile:seek("set", 0)
                                                        eventFile:write(encodedEvent)
                                                        eventFile:flush()
                                                        eventFile:close()
                                                        
                                                        if eventMovedViaRoot and hasRoot then
                                                            -- Encrypt back into public storage, then push back to native protected dir via root bridge
                                                            local secureEncryptedOut = safeWorkspace .. eventName .. "_patched.json"
                                                            Crypto.encrypt(decryptedPath, secureEncryptedOut, eventMeta)
                                                            
                                                            shellAsRoot("cp \"" .. secureEncryptedOut .. "\" \"" .. eventPath .. "\"")
                                                            shellAsRoot("chmod 660 \"" .. eventPath .. "\"")
                                                            os.remove(secureEncryptedOut)
                                                        else
                                                            -- Virtual space configuration: directly encrypt back to root app folder destination
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
    
        -- Final Clean up workspace if created
        if hasRoot then
            gg.shell("rm -rf " .. safeWorkspace)
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
        -- Determine if environment is natively Rooted or using a Virtual Space safely
        gg.toast("Checking environment permissions...")
        local suCheck = shellAsRoot("id")
        
        local hasRoot = false
        if suCheck and suCheck:find("uid=0") then
            hasRoot = true
        end
        
        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")
    
        local eventsPaths = {
            "/data/data/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/"
        }
    
        local successList = {}
        local failedList = {}
    
        -- Workspace allocated for root escalation adjustments
        local safeWorkspace = "/storage/emulated/0/.void_cache/"
        if hasRoot then
            gg.shell("mkdir -p " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            -- Check if file is directly readable (Virtual Space environment scenario)
            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                -- File blocked but root exists: Pull to public space to parse gameEvents list
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                shellAsRoot("cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"")
                shellAsRoot("chmod 777 \"" .. secureActiveCopy .. "\"")
                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                -- Inaccessible and no root (Virtual Space misconfiguration or path missing)
                table.insert(failedList, "File inaccessible at path: " .. path)
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
                                                    
                                                    -- Try standard removal first (Virtual Space handling)
                                                    local removed, remErr = os.remove(eventPath)
                                                    
                                                    -- If standard removal fails and we have root escalation privileges
                                                    if not removed and hasRoot then
                                                        shellAsRoot("rm \"" .. eventPath .. "\"")
                                                        -- Verify file deletion over root channel
                                                        local checkFile = shellAsRoot("[ -f \"" .. eventPath .. "\" ] && echo yes || echo no")
                                                        if checkFile and checkFile:find("no") then
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
        
        -- Final Clean up workspace if created
        if hasRoot then
            gg.shell("rm -rf " .. safeWorkspace)
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
