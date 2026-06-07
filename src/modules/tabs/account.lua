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
    
    addModule(container, "max_mastery", "Max Mastery", "Max all vehicles masteries instantly.", "button", nil,
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
end
