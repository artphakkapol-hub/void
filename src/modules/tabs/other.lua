--[[
  Other Tab - Other mode features
  Status: Resolution adjust, Resolution offset adjust
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    local function t(key, ...) return T("other." .. key, ...) end

    addModule(container, "debug_mode", t("debug_mode.title"), t("debug_mode.desc"), "switch", nil, function(done, state)
        scheduler:add(function(finishTask)
            local TAG = "DebugMode"
            
            if state then
                gg.setValues({{
                    address = BaseGameStatusRaw + 0x3,
                    flags = 1,
                    value = 1
                }})
                showToast(t("debug_mode.enabled"), true)
            else
                gg.setValues({{
                    address = BaseGameStatusRaw + 0x3,
                    flags = 1,
                    value = 0
                }})
                showToast(t("debug_mode.disabled"), true)
            end
            
            finishTask()
            done()
        end)
    end)
    
    addModule(container, "resolution", t("resolution.title"), t("resolution.desc"), "input", {
        {hint = t("hint.width"), type = "number"},
        {hint = t("hint.height"), type = "number"}
    }, function(done, vals)
        scheduler:add(function(finishTask)
            local TAG = "Resolution"
            local width = tonumber(vals[1]) or 1280
            local height = tonumber(vals[2]) or 720
            LOG.info(TAG, string.format("Applying resolution: %dx%d", width, height))

            local results = memory:load("resolution")

            if not results then
                LOG.dbg(TAG, "No cache — searching for GLSurfaceView")
                gg.clearResults()
                gg.setRanges(BaseRegion)

                gg.searchNumber(":Cocos2dxGLSurfaceView", 1)
                gg.refineNumber(":C", 1)
                local cocos = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #cocos == 0 then
                    LOG.warn(TAG, "GLSurfaceView not found in memory")
                    gg.toast(t("glsurface_not_found"))
                    finishTask()
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
                    finishTask()
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
                    gg.toast(t("resolution.applied", width, height))
                end
            end

            finishTask()
            done()
        end)
    end)

    addModule(container, "resolution_offset", t("resolution_offset.title"), t("resolution_offset.desc"), "input", {
        {hint = t("hint.width"), type = "number"},
        {hint = t("hint.height"), type = "number"}
    }, function(done, vals)
        scheduler:add(function(finishTask)
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
                    gg.toast(t("glsurface_not_found"))
                    finishTask()
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
                    finishTask()
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
                    gg.toast(t("resolution_offset.applied", width, height))
                end
            end

            finishTask()
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
