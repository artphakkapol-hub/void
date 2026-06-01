--[[
  Player Tab - Vehicle and character modifications
  Features: Auto-detach parts, No-clip mode, Hide name/flag, Zoom adjust, Gravity adjust
  
  @module callback Receives container View to populate with modules
]]

-- Dependencies: addModule, addArchModule, showToast, memory, BaseGameStatus, BaseRegion, scheduler

return function(container)
    
    addArchModule(container, "auto_detach", "Auto Detach", "Automatically detach parts like the Rally Car roof", "switch", nil, aobs.autoDetach)

    addModule(container, "no_clip", "No-Clip", "Make your player go through objects without dying", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("no_clip")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(8)
                gg.searchNumber("h 0A D7 23 3C 00 00 00 00 00 00 20 C1", 1)
                gg.refineNumber("h 0A D7 23 3C", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("no_clip", results)
            end
            if state then
                gg.editAll("h CD CC 08 C1", 1)
                showToast("No-Clip Enabled", true)
            else
                gg.editAll("h 0A D7 23 3C", 1)
                showToast("No-Clip Disabled", true)
            end
            gg.clearResults()
            
            finish_task() -- Release scheduler block for next mod
            done()        -- Notify UI toggle update
        end)
    end)

    addModule(container, "hide_name", "Hide Name", "Hide your player name at race", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("hide_name")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h BF 7D AD C1 64 CC 73 41 71 3D 0A 3F 71 3D 0A 3F", 1)
                gg.refineNumber("h 71 3D 0A 3F 71 3D 0A 3F", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_name", results)
            end
            if state then
                gg.editAll("h 00 00 00 00 00 00 00 00", 1)
                showToast("Hide Name Enabled", true)
            else
                gg.editAll("h 71 3D 0A 3F 71 3D 0A 3F", 1)
                showToast("Hide Name Disabled", true)
            end
            gg.clearResults()
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "hide_flag", "Hide Flag", "Hide your player flag at race", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("hide_flag")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h 2E FF D7 C1 36 CD 73 41 00 00 80 3F 00 00 80 3F 00 00 00 3F 00 00 00 3F FF FF FF FF 00 00 08 42 00 00 C0 41", 1)
                gg.refineNumber("h 00 00 08 42 00 00 C0 41", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_flag", results)
            end
            if state then
                gg.editAll("h 00 00 00 00 00 00 00 00", 1)
            else
                gg.editAll("h 00 00 08 42 00 00 C0 41", 1)
            end
            gg.clearResults()
            local preload2 = memory:load("hide_flag2")
            if preload2 then
                gg.clearResults()
                gg.loadResults(preload2)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h 61 32 DB C1 02 9A 70 41 C8 07 5D 3F 63 EE 5A 3F 00 00 00 3F 00 00 00 3F FF FF FF FF 00 00 44 42 00 00 20 42", 1)
                gg.refineNumber("h FF FF FF FF", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_flag2", results)
            end
            if state then
                gg.editAll("h 00 00 00 00", 1)
                showToast("Hide Flag Enabled", true)
            else
                gg.editAll("h FF FF FF FF", 1)
                showToast("Hide Flag Disabled", true)
            end
            gg.clearResults()
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "zoom", "Zoom Adjust", "Adjust how close or far your camera", "slider", {
        {title="Min", min=10, max=100, current=20},
        {title="Max", min=10, max=100, current=50}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local results = memory:load("zoom")
            if not results then
                gg.clearResults()
                gg.setRanges(16)
                gg.searchNumber("20;50::5", 16)
                results = gg.getResults(gg.getResultsCount())
                gg.clearResults()
                if #results > 0 then memory:save("zoom", results) end
            end
            if results then
                for i, v in ipairs(results) do
                    v.value = (i % 2 == 1) and vals[1] or vals[2]
                    v.flags = 16
                end
                gg.setValues(results)
            end
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "gravity", "Gravity Adjust", "Adjust how strong is the gravity", "slider", {
        {title="X", min=-100, max=100, current=0},
        {title="Y", min=-100, max=100, current=-10}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local allGravity = memory:load("gravity")

            if not allGravity then
                allGravity = { x = {}, y = {} }
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("00000021h;00000000h;0000001Ah;00000000h;00000031h;00000000h;00000028h;00000000h;00000000h;00000017h;00000000h;756F4316h;7972746Eh;65646973h::81", 4)
                gg.refineNumber("00000021h", 4)

                local results = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #results > 0 then
                    local toProcess = {}
                    for _, v in ipairs(results) do
                        gg.searchNumber(v.address, 32)
                        local ptrResults = gg.getResults(gg.getResultsCount())
                        gg.clearResults()
                        for __, ptr in ipairs(ptrResults) do
                            local getPtr = gg.getValues({{ address = ptr.address + 0x8, flags = 32 }})[1].value
                            local checkVal = gg.getValues({{ address = getPtr, flags = 4 }})[1].value
                            if checkVal == 0x74616E2A then
                                table.insert(toProcess, ptr.address)
                            end
                        end
                    end

                    for _, baseAddr in ipairs(toProcess) do
                        local currentAddr = baseAddr
                        while true do
                            local gravityPtr = gg.getValues({{ address = currentAddr, flags = 32 }})[1].value
                            if gravityPtr == 0 then break end
                            local region = gg.getValuesRange({{ address = gravityPtr, flags = 32 }})[1]
                            if region == "Ca" or region == "O" then
                                local check = gg.getValues({{ address = gravityPtr + 0x48, flags = 4 }})[1].value
                                if check ~= 0 then
                                    table.insert(allGravity.x, {address = gravityPtr + 0x120, flags = 16})
                                    table.insert(allGravity.y, {address = gravityPtr + 0x124, flags = 16})
                                else
                                    break
                                end
                            else
                                break
                            end
                            currentAddr = currentAddr + 0x8
                        end
                    end
                    memory:save("gravity", allGravity)
                end
            end

            if #allGravity.x > 0 then
                for i = 1, #allGravity.x do
                    allGravity.x[i].value = vals[1]
                    allGravity.y[i].value = vals[2]
                end
                gg.setValues(allGravity.x)
                gg.setValues(allGravity.y)
            end
            
            finish_task()
            done()
        end)
    end)
end
