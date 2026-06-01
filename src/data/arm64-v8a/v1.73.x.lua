-- data/arm64-v8a/v1.73.x.lua
-- Covers: 1.73.0, 1.73.1
-- Architecture: arm64-v8a
--
-- AoB entry format:
--   scan    = hex byte pattern (GG TYPE_BYTE search string)
--   offset  = byte delta from scan hit to target DWORD
--   patch   = value to write when enabling
--   unpatch = original value to restore when disabling
--
-- Offset entry format:
--   key = byte offset from BaseGameStatus (or named base pointer)

return {
    aobs = {
        fakeVip = {
            {scan = "h 93 D6 01 F9 68 B2 40 39 1F 01 00 71", offset = 4, patch = "h 28 00 80 52", unpatch = "h 68 B2 40 39"},
        },

        autoDetach = {
            {scan = "h 08 20 20 1E 85 00 00 54 E0 03 13 AA E1 03 14 AA", offset = 4, patch = "h 1F 20 03 D5", unpatch = "h 85 00 00 54"},
        },

        -- Add new AoBs here. Each key maps to a flat array of patch entries.
        -- Grouped features can use subtables: e.g. aobs.speedHack = { {…}, {…} }
    },

    offsets = {
        -- Offsets from BaseGameStatus unless prefixed (e.g. "lib_someField").
        -- coins       = 0x1A0,
        -- gems        = 0x1A8,
        -- playerLevel = 0x2B4,
    },
}
