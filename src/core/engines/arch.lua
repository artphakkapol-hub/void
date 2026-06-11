-- core/engines/arch.lua — Architecture detection + manifest-driven data loading
-- Sets globals: DEVICE_ARCH, BaseLib, aobs, offsets
-- Depends on: loadModule, memory (already loaded), gg, showDialog

-- ── Semver helpers ────────────────────────────────────────────────────────────

local function semver(v)
    local major, minor, patch = v:match("(%d+)%.(%d+)%.(%d+)")
    if not major then return 0 end
    return tonumber(major) * 1e6 + tonumber(minor) * 1e3 + tonumber(patch)
end

-- Parses "1.73.0" (exact) or "1.73.0-1.73.2" (inclusive range) keys.
local function in_range(range, version)
    local lo, hi = range:match("^([%d%.]+)-([%d%.]+)$")
    if not lo then lo = range; hi = range end
    local v = semver(version)
    return v >= semver(lo) and v <= semver(hi)
end


-- ── Architecture detection ────────────────────────────────────────────────────

-- ELF e_machine values read from libcocos2dcpp.so at offset +0x10 (DWORD).
local ARCH_MAP = {
    [11993091] = "arm64-v8a",
    [4063235]  = "x86_64",
    [2621443]  = "armeabi-v7a",
    [196611]   = "x86",
}

local lib_ranges = gg.getRangesList("libcocos2dcpp.so")
if #lib_ranges > 0 then
    local elf_machine = gg.getValues({ { address = lib_ranges[1].start + 0x10, flags = gg.TYPE_DWORD } })[1]
    DEVICE_ARCH = ARCH_MAP[elf_machine and tonumber(elf_machine.value)] or "unknown"
    BaseLib     = lib_ranges[1].start
    LOG.info("Arch", string.format("Lib ranges: %d | BaseLib: 0x%X | e_machine: %s → %s",
        #lib_ranges, BaseLib, tostring(elf_machine and elf_machine.value), DEVICE_ARCH))
else
    LOG.warn("Arch", "libcocos2dcpp.so not found in ranges list")
end

if DEVICE_ARCH == "unknown" then
    LOG.warn("Arch", "Architecture unrecognized — ELF e_machine not in ARCH_MAP")
    showDialog("Architecture Warning",
        "Your architecture is unknown. Is the lib loaded? What system are you using?",
        "Proceed Anyway")
end

if DEVICE_ARCH ~= "arm64-v8a" then
    LOG.warn("Arch", "Non-primary architecture: " .. DEVICE_ARCH .. " — lib patches may not work")
    showDialog("Architecture Warning",
        ("Detected: %s\nSome or all lib-patches may not work."):format(DEVICE_ARCH),
        "Proceed Anyway")
end


-- ── Manifest-driven data resolution ──────────────────────────────────────────

-- manifest.lua returns: { [version_range] = { [arch] = "data/path/to/file.lua" } }
local manifest    = loadModule("data/manifest.lua")
local pkg_version = gg.getTargetInfo().versionName
LOG.info("Arch", "Game version: " .. tostring(pkg_version) .. " | Arch: " .. tostring(DEVICE_ARCH))

if type(pkg_version) ~= "string" then
    LOG.fatal("Arch", "pkg_version is not a string: " .. type(pkg_version))
    showDialog("Warning", "Game version unknown. Try again after the game loads.", "OK")
    os.exit()
end

local function resolve_data(version, arch)
    for range, arch_map in pairs(manifest) do
        if in_range(range, version) then
            local path = arch_map[arch] or arch_map[DEFAULT_ARCH]
            if path then return loadModule(path) end
        end
    end
    return nil
end

local version_data = resolve_data(pkg_version, DEVICE_ARCH)

if not version_data then
    LOG.fatal("Arch", string.format("No data found for v%s on %s — unsupported version", pkg_version, DEVICE_ARCH))
    showDialog("Unsupported Version",
        ("No data found for v%s on %s."):format(pkg_version, DEVICE_ARCH), "OK")
    os.exit()
end

aobs    = version_data.aobs    or {}
offsets = version_data.offsets or {}
LOG.info("Arch", string.format("Data loaded OK | aobs=%d entries | offsets=%d entries",
    (function() local n=0; for _ in pairs(aobs) do n=n+1 end; return n end)(),
    (function() local n=0; for _ in pairs(offsets) do n=n+1 end; return n end)()))
