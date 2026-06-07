-- core/arch.lua — Architecture detection + manifest-driven data loading
-- Sets globals: DEVICE_ARCH, aobs, offsets
-- Depends on: loadModule, memory (already set), gg, showDialog

-- ── Semver helpers ────────────────────────────────────────────────────────────

local function semver(v)
    local a, b, c = v:match("(%d+)%.(%d+)%.(%d+)")
    if not a then return 0 end
    return tonumber(a) * 1e6 + tonumber(b) * 1e3 + tonumber(c)
end

-- Parses "1.73.0" or "1.73.0-1.73.1" range keys.
local function inRange(range, version)
    local lo, hi = range:match("^([%d%.]+)-([%d%.]+)$")
    if not lo then lo = range; hi = range end
    local v = semver(version)
    return v >= semver(lo) and v <= semver(hi)
end


-- ── Architecture detection ────────────────────────────────────────────────────

-- ELF e_machine values as read from libcocos2dcpp.so + 0x10 (DWORD).
local ARCH_MAP = {
    [11993091] = "arm64-v8a",
    [4063235]  = "x86_64",
    [2621443]  = "armeabi-v7a",
    [196611]   = "x86",
}

local ranges = gg.getRangesList("libcocos2dcpp.so")
if #ranges > 0 then
    local val = gg.getValues({{ address = ranges[1].start + 0x10, flags = gg.TYPE_DWORD }})[1]
    DEVICE_ARCH = ARCH_MAP[val and tonumber(val.value)] or "unknown"
    BaseLib = ranges[1].start
end

if DEVICE_ARCH == "unknown" then
    showDialog("Architecture Warning", "Your architecture is unknown, is the lib loaded? What system you're using?", "Proceed Anyway")
end

if DEVICE_ARCH ~= "arm64-v8a" then
    showDialog("Architecture Warning",
        ("Detected: %s\nSome or all lib-patches may not work."):format(DEVICE_ARCH),
        "Proceed Anyway")
end


-- ── Manifest-driven data resolution ──────────────────────────────────────────

-- manifest.lua returns: { [version_range] = { [arch] = "data/path/to/file.lua" } }
local manifest = loadModule("data/manifest.lua")

local pkgVersion = (gg.getTargetInfo() or {}).versionName
if type(pkgVersion) ~= "string" then
    showDialog("Warning", "Game version unknown. Try again after the game loads.", "OK")
    os.exit()
end

local function resolveData(version, arch)
    for range, archMap in pairs(manifest) do
        if inRange(range, version) then
            local path = archMap[arch] or archMap[DEFAULT_ARCH]
            if path then return loadModule(path) end
        end
    end
    return nil
end

local data = resolveData(pkgVersion, DEVICE_ARCH)

if not data then
    showDialog("Unsupported Version",
        ("No data found for v%s on %s.\nCheck manifest.lua."):format(pkgVersion, DEVICE_ARCH), "OK")
end

aobs    = data.aobs    or {}
offsets = data.offsets or {}
