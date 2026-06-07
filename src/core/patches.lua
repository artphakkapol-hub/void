--[[
  Architecture-aware patch and module handler
  Manages device architecture-specific patches and callbacks.
  Integrates memory persistence and task scheduling for patch application.
]]

---Formats a list of architectures as a human-readable string.
---@param archTable table Map of {arch_name = data} pairs
---@return string Comma-separated list of architecture names
local function getArchList(archTable)
    local list = {}
    for arch in pairs(archTable) do
        table.insert(list, arch)
    end
    return table.concat(list, " or ")
end

---Resolves architecture-specific data based on current device architecture.
---@param callback_or_patch any Either a callback function or table of {[arch]=data}
---@param mode string The module mode ("switch", "button", etc.)
---@return table Architecture map
---@return any Data matching current device architecture, or nil if not available
local function resolveArch(callback_or_patch, mode)
    local archTable
    if mode == "switch" and type(callback_or_patch) == "table" then
        if callback_or_patch[1] and callback_or_patch[1].scan then
            archTable = { [DEFAULT_ARCH] = callback_or_patch }
        else
            archTable = callback_or_patch
        end
    elseif type(callback_or_patch) == "table" then
        archTable = callback_or_patch
    else
        archTable = { [DEFAULT_ARCH] = callback_or_patch }
    end

    return archTable, archTable[DEVICE_ARCH]
end

---Applies a memory patch by searching for bytes and modifying values.
---Uses cached addresses if available, otherwise performs new searches.
---Patch entry format: {scan=hex_bytes, offset=number, patch=value, unpatch=value}
---@param id string Unique patch identifier for caching
---@param entries table Array of patch entries to apply
---@param enable boolean True to apply patch, false to revert
---@return number Number of patch entries that failed to apply
local function applyPatch(id, entries, enable)
    local failed = 0
    local cache = memory:load(id)

    if cache then
        local values = {}
        for i, entry in ipairs(entries) do
            if cache[i] then
                table.insert(values, {
                    address = cache[i],
                    flags = gg.TYPE_DWORD,
                    value = enable and entry.patch or entry.unpatch
                })
            else
                failed = failed + 1
            end
        end
        if #values > 0 then gg.setValues(values) end
    else
        local cached = {}
        local values = {}

        gg.setRanges(8 | 16)
        for i, entry in ipairs(entries) do
            gg.clearResults()
            gg.searchNumber(entry.scan, gg.TYPE_BYTE)
            local count = gg.getResultsCount()
            if count > 0 then
                local result = gg.getResults(1)
                local addr = result[1].address + entry.offset
                cached[i] = addr
                table.insert(values, {
                    address = addr,
                    flags = gg.TYPE_DWORD,
                    value = enable and entry.patch or entry.unpatch
                })
            else
                failed = failed + 1
            end
        end

        gg.clearResults()

        if #values > 0 then gg.setValues(values) end
        if failed == 0 then memory:save(id, cached) end
    end

    return failed
end

---Creates a module card with architecture-specific patch or callback support.
---Automatically validates device architecture and enables/disables based on compatibility.
---@param parent View The parent layout view
---@param id string Unique module identifier
---@param title string Module display title
---@param desc string Module description
---@param mode string Module type: "switch" (toggle), "button" (action), "ro" (read-only), etc.
---@param extra any Mode-specific data (options, config, etc.)
---@param callback_or_patch any Function callback or patch definition table(s)
---@return nil
function addArchModule(parent, id, title, desc, mode, extra, callback_or_patch)
    if mode == "ro" then
        addModule(parent, id, title, desc, mode, extra, nil)
        return
    end

    local archTable, resolved = resolveArch(callback_or_patch, mode)

    if not resolved then
        addModule(parent, id .. "_na", title,
            "Requires " .. getArchList(archTable) .. " device (your device: " .. DEVICE_ARCH .. ")",
            "ro", "Not Available", nil)
        return
    end

    local finalCallback
    if mode == "switch" and type(callback_or_patch) == "table" then
        finalCallback = function(done, state)
            scheduler:add(function(finish_task)
                local failed = applyPatch(id, resolved, state)
                if failed == 0 then
                    showToast(title .. (state and " Enabled" or " Disabled"), true)
                else
                    showToast("Failed: " .. failed .. " pattern(s) not found", true)
                end
                gg.clearResults()
                
                finish_task()
                done()
            end)
        end
    else
        finalCallback = function(done, ...)
            local args = {...}
            scheduler:add(function(finish_task)
                resolved(function()
                    finish_task()
                    done()
                end, table.unpack(args))
            end)
        end
    end

    addModule(parent, id, title, desc, mode, extra, finalCallback)
end
