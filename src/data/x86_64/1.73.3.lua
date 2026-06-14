-- data/x86_64/1.73.3.lua — Override for 1.73.3 (x86_64)
--
-- Inherits everything from base.lua EXCEPT the keys listed below.
-- See data/manifest.lua for how merging works.
--

return {
    offsets = {
        lib_setDistanceBase = 0x2066508,
    },
}
