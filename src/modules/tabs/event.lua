--[[
  Event Tab - Evemt mode features
  Features: Event Rewards Patch
  
  @module callback Receives container View to populate with modules
]]
---compressed and encoded event rewards data, decoded and applied in event rewards module.
local custom_rewards = "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"

return function(container)
    addModule(container, "patch_rewards", "Event Rewards Patch", "Patch the current public event rewards to custom one provided by VOID (require game restart)", "button", nil, function(done)
        gg.toast("Please Wait!")
    
        local eventsPaths = {
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/"
        }
    
        local successList = {}
        local failedList = {}
    
        local modContent = nil
        local ok, err = pcall(function()
            modContent = Zip.decompress(custom_rewards)
        end)
        if not ok or not modContent then
            table.insert(failedList, "Failed to decompress embedded rewards: " .. tostring(err or "nil"))
            modContent = nil
        end
    
        local jsonMod = nil
        if modContent then
            local ok2, err2 = pcall(function()
                jsonMod = json.decode(modContent)
            end)
            if not ok2 or not jsonMod then
                table.insert(failedList, "Failed to decode embedded rewards JSON")
                jsonMod = nil
            end
        end
    
        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = path .. ".active_events"
    
            local meta = Crypto.decrypt(active, active_decrypted)
            if meta then
                local activeFile = io.open(active_decrypted, "r")
                if activeFile then
                    local activeContent = activeFile:read("*a")
                    activeFile:close()
                    os.remove(active_decrypted)
    
                    local jsonActive = nil
                    local ok3, err3 = pcall(function()
                        jsonActive = json.decode(activeContent)
                    end)
                    if not ok3 or not jsonActive then
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
                                            local decryptedPath = path .. "." .. eventName
                                            local eventMeta = Crypto.decrypt(eventPath, decryptedPath)
            
                                            if eventMeta then
                                                local eventFile = io.open(decryptedPath, "r+")
                                                if eventFile then
                                                    local writeOk, writeErr = pcall(function()
                                                        local eventContent = eventFile:read("*a")
                                                        local jsonEvent = json.decode(eventContent)
                                                        
                                                        jsonEvent.eventRewards = eventRewards
                                                        jsonEvent.minRankToJoin = 0
                                                        jsonEvent.rankBrackets = 2
                                                        
                                                        local encodedEvent = json.encode(jsonEvent)
                                                        eventFile:seek("set", 0)
                                                        eventFile:write(encodedEvent)
                                                        eventFile:flush()
                                                        eventFile:close()
                                                        
                                                        Crypto.encrypt(decryptedPath, eventPath, eventMeta)
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
                gg.toast("Finishing pending background tasks... Please wait. ⏳")
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
end
