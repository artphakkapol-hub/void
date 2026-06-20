-- core/engines/arch.lua — Architecture detection + manifest-driven data loading
-- Sets globals: DEVICE_ARCH, BaseLib, aobs, offsets
-- Depends on: loadModule, memory (already loaded), gg, showDialog, LOG,
--             DEFAULT_ARCH (set in main.lua)

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
    showDialog(T("arch.warning_title"),
        T("arch.unknown_arch_msg"),
        T("common.proceed_anyway"))
end

if DEVICE_ARCH ~= "arm64-v8a" then
    LOG.warn("Arch", "Non-primary architecture: " .. DEVICE_ARCH .. " — lib patches may not work")
    showDialog(T("arch.warning_title"),
        T("arch.non_primary_arch_msg", DEVICE_ARCH),
        T("common.proceed_anyway"))
end


-- ── Manifest-driven data resolution ──────────────────────────────────────────
--
-- See data/manifest.lua for the full structure/resolution writeup. Short
-- version: arch_t[major][minor].base (or arch_t.default_base) is the full
-- baseline; arch_t[major][minor][patch] is an optional diff-only override,
-- shallow-merged on top per `aobs` group key / `offsets` key.

local manifest    = loadModule("data/manifest.lua")
local pkg_version = gg.getTargetInfo().versionName
LOG.info("Arch", "Game version: " .. tostring(pkg_version) .. " | Arch: " .. tostring(DEVICE_ARCH))

if type(pkg_version) ~= "string" then
    LOG.fatal("Arch", "pkg_version is not a string: " .. type(pkg_version))
    showDialog(T("common.warning"), T("arch.unknown_version_msg"), T("common.ok"))
    os.exit(0)
end

local function shallow_merge(base_t, override_t)
    local merged = {}
    for k, v in pairs(base_t or {}) do merged[k] = v end
    for k, v in pairs(override_t or {}) do merged[k] = v end
    return merged
end

local function count(t)
    local n = 0
    for _ in pairs(t) do n = n + 1 end
    return n
end

-- Resolve which arch's tree to use. Unsupported arches fall back to
-- DEFAULT_ARCH's tree so the script still runs (with a warning) instead of
-- hard-exiting.
local arch_t = manifest[DEVICE_ARCH]
if not arch_t then
    LOG.warn("Arch", string.format(
        "No manifest entry for '%s' — falling back to '%s' (lib patches likely won't match)",
        DEVICE_ARCH, DEFAULT_ARCH))
    arch_t = manifest[DEFAULT_ARCH]
end

if not arch_t or not arch_t.default_base then
    LOG.fatal("Arch", "Manifest missing default_base for resolved arch — cannot continue")
    showDialog(T("common.warning"), T("arch.no_base_data_msg"), T("common.ok"))
    
end

local major, minor, patch = pkg_version:match("(%d+)%.(%d+)%.(%d+)")
local minor_t = ((arch_t[major] or {})[minor]) or {}

local base_path = minor_t.base or arch_t.default_base
local base = loadModule(base_path)
LOG.info("Arch", string.format("Base loaded: %s", base_path))

local override_path = minor_t[patch]
local override = nil
if override_path then
    override = loadModule(override_path)
    LOG.info("Arch", string.format("Override matched: v%s.%s.%s -> %s", major, minor, patch, override_path))
else
    LOG.info("Arch", string.format("No override for v%s.%s.%s — using base as-is", major, minor, patch))
end

aobs    = shallow_merge(base.aobs, override and override.aobs)
offsets = shallow_merge(base.offsets, override and override.offsets)

LOG.info("Arch", string.format("Data resolved | aobs=%d groups | offsets=%d entries",
    count(aobs), count(offsets)))
