--[[
  Cups Tab - Cup racing modes
  Features: Auto-win races
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    
    addModule(container, "countdown_adjust", "Countdown Adjust", "Adjust the countdown before starting race", "slider",
    {title="Seconds", min=0, max=10, current=3},
    function(done, vals)
        local countdown_value = vals 

        scheduler:add(function(finish_task)
            local cache = memory:load("countdown_adjust")
            
            if cache and #cache > 0 then
                gg.clearResults()
                gg.loadResults(cache)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(16) 
                gg.searchNumber("h 00 00 40 40 00 00 80 40 00 00 40 41", 1)
                gg.refineNumber("h 00 00 40 40", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("countdown_adjust", results)
            end
            
            gg.editAll(cast.float(countdown_value), 1)
            
            showToast("Countdown adjusted to " .. tostring(countdown_value) .. "s", true)
            gg.clearResults()
            finish_task()
            done()
        end)
    end)
    
    addArchModule(container, "auto_win", "Auto Win", "Automatically win no matter what your race results is", "switch", nil, aobs.autoWinPatches)
    
    addModule(container, "force_cup", "Force Cup", "Forces a single cup", "switch", nil,
    function(done, state)
        local TAG = "ForceCup"

        scheduler:add(function(finish_task)
            if state then
                LOG.info(TAG, "Enabling Force Cup...")

                local cache = memory:load("force_cup_cache")

                -- Verify cache is still valid
                if cache then
                    LOG.dbg(TAG, string.format("Cache found. Verifying base address: 0x%X", cache.base))
                    local verify = gg.getValues({{ address = cache.base, flags = 1 }})
                    if not verify or not verify[1] or verify[1].value ~= 0xB8 then
                        LOG.warn(TAG, "Base address moved. Invalidating cache and re-searching...")
                        cache = nil
                        memory:save("force_cup_cache", nil)
                    else
                        LOG.dbg(TAG, "Base address valid. Using cache.")
                    end
                end

                -- Search if no cache
                if not cache then
                    LOG.dbg(TAG, "No cache. Executing pattern search...")
                    gg.clearResults()
                    gg.setRanges(BaseRegion)
                    gg.searchNumber("h B8 1E 85 3F CD CC 4C 3F", 1)

                    local results = gg.getResults(10)
                    gg.clearResults()

                    if #results == 0 then
                        showToast("Force Cup not found. Try again later.")
                        LOG.error(TAG, "Pattern not found in memory.")
                        finish_task()
                        done()
                        return
                    end

                    local base = results[1].address
                    LOG.info(TAG, string.format("Pattern found at: 0x%X", base))

                    cache = {
                        base = base,
                        items = {
                            { address = base - 0x308, flags = 4, value = 1953063706 },
                            { address = base - 0x304, flags = 4, value = 1869373305 },
                            { address = base - 0x300, flags = 4, value = 1667196782 },
                            { address = base - 0x2FC, flags = 4, value = 28789     },
                            { address = base - 0x2F8, flags = 4, value = 0         },
                        }
                    }

                    memory:save("force_cup_cache", cache)
                    LOG.info(TAG, "Cache saved.")
                end

                -- Freeze
                local freezeItems = {}
                for _, item in ipairs(cache.items) do
                    table.insert(freezeItems, {
                        address = item.address,
                        flags   = item.flags,
                        value   = item.value,
                        freeze  = true
                    })
                end

                gg.addListItems(freezeItems)
                showToast("Force Cup Enabled")
                LOG.info(TAG, "Force Cup enabled. Items frozen.")

            else
                LOG.info(TAG, "Disabling Force Cup...")

                local cache = memory:load("force_cup_cache")

                if cache then
                    local unfreezeItems = {}
                    for _, item in ipairs(cache.items) do
                        table.insert(unfreezeItems, {
                            address = item.address,
                            flags   = item.flags,
                            value   = item.value,
                            freeze  = false
                        })
                    end

                    gg.removeListItems(unfreezeItems)
                    LOG.info(TAG, "Force Cup disabled. Items unfrozen.")
                else
                    LOG.warn(TAG, "No cache found on disable. Nothing to unfreeze.")
                end

                showToast("Force Cup Disabled")
            end

            finish_task()
            done()
        end)
    end)
    
    addModule(container, "unlimited_tasks", "Unlimited Tasks", "Freeze all tasks as completed and always claimable. Claim rewards repeatedly.", "switch", nil,
    function(done, state)
        local TAG = "UnlimitedTasks"

        scheduler:add(function(finish_task)
            local ptr1 = gg.getValues({{ address = BaseGameStatus + 0x6F8, flags = 32 }})[1].value

            if not ptr1 or ptr1 == 0 then
                showToast("Failed to resolve task list")
                LOG.fatal(TAG, "Ptr1 is nil or 0.")
                finish_task()
                done()
                return
            end

            local totalTasks = gg.getValues({{ address = BaseGameStatus + 0x700, flags = 4 }})[1].value

            if not totalTasks or totalTasks == 0 then
                showToast("No tasks found")
                LOG.warn(TAG, "totalTasks is 0.")
                finish_task()
                done()
                return
            end

            LOG.dbg(TAG, "Total tasks: " .. tostring(totalTasks))

            local freezeItems = {}

            for i = 0, totalTasks - 1 do
                local ptr2 = gg.getValues({{ address = ptr1 + i * 8, flags = 32 }})[1].value

                if ptr2 and ptr2 ~= 0 then
                    local completeTarget = gg.getValues({{ address = ptr2 + 0x1C, flags = 4 }})[1].value

                    if completeTarget and completeTarget > 0 then
                        table.insert(freezeItems, { address = ptr2 + 0x1C, flags = 4, value = completeTarget, freeze = state })
                        table.insert(freezeItems, { address = ptr2 + 0x20, flags = 4, value = completeTarget, freeze = state })
                        table.insert(freezeItems, { address = ptr2 + 0x24, flags = 4, value = 0,             freeze = state })
                        LOG.dbg(TAG, string.format("Task [%d] queued. completeTarget: %d", i, completeTarget))
                    end
                end
            end

            if #freezeItems > 0 then
                if state then
                    gg.addListItems(freezeItems)
                    showToast("Unlimited Tasks Enabled")
                    LOG.info(TAG, "Enabled. Frozen " .. tostring(#freezeItems / 3) .. " tasks.")
                else
                    gg.removeListItems(freezeItems)
                    showToast("Unlimited Tasks Disabled")
                    LOG.info(TAG, "Disabled. Unfrozen " .. tostring(#freezeItems / 3) .. " tasks.")
                end
            else
                showToast("No tasks to freeze")
                LOG.warn(TAG, "freezeItems is empty.")
            end

            finish_task()
            done()
        end)
    end)
end
