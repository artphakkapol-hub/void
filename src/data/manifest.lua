-- data/manifest.lua — Version × Architecture data manifest
--
-- Structure:
--   [version_range] = {
--       [arch] = "data/<arch>/<slot>.lua",
--       ...
--   }
--
-- Version range rules:
--   "1.73.0"           → exact match
--   "1.73.0-1.73.9"    → inclusive semver range (major*1e6 + minor*1e3 + patch)
--
-- Arch keys must match ARCH_MAP output in core/arch.lua:
--   "arm64-v8a", "armeabi-v7a", "x86_64", "x86"
--
-- A fallback to DEFAULT_ARCH is applied automatically by core/arch.lua when
-- the device arch has no dedicated file for a given version range.
--
-- To add a new game version:
--   1. Add a new range key below.
--   2. Create the corresponding data file(s) in data/<arch>/.
--   3. No changes to core/ required.

return {
    ["1.73.0-1.73.1"] = {
        ["arm64-v8a"] = "data/arm64-v8a/v1.73.x.lua",
    }
}
