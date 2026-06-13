-- data/arm64-v8a/1.73.3.lua — Override for 1.73.3 (arm64-v8a)
--
-- Inherits everything from base.lua EXCEPT the keys listed below.
-- See data/manifest.lua for how merging works.
--
-- Changed:
--   lib_setDistanceBase shifted (0x2009C28 → 0x200BC58) due to lib
--   recompilation in this version.

return {
    offsets = {
        lib_setDistanceBase = 0x200BC58,
    },
}
