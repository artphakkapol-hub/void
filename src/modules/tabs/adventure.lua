--[[
  Adventure Tab - Adventure mode features
  Status: Set Distance 
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "set_distance", "Set Distance", "Sets your Adventure race distance to a custom value. Must be in an active race. Higher distance can gain more stars. Max stars that can be gained is 5000. (Not a teleport function)", "slider",
    {title="Meters", min=0, max=5000, current=0},
    function(done, vals)
        local target_meters = vals
        local TAG = "SetDistance"

        LOG.info(TAG, "Module activated. Target meters: " .. tostring(target_meters))

        scheduler:add(function(finish_task)
            local activeTab = gg.getValues({{ address = BaseGameStatusRaw - 0xD4, flags = 4 }})
            local isAdventureTab = (type(activeTab) == "table" and activeTab[1] and activeTab[1].value == 0)

            if not isAdventureTab then
                showToast("Go to Adventure tab and start a race first")
                LOG.warn(TAG, "User is not in Adventure tab. Aborting.")
                finish_task()
                done()
                return
            end

            LOG.dbg(TAG, "Adventure tab confirmed. Resolving lib anchor...")

            local anchorTarget = BaseLib + offsets.lib_setDistanceBase
            LOG.dbg(TAG, string.format("Lib base: 0x%X | Anchor target: 0x%X", BaseLib, anchorTarget))

            gg.clearResults()
            gg.setRanges(BaseRegion)
            gg.searchNumber(anchorTarget, 32)

            local level1Results = gg.getResults(gg.getResultsCount())
            gg.clearResults()
            LOG.dbg(TAG, "Level 1 references found: " .. tostring(#level1Results))

            if #level1Results == 0 then
                showToast("Start a race first")
                LOG.warn(TAG, "No references found for anchor. User likely not in a race.")
                finish_task()
                done()
                return
            end

            local distanceBase = nil

            for _, ref1 in ipairs(level1Results) do
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber(ref1.address, 32)

                local level2Results = gg.getResults(gg.getResultsCount())
                gg.clearResults()
                
                for _, ref2 in ipairs(level2Results) do
                    local offsetAddr = ref2.address - 0xAC

                    gg.clearResults()
                    gg.setRanges(gg.REGION_C_ALLOC)
                    gg.searchNumber(offsetAddr, 32)

                    local level3Results = gg.getResults(gg.getResultsCount())
                    gg.clearResults()
                    
                    if #level3Results > 0 then
                        local pointerReads = {}
                        for _, ref3 in ipairs(level3Results) do
                            table.insert(pointerReads, { address = ref3.address, flags = 32 })
                        end

                        local resolvedPointers = gg.getValues(pointerReads)
                        if resolvedPointers then
                            for _, ptr in ipairs(resolvedPointers) do
                                if ptr and ptr.value and ptr.value ~= 0 then
                                    distanceBase = ptr.value
                                    LOG.info(TAG, string.format("distanceBase resolved: 0x%X", distanceBase))
                                    break
                                end
                            end
                        end
                    end

                    if distanceBase then break end
                end

                if distanceBase then break end
            end

            if not distanceBase then
                showToast("Start a race first")
                LOG.fatal(TAG, "Failed to resolve distanceBase. Pointer chain dropped.")
                finish_task()
                done()
                return
            end
            
            gg.clearResults()
            
            gg.setValues({
                { address = distanceBase + 0x0,  flags = 4,  value = target_meters },
                { address = distanceBase + 0x10, flags = 16, value = 2000000000 },
                { address = distanceBase + 0x14, flags = 16, value = 2000000000 }
            })
            
            showToast("Distance set to: " .. tostring(target_meters) .. "m")
            LOG.info(TAG, "Distance set to: " .. tostring(target_meters) .. "m")
            finish_task()
            done()
        end)
    end)
end