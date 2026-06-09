--[[
  Account Tab - Player profile modifications
  Features: Change player name, Fake VIP status
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "change_name", "Change Name", "Change your player name", "input", {
        {hint = "Enter Name", value = "", type = "text"}
    }, function(done, val)
        scheduler:add(function(finish_task)
            if val ~= nil and val ~= "" then
                local name = val
                local tempString = {}
                local byteSize = 0

                for _, code in utf8.codes(name) do
                    local encoded = utf8.char(code)
                    local bytes = {encoded:byte(1, -1)}
                    if byteSize + #bytes > 12 then
                        showDialog("Name Too Long", "Your name is too long, please shorten it", "OK")
                        
                        finish_task()
                        done()
                        return
                    end
                    for _, b in ipairs(bytes) do
                        table.insert(tempString, b)
                        byteSize = byteSize + 1
                    end
                end

                while #tempString < 12 do
                    table.insert(tempString, 0)
                end

                local getPlayerNamePtr = gg.getValues({{
                    address = BaseGameStatus + 0x38,
                    flags = 32
                }})[1].value

                local toEdit = {{
                    address = getPlayerNamePtr,
                    flags = 1,
                    value = byteSize * 2
                }}

                for i = 1, #tempString do
                    toEdit[#toEdit + 1] = {
                        address = getPlayerNamePtr + i,
                        flags = 1,
                        value = tempString[i]
                    }
                end

                gg.setValues(toEdit)
                showToast("Name changed to " .. name)
            end
            
            finish_task()
            done()
        end)
    end)

    addArchModule(container, "fake_vip", "Fake VIP", "Toggle vip subscription state locally", "switch", nil, aobs.fakeVip)
    
    addModule(container, "fake_rank", "Fake Rank", "Set your rank to fake legendary automatically", "button", nil, function(done)
        scheduler:add(function(finish_task)
            gg.setValues({{
                address = BaseGameStatus + 0x1CC,
                flags = 16,
                value = 50.0
            }, {
                address = BaseGameStatus + 0x200,
                flags = 16,
                value = 50.0
            }})
            
            showToast("Fake Rank has been injected, please don't do this twice for safety.")
            finish_task()
            done()
        end)
    end)
    
    addModule(container, "max_vehicles", "Max Vehicles", "Max all unlocked vehicles upgrade levels instantly.", "button", nil,
    function(done)
        local TAG = "MaxVehicles"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finish_task)
            local vehicleListPtr = gg.getValues({{ address = BaseGameStatus + 0xB8, flags = 32 }})[1].value
            local totalVehicles  = gg.getValues({{ address = BaseGameStatus + 0xC0, flags = 4  }})[1].value

            if not vehicleListPtr or vehicleListPtr == 0 then
                showToast("Failed to resolve vehicle list")
                LOG.fatal(TAG, "vehicleListPtr is nil or 0.")
                finish_task()
                done()
                return
            end

            LOG.dbg(TAG, "Total vehicles: " .. tostring(totalVehicles))

            local upgradeList = {}

            for i = 0, totalVehicles - 1 do
                local vehiclePtr = gg.getValues({{ address = vehicleListPtr + i * 8, flags = 32 }})[1].value
                if vehiclePtr and vehiclePtr ~= 0 then
                    local namePtr    = gg.getValues({{ address = vehiclePtr + 0x18, flags = 32 }})[1].value
                    local vehicleName = namePtr ~= 0 and readString(namePtr + 1) or "unknown"
                    local isLowrider  = vehicleName:find("lowrider") ~= nil
                    local upgradeSlots = isLowrider and 5 or 4

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
            end

            if #upgradeList > 0 then
                gg.setValues(upgradeList)
                showToast("All vehicles maxed")
                LOG.info(TAG, "Done. Total writes: " .. tostring(#upgradeList))
            else
                showToast("Failed to max vehicles")
                LOG.warn(TAG, "upgradeList is empty.")
            end

            finish_task()
            done()
        end)
    end)

    addModule(container, "max_mastery", "Max Mastery", "Max all unlocked and maxed vehicles masteries instantly.", "button", nil,
    function(done)
        local TAG = "MaxMastery"

        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finish_task)
            local masteryTimeStamp = os.time(os.date("!*t"))

            -- Resolve vehicle list
            local getVehicleList = gg.getValues({{
                address = BaseGameStatus + 0xB8,
                flags = 32
            }})

            if not getVehicleList or not getVehicleList[1] or getVehicleList[1].value == 0 then
                showToast("Failed to max masteries")
                LOG.fatal(TAG, "Failed to resolve vehicle list pointer.")
                finish_task()
                done()
                return
            end

            local vehicleListPtr = getVehicleList[1].value

            local getTotalVehicles = gg.getValues({{
                address = BaseGameStatus + 0xC0,
                flags = 4
            }})

            if not getTotalVehicles or not getTotalVehicles[1] or getTotalVehicles[1].value == 0 then
                showToast("Failed to max masteries")
                LOG.fatal(TAG, "Failed to resolve total vehicles count.")
                finish_task()
                done()
                return
            end

            local totalVehicles = getTotalVehicles[1].value
            LOG.dbg(TAG, "Total vehicles found: " .. tostring(totalVehicles))

            local successCount = 0
            local skipCount = 0

            for i = 1, totalVehicles do
                local getVehiclePtr = gg.getValues({{
                    address = vehicleListPtr + (i - 1) * 8,
                    flags = 32
                }})

                if not getVehiclePtr or not getVehiclePtr[1] or getVehiclePtr[1].value == 0 then
                    skipCount = skipCount + 1
                    goto continue
                end

                local vehicleAddress = getVehiclePtr[1].value

                -- Read vehicle name for logging
                local getNamePtr = gg.getValues({{
                    address = vehicleAddress + 0x18,
                    flags = 32
                }})
                local vehicleName = "Unknown"
                if getNamePtr and getNamePtr[1] and getNamePtr[1].value ~= 0 then
                    vehicleName = readString(getNamePtr[1].value + 1)
                end

                -- Check masteryPointer
                local getMasteryPtr = gg.getValues({{
                    address = vehicleAddress + 0x120,
                    flags = 32
                }})

                if not getMasteryPtr or not getMasteryPtr[1] or getMasteryPtr[1].value == 0 then
                    LOG.dbg(TAG, "[" .. vehicleName .. "] masteryPointer is 0. Skipping (not maxed).")
                    skipCount = skipCount + 1
                    goto continue
                end

                local masteryPointer = getMasteryPtr[1].value

                -- Read 4 caPointers
                local caPointerReads = {}
                for j = 0, 3 do
                    table.insert(caPointerReads, { address = masteryPointer + j * 8, flags = 32 })
                end

                local caPointers = gg.getValues(caPointerReads)
                local validCaPointers = {}

                if caPointers then
                    for _, p in ipairs(caPointers) do
                        if p and p.value and p.value ~= 0 then
                            table.insert(validCaPointers, p.value)
                        end
                    end
                end

                if #validCaPointers == 0 then
                    LOG.dbg(TAG, "[" .. vehicleName .. "] No valid caPointers. Skipping (no mastery).")
                    skipCount = skipCount + 1
                    goto continue
                end

                -- Write mastery
                local toEdit = {}
                for _, p in ipairs(validCaPointers) do
                    table.insert(toEdit, { address = p + 0x18, flags = 4, value = 65793 })
                    table.insert(toEdit, { address = p + 0x1C, flags = 4, value = masteryTimeStamp })
                end

                gg.setValues({{
                    address = vehicleAddress + 0x120, flags = 32, value = masteryPointer
                }, {
                    address = vehicleAddress + 0x128, flags = 4, value = 4
                }, {
                    address = vehicleAddress + 0x12C, flags = 4, value = 4
                }, {
                    address = vehicleAddress + 0x130, flags = 4, value = 4
                }})

                gg.setValues(toEdit)

                LOG.info(TAG, "[" .. vehicleName .. "] Mastery maxed successfully.")
                successCount = successCount + 1

                ::continue::
            end

            LOG.info(TAG, string.format("Complete. Success: %d | Skipped: %d", successCount, skipCount))

            if successCount > 0 then
                showToast("All masteries maxed")
            else
                showToast("Failed to max masteries")
            end

            finish_task()
            done()
        end)
    end)
    
        local partMaxLevel = {
        start_boost            = 10,
        perfect_landing_boost  = 7,
        jump                   = 10,
        wheelie_boost          = 10,
        afterburner            = 7,
        fume_boost             = 10,
        thrusters              = 4,
        glide                  = 15,
        fuel_boost             = 4,
        coin_boost             = 4,
        winter_tyres           = 15,
        magnet                 = 15,
        spoiler                = 7,
        turbo_boost            = 7,
        flip_speed_boost       = 10,
        nitro                  = 4,
        air_control            = 15,
        heavyweight            = 15,
        rollcage               = 15,
        echo                   = 3,
        amplifier              = 3,
    }
    
    addModule(container, "max_parts", "Max Parts", "Max all unlocked parts levels for all vehicles instantly.", "button", nil,
    function(done)
        local TAG = "MaxParts"
        LOG.info(TAG, "Module activated.")

        scheduler:add(function(finish_task)
            local vehicleListPtr = gg.getValues({{ address = BaseGameStatus + 0xB8, flags = 32 }})[1].value
            local totalVehicles  = gg.getValues({{ address = BaseGameStatus + 0xC0, flags = 4  }})[1].value

            if not vehicleListPtr or vehicleListPtr == 0 then
                showToast("Failed to resolve vehicle list")
                LOG.fatal(TAG, "vehicleListPtr is nil or 0.")
                finish_task()
                done()
                return
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
                                local namePtr    = gg.getValues({{ address = partPtr + 0x18, flags = 32 }})[1].value
                                local partName   = "unknown"

                                if namePtr and namePtr ~= 0 then
                                    local header = gg.getValues({{ address = namePtr, flags = 4 }})[1].value
                                    if header == 49 then
                                        local namePtr2 = gg.getValues({{ address = namePtr + 0x10, flags = 32 }})[1].value
                                        partName = namePtr2 ~= 0 and readString(namePtr2 + 1) or "unknown"
                                    else
                                        partName = readString(namePtr + 1)
                                    end
                                end

                                local levelEdit = 3 -- default for unknown
                                for key, maxLvl in pairs(partMaxLevel) do
                                    if partName:find(key) then
                                        levelEdit = maxLvl
                                        break
                                    end
                                end

                                LOG.dbg(TAG, "[" .. partName .. "] max level: " .. tostring(levelEdit))
                                table.insert(upgradeList, { address = partPtr + 0x20, flags = 4, value = levelEdit })
                                table.insert(upgradeList, { address = partPtr + 0x34, flags = 4, value = levelEdit })
                            end
                        end
                    end
                end
            end

            if #upgradeList > 0 then
                gg.setValues(upgradeList)
                showToast("All parts maxed")
                LOG.info(TAG, "Done. Total writes: " .. tostring(#upgradeList))
            else
                showToast("Failed to max parts")
                LOG.warn(TAG, "upgradeList is empty.")
            end

            finish_task()
            done()
        end)
    end)
    
end
