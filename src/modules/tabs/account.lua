--[[
  Account Tab - Player profile modifications
  Features: Change player name, Fake VIP, Fake Rank,
            Max Vehicles, Max Mastery, Max Parts
  
  @module callback Receives container View to populate with modules
]]

-- Part name → max upgrade level. Defined at module scope so it is
-- built once on first tab load, not rebuilt on every render call.
local PART_MAX_LEVEL = {
    start_boost           = 10,
    perfect_landing_boost = 7,
    jump                  = 10,
    wheelie_boost         = 10,
    afterburner           = 7,
    fume_boost            = 10,
    thrusters             = 4,
    glide                 = 15,
    fuel_boost            = 4,
    coin_boost            = 4,
    winter_tyres          = 15,
    magnet                = 15,
    spoiler               = 7,
    turbo_boost           = 7,
    flip_speed_boost      = 10,
    nitro                 = 4,
    air_control           = 15,
    heavyweight           = 15,
    rollcage              = 15,
    echo                  = 3,
    amplifier             = 3,
}

return function(container)
    addModule(container, "change_name", "Change Name", "Change your player name", "input", {
        { hint = "Enter Name", value = "", type = "text" }
    }, function(done, val)
        scheduler:add(function(finishTask)
            local TAG = "ChangeName"

            if val == nil or val == "" then
                showToast("Enter a name first")
                LOG.warn(TAG, "Empty input — aborted")
                finishTask(); done(); return
            end

            LOG.info(TAG, "Attempting name change to: " .. val)

            local nameBytes = {}
            local byteCount = 0

            for _, code in utf8.codes(val) do
                local encoded = utf8.char(code)
                local bytes   = { encoded:byte(1, -1) }
                if byteCount + #bytes > 12 then
                    showDialog("Name Too Long", "Your name is too long, please shorten it", "OK")
                    LOG.warn(TAG, "Name exceeds 12 bytes — aborted")
                    finishTask(); done(); return
                end
                for _, b in ipairs(bytes) do
                    table.insert(nameBytes, b)
                    byteCount = byteCount + 1
                end
            end

            while #nameBytes < 12 do table.insert(nameBytes, 0) end

            local namePtr = gg.getValues({{ address = BaseGameStatus + 0x38, flags = 32 }})[1].value
            if not namePtr or namePtr == 0 then
                showToast("Failed to resolve name pointer")
                LOG.fatal(TAG, "namePtr is nil or 0")
                finishTask(); done(); return
            end

            local writes  = {{ address = namePtr, flags = 1, value = byteCount * 2 }}
            for i = 1, #nameBytes do
                writes[#writes + 1] = { address = namePtr + i, flags = 1, value = nameBytes[i] }
            end

            gg.setValues(writes)
            showToast("Name changed to " .. val)
            LOG.info(TAG, string.format("Done. byteCount=%d namePtr=0x%X", byteCount, namePtr))
            finishTask()
            done()
        end)
    end)
    
    addModule(container, "change_gp", "Change Garage Power", "Changes profile garage power (persists if higher). Set to 8 to reset if over max, but only if your actual GP is already fixed under the limit.", "input", {
        { hint = "Enter Garage Power", value = "8", type = "number" }
    }, function(done, val)
        scheduler:add(function(finishTask)
            if tonumber(val) > 2147483647 then
                showDialog("Max 32bit int Reached", "Please lower your value", {"OK"})
                finishTask()
                done()
                return
            elseif tonumber(val) < 8 then
                showDialog("Too Low", "Please higher your value", {"OK"})
                finishTask()
                done()
                return
            end
            
            gg.setValues({
                { address = BaseGameStatus + 0x4F4, flags = 4, value = val }
            })
            
            showToast("Garage Power has been changed to " .. tostring(val))
            finishTask()
            done()
        end)
    end)

    addArchModule(container, "fake_vip", "Fake VIP", "Toggle vip subscription state locally", "switch", nil, aobs.fakeVip)
    
    addModule(container, "fake_rank", "Fake Rank", "Set your rank to fake legendary automatically", "button", nil, function(done)
        scheduler:add(function(finishTask)
            gg.setValues({
                { address = BaseGameStatus + 0x200, flags = 16, value = 50.0 }
            })
            showToast("Fake Rank has been injected.")
            finishTask()
            done()
        end)
    end)
    
    addModule(container, "unlock_vehicles", "Unlock Vehicles", "Unlock all vehicles to be available to purchase with coins", "button", nil,
    function(done)
        local TAG = "UnlockVehicles"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finishTask)
            gg.clearResults()
            gg.setRanges(BaseRegion)
            gg.searchNumber("h 18 48 49 4C 4C 20 43 4C 49 4D 42 45", 1)
            gg.refineNumber("h 18", 1)
            local anchorResults = gg.getResults(gg.getResultsCount())
            gg.clearResults()

            if #anchorResults == 0 then
                showToast("No vehicles found")
                LOG.warn(TAG, "Anchor search returned 0 results.")
                finishTask()
                done()
                return
            end

            local anchor = anchorResults[1]
            LOG.dbg(TAG, string.format("Anchor found at 0x%X", anchor.address))

            local pattern = gg.getValues({
                { address = anchor.address - 0x20, flags = 4 },
                { address = anchor.address - 0x8,  flags = 4 }
            })

            if not pattern or not pattern[1] or not pattern[2] then
                showToast("Failed to read vehicle anchor")
                LOG.warn(TAG, "Pattern read failed.")
                finishTask()
                done()
                return
            end

            if pattern[1].value ~= 0x65656A08 or pattern[2].value ~= 0x403147AE then
                showToast("Failed to find vehicle anchor")
                LOG.warn(TAG, string.format("Pattern mismatch: 0x%X 0x%X",
                    pattern[1].value, pattern[2].value))
                finishTask()
                done()
                return
            end

            LOG.dbg(TAG, "Pattern valid. Searching vehicle list refs...")
            gg.clearResults()
            gg.searchNumber(pattern[1].address, 32)
            local refResults = gg.getResults(gg.getResultsCount())
            gg.clearResults()

            if not refResults or #refResults == 0 then
                showToast("No vehicle refs found")
                LOG.warn(TAG, "Vehicle list ref search returned 0 results.")
                finishTask()
                done()
                return
            end

            LOG.dbg(TAG, "Vehicle list refs found: " .. tostring(#refResults))

            local successCount = 0
            local written = {}  -- ← outside both loops
            
            for refIdx, ref in ipairs(refResults) do
                local vehicleIdx = 0
            
                while true do
                    local ptrRead = gg.getValues({{
                        address = ref.address + vehicleIdx * 8,
                        flags   = 32
                    }})
            
                    if not ptrRead or not ptrRead[1] or ptrRead[1].value == 0 then
                        LOG.dbg(TAG, string.format("ref[%d] vehicleIdx[%d] ptr nil/0, stopping", refIdx, vehicleIdx))
                        break
                    end
            
                    local vehiclePtr = ptrRead[1].value
            
                    local deepPtrRead = gg.getValues({{
                        address = vehiclePtr + 0x530,
                        flags   = 32
                    }})
            
                    if not deepPtrRead or not deepPtrRead[1] or deepPtrRead[1].value == 0 then
                        LOG.dbg(TAG, string.format("ref[%d] vehicleIdx[%d] +0x530 failed, stopping", refIdx, vehicleIdx))
                        break
                    end
            
                    local deepPtr = deepPtrRead[1].value
            
                    local verify = gg.getValues({
                        { address = deepPtr + 0x0, flags = 4 },
                        { address = deepPtr + 0x4, flags = 4 },
                        { address = deepPtr + 0x8, flags = 4 },
                        { address = deepPtr + 0xC, flags = 4 }
                    })
            
                    if not verify or #verify ~= 4
                    or verify[1].value ~= 0
                    or verify[2].value ~= 18
                    or verify[3].value ~= 53 then
                        LOG.dbg(TAG, string.format("ref[%d] vehicleIdx[%d] structure mismatch, stopping", refIdx, vehicleIdx))
                        break
                    end
            
                    if written[vehiclePtr] then
                        LOG.dbg(TAG, string.format("ref[%d] vehicleIdx[%d] already written, skipping", refIdx, vehicleIdx))
                        vehicleIdx = vehicleIdx + 1
                        goto continueVehicle
                    end
            
                    LOG.info(TAG, string.format("ref[%d] vehicleIdx[%d] verified! Writing unlock at vehiclePtr=0x%X", refIdx, vehicleIdx, vehiclePtr))
            
                    local edits = {
                        { address = vehiclePtr + 0x110, flags = 4, value = 1 }
                    }
                    for off = 0x114, 0x14C, 4 do
                        table.insert(edits, { address = vehiclePtr + off, flags = 4, value = 0 })
                    end
                    gg.setValues(edits)
            
                    written[vehiclePtr] = true
                    successCount = successCount + 1
                    vehicleIdx = vehicleIdx + 1
            
                    ::continueVehicle::
                end
            end

            LOG.info(TAG, "Done. Success: " .. tostring(successCount))

            if successCount > 0 then
                showToast("Vehicles unlocked: " .. tostring(successCount))
            else
                showToast("No vehicles to unlock")
            end

            finishTask()
            done()
        end)
    end)

    addModule(container, "max_vehicles", "Max Vehicles", "Max all unlocked vehicles upgrade levels instantly", "button", nil,
    function(done)
        local TAG = "MaxVehicles"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finishTask)
            local vehicleListPtr = gg.getValues({{ address = BaseGameStatus + 0xB8, flags = 32 }})[1].value
            local totalVehicles  = gg.getValues({{ address = BaseGameStatus + 0xC0, flags = 4  }})[1].value

            if not vehicleListPtr or vehicleListPtr == 0 then
                showToast("Failed to resolve vehicle list")
                LOG.fatal(TAG, "vehicleListPtr is nil or 0.")
                finishTask(); done(); return
            end

            LOG.dbg(TAG, "Total vehicles: " .. tostring(totalVehicles))

            local upgradeList = {}

            for i = 0, totalVehicles - 1 do
                local vehiclePtr = gg.getValues({{ address = vehicleListPtr + i * 8, flags = 32 }})[1].value
                if vehiclePtr and vehiclePtr ~= 0 then
                    local namePtr     = gg.getValues({{ address = vehiclePtr + 0x18, flags = 32 }})[1].value
                    local vehicleName = (namePtr and namePtr ~= 0) and readString(namePtr + 1) or "unknown"
                    local upgradeSlots = vehicleName:find("lowrider") and 5 or 4

                    local upgradeListPtr = gg.getValues({{ address = vehiclePtr + 0x20, flags = 32 }})[1].value
                    if upgradeListPtr and upgradeListPtr ~= 0 then
                        for j = 0, upgradeSlots - 1 do
                            local upgradePtr = gg.getValues({{ address = upgradeListPtr + j * 8, flags = 32 }})[1].value
                            if upgradePtr and upgradePtr ~= 0 then
                                table.insert(upgradeList, { address = upgradePtr + 0x20, flags = 4, value = 19 })
                                table.insert(upgradeList, { address = upgradePtr + 0x24, flags = 4, value = 19 })
                            end
                        end
                        LOG.dbg(TAG, "[" .. vehicleName .. "] queued " .. tostring(upgradeSlots) .. " upgrade slots.")
                    end
                end
                showToast(tostring(i+1) .. "/" .. tostring(totalVehicles), true)
            end

            if #upgradeList > 0 then
                gg.setValues(upgradeList)
                showToast("All vehicles maxed")
                LOG.info(TAG, "Done. Total writes: " .. tostring(#upgradeList))
            else
                showToast("Failed to max vehicles")
                LOG.warn(TAG, "upgradeList is empty.")
            end

            finishTask()
            done()
        end)
    end)

    addModule(container, "max_mastery", "Max Mastery", "Max all unlocked and maxed vehicles masteries instantly.", "button", nil,
    function(done)
        local TAG = "MaxMastery"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finishTask)
            local masteryTimestamp = os.time(os.date("!*t"))
            local vehicleListPtr   = gg.getValues({{ address = BaseGameStatus + 0xB8, flags = 32 }})[1].value
            local totalVehicles    = gg.getValues({{ address = BaseGameStatus + 0xC0, flags = 4  }})[1].value

            if not vehicleListPtr or vehicleListPtr == 0 then
                showToast("Failed to max masteries")
                LOG.fatal(TAG, "vehicleListPtr is nil or 0.")
                finishTask(); done(); return
            end

            if not totalVehicles or totalVehicles == 0 then
                showToast("Failed to max masteries")
                LOG.fatal(TAG, "totalVehicles is nil or 0.")
                finishTask(); done(); return
            end

            LOG.dbg(TAG, "Total vehicles: " .. tostring(totalVehicles))

            local successCount = 0
            local skipCount    = 0

            for i = 1, totalVehicles do
                local vehiclePtr = gg.getValues({{ address = vehicleListPtr + (i - 1) * 8, flags = 32 }})[1].value
                if not vehiclePtr or vehiclePtr == 0 then
                    skipCount = skipCount + 1; goto continue
                end

                local namePtr     = gg.getValues({{ address = vehiclePtr + 0x18, flags = 32 }})[1].value
                local vehicleName = (namePtr and namePtr ~= 0) and readString(namePtr + 1) or "Unknown"

                local masteryPtr = gg.getValues({{ address = vehiclePtr + 0x120, flags = 32 }})[1].value
                if not masteryPtr or masteryPtr == 0 then
                    LOG.dbg(TAG, "[" .. vehicleName .. "] masteryPtr is 0. Skipping (not maxed).")
                    skipCount = skipCount + 1; goto continue
                end

                -- Read up to 4 CA pointers
                local ptrReads  = {}
                for j = 0, 3 do
                    table.insert(ptrReads, { address = masteryPtr + j * 8, flags = 32 })
                end
                local rawPtrs   = gg.getValues(ptrReads)
                local validPtrs = {}
                if rawPtrs then
                    for _, p in ipairs(rawPtrs) do
                        if p and p.value and p.value ~= 0 then
                            table.insert(validPtrs, p.value)
                        end
                    end
                end

                if #validPtrs == 0 then
                    LOG.dbg(TAG, "[" .. vehicleName .. "] No valid CA pointers. Skipping.")
                    skipCount = skipCount + 1; goto continue
                end

                local writes = {}
                for _, p in ipairs(validPtrs) do
                    table.insert(writes, { address = p + 0x18, flags = 4, value = 65793 })
                    table.insert(writes, { address = p + 0x1C, flags = 4, value = masteryTimestamp })
                end

                gg.setValues({
                    { address = vehiclePtr + 0x120, flags = 32, value = masteryPtr },
                    { address = vehiclePtr + 0x128, flags = 4,  value = 4 },
                    { address = vehiclePtr + 0x12C, flags = 4,  value = 4 },
                    { address = vehiclePtr + 0x130, flags = 4,  value = 4 },
                })
                gg.setValues(writes)

                LOG.info(TAG, "[" .. vehicleName .. "] Mastery maxed.")
                successCount = successCount + 1
                
                showToast(tostring(i) .. "/" .. tostring(totalVehicles), true)
                ::continue::
            end

            LOG.info(TAG, string.format("Complete. Success: %d | Skipped: %d", successCount, skipCount))
            showToast(successCount > 0 and "All masteries maxed" or "Failed to max masteries")
            finishTask()
            done()
        end)
    end)

    addModule(container, "max_parts", "Max Parts", "Max all unlocked parts levels for all vehicles instantly.", "button", nil,
    function(done)
        local TAG = "MaxParts"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finishTask)
            local vehicleListPtr = gg.getValues({{ address = BaseGameStatus + 0xB8, flags = 32 }})[1].value
            local totalVehicles  = gg.getValues({{ address = BaseGameStatus + 0xC0, flags = 4  }})[1].value

            if not vehicleListPtr or vehicleListPtr == 0 then
                showToast("Failed to resolve vehicle list")
                LOG.fatal(TAG, "vehicleListPtr is nil or 0.")
                finishTask(); done(); return
            end

            LOG.dbg(TAG, "Total vehicles: " .. tostring(totalVehicles))

            local upgradeList = {}

            for i = 0, totalVehicles - 1 do
                local vehiclePtr = gg.getValues({{ address = vehicleListPtr + i * 8, flags = 32 }})[1].value
                if vehiclePtr and vehiclePtr ~= 0 then
                    local partsListPtr = gg.getValues({{ address = vehiclePtr + 0x58, flags = 32 }})[1].value
                    local totalParts   = gg.getValues({{ address = vehiclePtr + 0x60, flags = 4  }})[1].value

                    if partsListPtr and partsListPtr ~= 0 and totalParts and totalParts > 0 then
                        for j = 0, totalParts - 1 do
                            local partPtr = gg.getValues({{ address = partsListPtr + j * 8, flags = 32 }})[1].value
                            if partPtr and partPtr ~= 0 then
                                local namePtr  = gg.getValues({{ address = partPtr + 0x18, flags = 32 }})[1].value
                                local partName = "unknown"

                                if namePtr and namePtr ~= 0 then
                                    local header = gg.getValues({{ address = namePtr, flags = 4 }})[1].value
                                    if header == 49 then
                                        local namePtr2 = gg.getValues({{ address = namePtr + 0x10, flags = 32 }})[1].value
                                        partName = namePtr2 ~= 0 and readString(namePtr2 + 1) or "unknown"
                                    else
                                        partName = readString(namePtr + 1)
                                    end
                                end

                                local maxLevel = 3 -- fallback for unrecognised parts
                                
                                for key, lvl in pairs(PART_MAX_LEVEL) do
                                    -- '$' anchors the search strictly to the end of the string
                                    if partName:find(key .. "$") then 
                                        maxLevel = lvl
                                        break 
                                    end
                                end
                                
                                LOG.dbg(TAG, "[" .. partName .. "] max level: " .. tostring(maxLevel))
                                table.insert(upgradeList, { address = partPtr + 0x20, flags = 4, value = maxLevel })
                                table.insert(upgradeList, { address = partPtr + 0x34, flags = 4, value = maxLevel })
                            end
                        end
                    end
                end
                showToast(tostring(i+1) .. "/" .. tostring(totalVehicles), true)
            end

            if #upgradeList > 0 then
                gg.setValues(upgradeList)
                showToast("All parts maxed")
                LOG.info(TAG, "Done. Total writes: " .. tostring(#upgradeList))
            else
                showToast("Failed to max parts")
                LOG.warn(TAG, "upgradeList is empty.")
            end

            finishTask()
            done()
        end)
    end)

end
