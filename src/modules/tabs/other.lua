--[[
  Other Tab - Other mode features
  Status: Resolution adjust, Resolution offset adjust
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "resolution", "Resolution Adjust", "Adjust the game width and height (default is 1280x720)", "input", {
        {hint = "Width", type = "number"},
        {hint = "Height", type = "number"}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local width = tonumber(vals[1]) or 1280
            local height = tonumber(vals[2]) or 720

            local results = memory:load("resolution")

            if not results then
                gg.clearResults()
                gg.setRanges(BaseRegion)

                gg.searchNumber(":Cocos2dxGLSurfaceView", 1)
                gg.refineNumber(":C", 1)
                local cocos = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #cocos == 0 then
                    gg.toast("GLSurfaceView not found")
                    finish_task()
                    done()
                    return
                end

                local addresses = {}

                for i, v in ipairs(cocos) do
                    gg.searchNumber(v.address, 32)
                    local ptrs = gg.getResults(gg.getResultsCount())
                    gg.clearResults()

                    for _, p in ipairs(ptrs) do
                        table.insert(addresses, p.address + 0x38)
                        table.insert(addresses, p.address + 0x3C)
                        table.insert(addresses, p.address + 0x40)
                        table.insert(addresses, p.address + 0x44)
                    end
                end

                if #addresses > 0 then
                    results = addresses
                    memory:save("resolution", results)
                else
                    finish_task()
                    done()
                    return
                end
            end

            if results and #results > 0 then
                local values = {}

                for i = 1, #results, 4 do
                    if results[i] then
                        table.insert(values, {address = results[i], flags = 4, value = width})
                        table.insert(values, {address = results[i+1], flags = 4, value = height})
                        table.insert(values, {address = results[i+2], flags = 4, value = width})
                        table.insert(values, {address = results[i+3], flags = 4, value = height})
                    end
                end

                if #values > 0 then
                    gg.setValues(values)
                    gg.toast(string.format("Resolution set to %dx%d", width, height))
                end
            end

            finish_task()
            done()
        end)
    end)

    addModule(container, "resolution_offset", "Resolution Offset Adjust", "Adjust the game width offset and height offset (default is 0x0), best for small resolution in a large screen.", "input", {
        {hint = "Width", type = "number"},
        {hint = "Height", type = "number"}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local width = tonumber(vals[1]) or 0
            local height = tonumber(vals[2]) or 0

            local results = memory:load("resolution_offset")

            if not results then
                gg.clearResults()
                gg.setRanges(BaseRegion)

                gg.searchNumber(":Cocos2dxGLSurfaceView", 1)
                gg.refineNumber(":C", 1)
                local cocos = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #cocos == 0 then
                    gg.toast("GLSurfaceView not found")
                    finish_task()
                    done()
                    return
                end

                local addresses = {}

                for i, v in ipairs(cocos) do
                    gg.searchNumber(v.address, 32)
                    local ptrs = gg.getResults(gg.getResultsCount())
                    gg.clearResults()

                    for _, p in ipairs(ptrs) do
                        table.insert(addresses, p.address + 0x30)
                        table.insert(addresses, p.address + 0x34)
                    end
                end

                if #addresses > 0 then
                    results = addresses
                    memory:save("resolution_offset", results) -- Fixed the bug where this overwritten the core resolution cache
                else
                    finish_task()
                    done()
                    return
                end
            end

            if results and #results > 0 then
                local values = {}

                for i = 1, #results, 2 do
                    if results[i] then
                        table.insert(values, {address = results[i], flags = 4, value = width})
                        table.insert(values, {address = results[i+1], flags = 4, value = height})
                    end
                end

                if #values > 0 then
                    gg.setValues(values)
                    gg.toast(string.format("Resolution offset set to %dx%d", width, height))
                end
            end

            finish_task()
            done()
        end)
    end)

    --[[
    addModule(container, "mods_packs", "Mods Packs", "Customize your game with exclusive community-made assets. Add new vehicle paints, unique textures, and custom designs without replacing existing files. (require game restart).\n\nRead help at https://zevrythel.net/modpack for making your own mods pack.", "spinner", {
        options = {"Default", "KAR's Pack"},
        default = 1
    }, function(done, item, index)
        gg.toast("Please Wait!")
        local cachesPaths = {
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/packages/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/packages/"
        }
        local successList = {}
        local failedList = {}
        for _, path in ipairs(cachesPaths) do
            -- TODO: implement pack swapping logic per path
        end
        showToast("Texture Pack changed to " .. item)
        gg.clearResults()
        done()
    end)
    ]]--
end
