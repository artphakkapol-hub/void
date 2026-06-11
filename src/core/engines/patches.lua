-- core/engines/patches.lua — Memory patch engine + architecture-aware module helper
-- Exposes globals: addArchModule
-- Depends on: memory, scheduler, gg (all loaded before this file)

-- ── Internal helpers ──────────────────────────────────────────────────────────

---Returns a human-readable list of supported architectures from a patch table.
---@param arch_map table { [arch_name] = data }
---@return string Comma-separated architecture names, e.g. "arm64-v8a or x86_64"
local function arch_list_string(arch_map)
    local names = {}
    for arch in pairs(arch_map) do
        table.insert(names, arch)
    end
    return table.concat(names, " or ")
end

---Returns true if `t` is a flat array of patch entries (each entry has a `scan` key).
---Used to distinguish { {scan=…}, {scan=…} } from { ["arm64-v8a"] = {…} }.
---@param t table
---@return boolean
local function is_patch_list(t)
    return type(t) == "table" and type(t[1]) == "table" and t[1].scan ~= nil
end

---Normalises the `patch_or_callback` argument of addArchModule into an arch map.
---
--- Accepted forms:
---   • Flat patch list  { {scan, offset, patch, unpatch}, … }  → wrapped under DEFAULT_ARCH
---   • Arch map         { ["arm64-v8a"] = { {…}, … }, … }
---   • Callback         function(done, ...)                     → wrapped under DEFAULT_ARCH
---   • Arch-keyed cbs   { ["arm64-v8a"] = function, … }
---
---@param patch_or_callback any
---@return table arch_map  { [arch] = resolvedValue }
---@return any   resolved  Value for DEVICE_ARCH, or nil if unsupported
local function resolve_arch(patch_or_callback)
    local arch_map

    if is_patch_list(patch_or_callback) then
        -- Bare patch list — belongs to the default arch only.
        arch_map = { [DEFAULT_ARCH] = patch_or_callback }
    elseif type(patch_or_callback) == "table" then
        -- Must be an arch-keyed map (values are either patch lists or callbacks).
        arch_map = patch_or_callback
    else
        -- Bare callback function — belongs to the default arch only.
        arch_map = { [DEFAULT_ARCH] = patch_or_callback }
    end

    return arch_map, arch_map[DEVICE_ARCH]
end


-- ── Patch engine ──────────────────────────────────────────────────────────────

---Applies or reverts a set of memory patches.
---Addresses are resolved via AoB scan on first use and cached in persistent
---memory so subsequent calls skip the scan entirely.
---
---Patch entry format:
---  scan    = hex byte string for gg.TYPE_BYTE search
---  offset  = byte delta from scan hit to the target DWORD
---  patch   = value to write when enabling
---  unpatch = original value to restore when disabling
---
---@param id      string  Unique patch identifier (used as the cache key)
---@param entries table   Array of patch entries
---@param enable  boolean true → apply patch values, false → revert to unpatch values
---@return number fail_count Number of entries that could not be applied
local function apply_patch(id, entries, enable)
    local fail_count = 0
    local cached     = memory:load(id)

    if cached then
        -- Fast path: addresses already known, skip scanning.
        local writes = {}
        for i, entry in ipairs(entries) do
            if cached[i] then
                table.insert(writes, {
                    address = cached[i],
                    flags   = gg.TYPE_DWORD,
                    value   = enable and entry.patch or entry.unpatch,
                })
            else
                fail_count = fail_count + 1
            end
        end
        if #writes > 0 then gg.setValues(writes) end
    else
        -- Slow path: scan for each entry and cache found addresses.
        local new_cache = {}
        local writes    = {}

        gg.setRanges(8 | 16)
        for i, entry in ipairs(entries) do
            gg.clearResults()
            gg.searchNumber(entry.scan, gg.TYPE_BYTE)
            if gg.getResultsCount() > 0 then
                local addr = gg.getResults(1)[1].address + entry.offset
                new_cache[i] = addr
                table.insert(writes, {
                    address = addr,
                    flags   = gg.TYPE_DWORD,
                    value   = enable and entry.patch or entry.unpatch,
                })
            else
                fail_count = fail_count + 1
            end
        end

        gg.clearResults()
        if #writes     > 0 then gg.setValues(writes) end
        if fail_count == 0 then memory:save(id, new_cache) end
    end

    return fail_count
end


-- ── Architecture-aware module helper ─────────────────────────────────────────

---Creates a UI module card with automatic architecture validation.
---
---For "switch" mode with a patch table the engine handles enable/disable via
---apply_patch. For all other modes (button, slider, input, …) the resolved
---value must be a callback: function(done, ...).
---
---Read-only ("ro") modules bypass arch resolution entirely.
---
---@param parent           View   Parent layout view
---@param id               string Unique module identifier
---@param title            string Display title
---@param desc             string Description shown in the card
---@param mode             string "switch" | "button" | "slider" | "input" | "ro" | …
---@param extra            any    Mode-specific config (options table, slider config, etc.)
---@param patch_or_callback any   Patch list, arch-map, or callback (see resolve_arch)
function addArchModule(parent, id, title, desc, mode, extra, patch_or_callback)
    -- Read-only cards need no arch check.
    if mode == "ro" then
        addModule(parent, id, title, desc, mode, extra, nil)
        return
    end

    local arch_map, resolved = resolve_arch(patch_or_callback)

    -- No data for this arch → show a disabled placeholder card.
    if not resolved then
        addModule(parent, id .. "_na", title,
            "Requires " .. arch_list_string(arch_map) .. " device (your device: " .. DEVICE_ARCH .. ")",
            "ro", "Not Available", nil)
        return
    end

    local callback

    if mode == "switch" and is_patch_list(resolved) then
        -- Patch-backed toggle: delegate to apply_patch inside the scheduler.
        callback = function(done, state)
            scheduler:add(function(finish_task)
                local fail_count = apply_patch(id, resolved, state)
                if fail_count == 0 then
                    showToast(title .. (state and " Enabled" or " Disabled"), true)
                else
                    showToast("Failed: " .. fail_count .. " pattern(s) not found", true)
                end
                gg.clearResults()
                finish_task()
                done()
            end)
        end
    else
        -- Callback-backed module: call directly without wrapping in scheduler:add.
        -- The callback is responsible for its own scheduler:add usage internally.
        -- Wrapping here would cause a deadlock if the callback also calls scheduler:add,
        -- because the outer task would never call finish_task() while waiting on the
        -- inner task, which can't run until the outer task finishes.
        callback = function(done, ...)
            resolved(done, ...)
        end
    end

    addModule(parent, id, title, desc, mode, extra, callback)
end
