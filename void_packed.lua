-- Packed by bundle.py  •  2026-06-01 18:24:54

-- Do not edit — regenerate with:  python bundle.py


local __vfs = {}

__vfs['configs/colors.lua'] = function(...)
UI = {
    BG = 0x200D001A,
    HEADER = 0x29110022,
    CARD = 0x331A0028,
    ACCENT = 0x608F3BE8,
    MUTED = 0x4D3D1060,
    TEXT = 0xFFFFFFFF,
    SUB = 0xDDBB99FF,
    RED = 0xFFFF3366,
    GREEN = 0xFF39FF14,
    STROKE = 0x4D4400AA,
    LOGO = 0xFFE040FB,
    GLOW = 0xFFFFFFFF,
    GLASS = 0x18FFFFFF,
    OVERLAY = 0xAA000000,
}

return UI
end

__vfs['configs/rewards.lua'] = function(...)
return [[
{
    "eventRewards": [
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_01",
                "unlockVehicleLevel": 20,
                "unlockVehicles": [
                    "snowboard",
                    "jeep",
                    "scooter",
                    "bus",
                    "superjeep",
                    "tractor",
                    "motractor",
                    "motocross",
                    "dunebuggy",
                    "sportscar",
                    "monster",
                    "upsidedown",
                    "pickup_truck",
                    "chopper",
                    "minitank",
                    "lowrider",
                    "snowmobile",
                    "monowheel",
                    "beast",
                    "rally",
                    "formula",
                    "musclecar",
                    "racing_truck",
                    "hotrod",
                    "electric_car",
                    "superbike",
                    "lambo",
                    "moonlander",
                    "rockbouncer",
                    "hoverbike",
                    "raider",
                    "glider",
                    "trusty",
                    "atv",
                    "super_offroad",
                    "doughnut",
                    "seld"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_02",
                "unlockHomeBackgrounds": [
                    "rustic_rafter",
                    "rustic_wall",
                    "rustic_floor",
                    "garageband_rafter",
                    "garageband_wall",
                    "garageband_floor",
                    "arcade_rafter",
                    "arcade_wall",
                    "arcade_floor",
                    "bomber_rafter",
                    "bomber_wall",
                    "bomber_floor"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_03",
                "unlockAdventureMaps": [
                    "nationalpark",
                    "forest",
                    "city",
                    "mountain_01",
                    "underwater",
                    "winter_01",
                    "mines",
                    "route66",
                    "beach",
                    "trailerpark",
                    "glacier",
                    "workshop",
                    "moonabase",
                    "savanna",
                    "darkforest",
                    "amusement_distance",
                    "arena_distance",
                    "cuptown_distance",
                    "moonbase",
                    "forest_trials",
                    "hard_city",
                    "hard_winter"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_04",
                "unlockEditorThemes": [
                    "forest",
                    "city",
                    "mountain",
                    "underwater",
                    "winter",
                    "mine",
                    "desert",
                    "beach",
                    "bayou",
                    "glacier",
                    "workshop",
                    "moon",
                    "savanna",
                    "darkforest",
                    "amusementpark",
                    "arena",
                    "cuptown",
                    "nationalpark"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_nikita",
                "unlockDriverAssets": [
                    "circus_bill_premium",
                    "marshal_premium",
                    "nikita_thief_premium",
                    "nikita_superhero_premium",
                    "nikita_acrobat_premium"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_05",
                "unlockDriverAssets": [
                    "10th_anniversary_bill_premium",
                    "abstract_character",
                    "alien",
                    "america",
                    "alice",
                    "bandaged_premium",
                    "bikergirl",
                    "billybob",
                    "bling",
                    "bobsledder",
                    "bomber-aqua_premium",
                    "bomber-black_premium",
                    "bomber-blue_premium",
                    "bomber-green_premium",
                    "bomber-pink_premium",
                    "bomber-red_premium",
                    "bomber-white_premium",
                    "bomber-yellow_premium",
                    "betatestdummy",
                    "biker",
                    "bunny",
                    "bunnygirl",
                    "busdriver",
                    "calaveragirl",
                    "calaveraman",
                    "candy",
                    "canyoneer",
                    "carrie",
                    "caveman",
                    "cat",
                    "china",
                    "chiron_premium",
                    "Christmas_2022_premium",
                    "chinahanfu_premium",
                    "clown",
                    "cny2021ox_premium",
                    "cny2022_premium",
                    "cny2024_premium",
                    "cny2025_premium",
                    "cny_rabbit",
                    "cowboy",
                    "crewchief",
                    "dave",
                    "dakota",
                    "deepforest_farmer_premium",
                    "default",
                    "diwali2022_premium",
                    "diwali-2024",
                    "dinnersuit",
                    "discoman_premium",
                    "docshocks_premium",
                    "drafted",
                    "driftmas2020_premium",
                    "driftmas2021_premium",
                    "driftmas2023_premium",
                    "driftmas2024_premium",
                    "driftmas2025_mythic",
                    "elf",
                    "explorer_premium",
                    "fabulo_logjaw_premium",
                    "fabulo_premium",
                    "fabulo_ranger_premium",
                    "farmer",
                    "fingersoft",
                    "firefighter",
                    "firehorsecny_premium",
                    "frank",
                    "freya_premium",
                    "fusell_premium",
                    "gaspresto_premium",
                    "ghost_premium",
                    "gilbert_premium",
                    "ginger",
                    "goth",
                    "geisha",
                    "gretel",
                    "grillbill",
                    "halloween",
                    "halloween2024_premium",
                    "handyman",
                    "hansel",
                    "hazardeer_premium",
                    "headless",
                    "hipster",
                    "honeybill_premium",
                    "hoodie",
                    "icegrille_premium",
                    "inuit",
                    "issen_premium",
                    "jock",
                    "johnny_epic",
                    "king",
                    "kmight",
                    "kleopatra",
                    "knight_premium",
                    "ladybee_premium",
                    "Leprechaun",
                    "lifeguardgirl",
                    "lifeguardguy",
                    "luxskully_premium",
                    "maiden",
                    "mackie",
                    "mellow",
                    "mindy_premium",
                    "miner",
                    "moonrabbit_premium",
                    "moc_premium",
                    "montana",
                    "mrvip",
                    "mrsvip",
                    "mummy_premium",
                    "nancy_premium",
                    "naked",
                    "nerdgirl",
                    "ninja",
                    "nightsuit",
                    "nitrox_premium",
                    "officer",
                    "oldbard",
                    "oldie",
                    "pecker_premium",
                    "pigsy",
                    "pitcrew",
                    "pixel",
                    "pinata2025_premium",
                    "pierre_epic",
                    "pirate",
                    "police",
                    "prisoner",
                    "punk",
                    "raccoonsuit",
                    "rap-artist",
                    "rat",
                    "reindeer",
                    "referee",
                    "retroride_bill_premium",
                    "rocker",
                    "robotsanta",
                    "rusty_premium",
                    "saki_premium",
                    "samurai",
                    "santa",
                    "scarecrow_premium",
                    "shaman",
                    "skeleton",
                    "slumberbot_premium",
                    "snowqueen",
                    "soldier",
                    "soccer",
                    "spacesuit",
                    "sports",
                    "sportsformula",
                    "spirit_premium",
                    "steam",
                    "steampunk",
                    "stuntman",
                    "streetbiker",
                    "sunburnt",
                    "superhero_premium",
                    "survivor",
                    "sweet_premium",
                    "towel",
                    "vampiress",
                    "villain",
                    "voltage_robot_premium",
                    "warlock_premium",
                    "winter",
                    "wintergirl",
                    "winterguy",
                    "winteroutfit",
                    "workrobot",
                    "yeti",
                    "zarek_premium",
                    "zephyr_premium",
                    "zombie",
                    "mountain",
                    "hoverbike",
                    "nationalday",
                    "overspill",
                    "racingtruck",
                    "drafted",
                    "snowqueen",
                    "sportsformula",
                    "santa",
                    "superbike",
                    "desert",
                    "raider",
                    "villain",
                    "headless",
                    "ninja",
                    "superhero_premium",
                    "bling",
                    "ghost_premium",
                    "glacier",
                    "driftmas2020_premium",
                    "super_offroad",
                    "gilbert_premium",
                    "yeti",
                    "rotator",
                    "towel",
                    "robotsanta",
                    "maiden",
                    "stuntman",
                    "calaveragirl",
                    "cuptown",
                    "raccoonsuit",
                    "shaman",
                    "frank",
                    "pixel",
                    "arena",
                    "knight_premium",
                    "skeleton",
                    "patchwork",
                    "rallycar",
                    "sunburnt",
                    "oldie",
                    "mellow",
                    "nationalpark",
                    "soldier",
                    "underwater",
                    "cc-ev",
                    "dunebuggy",
                    "lowrider",
                    "officer",
                    "icegrille_premium",
                    "motocross",
                    "hillclimbermk2",
                    "chinahanfu_premium",
                    "pitcrew",
                    "china",
                    "biker",
                    "chopper",
                    "halloween",
                    "formula",
                    "bus",
                    "docshocks_premium",
                    "tank",
                    "pirate",
                    "bobsledder",
                    "survivor",
                    "hillclimber",
                    "grinch",
                    "mrvip",
                    "musclecar",
                    "sports",
                    "slumberbot_premium",
                    "america",
                    "scooter",
                    "monstertruck",
                    "mine",
                    "oldbard",
                    "spacesuit",
                    "gloomvale",
                    "supercar",
                    "billybob",
                    "snowmobile",
                    "rockbouncer",
                    "alien",
                    "rat",
                    "city",
                    "calaveraman",
                    "superdiesel",
                    "police",
                    "beast",
                    "moonlander",
                    "hotrod",
                    "workrobot",
                    "moon",
                    "tractor",
                    "monowheel",
                    "mummy_premium",
                    "bwbog",
                    "betatestdummy",
                    "elf",
                    "mrsvip",
                    "glider",
                    "rocker",
                    "trusty",
                    "beach",
                    "sportscar",
                    "canyoneer",
                    "savanna",
                    "kmight",
                    "atv",
                    "forest",
                    "snow",
                    "circus_bill_premium",
                    "marshal_premium",
                    "nikita_thief_premium",
                    "nikita_superhero_premium",
                    "nikita_acrobat_premium"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_nikita_paints",
                "unlockVehiclePaints": [
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_nikita_superhero_premium"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_nikita_acrobat_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_marshal_premium"
                    }
                ],
                "unlockVehicleSpriteVariants": [
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-nikita_acrobat_premium",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-nikita_superhero_premium",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-marshal_premium",
                        "vehicleId": "musclecar"
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_06",
                "unlockVehiclePaints": [
                    {
                        "vehicleId": "jeep",
                        "paintId": "hill_climber_10th_anniversary_premium"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_flames"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_graphite"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_bronze"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_light-blue"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_violet"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_metal"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_checkered_green"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_classic"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_flames-blue"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_rally_brown"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_rally"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_splash"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_checkered"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "hill_climber_spring_falls_premium"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_banana"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_blue"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_broken_premium"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_halloween"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_heavy"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_hue_green"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_kangaroo_premium"
                    },
                    {
                        "vehicleId": "jeep",
                        "paintId": "jeep_pixel"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "scooter_hue_blue-white"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "scooter_hue_pink-white"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "black"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "rock"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "scooter_pierre_epic"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "diwali2022_premium"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "moped"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "scooter_hue_blue"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "scooter_hue_red"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "web"
                    },
                    {
                        "vehicleId": "scooter",
                        "paintId": "yellow"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "green"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "trio"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "cat"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "graffiti"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "london"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "bus_trophy_epic"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "bus_bandbus_premium"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "bus_chicken_premium"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "bus_nightcrawler_premium"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "bus_ramen_premium"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "flag"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "halloween"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "luck"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "sauna"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "school"
                    },
                    {
                        "vehicleId": "bus",
                        "paintId": "sleek"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_cubic"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_hue_pink"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_hue_yellow"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_yellowstripe"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_yellowstripe_hue"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_camo"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_camo_hue"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_safari_epic"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "hill_climber_mk2_saltmaker_premium"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_halloween"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_hue_blue"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_hue_green"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_ninja"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_pro"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_superhero"
                    },
                    {
                        "vehicleId": "superjeep",
                        "paintId": "superjeep_xmas"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "hue_1"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "hue_2"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "hue_3"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "hotrod"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "hotrod_hue1"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "orange"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "dragon"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "swamp"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "swamp_hue1"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "tractor_deepforest_premium"
                    },
                    {
                        "vehicleId": "tractor",
                        "paintId": "tractor_fire_premium"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_black-yellow"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_black-yellow_hue"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_hue_yellow-green"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_flames"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_flames_hue"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_lizard_epic"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_explorer_premium"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_green"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_green_hue"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_hue_blue"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_hue_red"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_hue_yellow"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_exploder"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_princess"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_vanilla"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_pop_epic"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_juice_premium"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_moonbuggy"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_pumpkin"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_racebuggy"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_skull_premium"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_sunbug"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_warlock_premium"
                    },
                    {
                        "vehicleId": "dunebuggy",
                        "paintId": "dunebuggy_waverider"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "arrow"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "twocoloured"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "twocoloured_hue"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_moonwalk_epic"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_steampunk_epic"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sports_hue_pink"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sports_hue_yellow"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_bee_premium"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_drifting_orange_premium"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_flames"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_flames_hue1"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_flames_hue2"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_gloomvale_premium"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_oldie_premium"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_orange"
                    },
                    {
                        "vehicleId": "sportscar",
                        "paintId": "sportscar_snowflake"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "fang_hue"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "fang"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "flames"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_hue_blue-flames"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_donut"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_steampunk_epic"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_america"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_hue_blue"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_hue_pink"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_police_premium"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_survivor"
                    },
                    {
                        "vehicleId": "monster",
                        "paintId": "monster_xmas"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "hue_default_autumn"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "hue_default_blue"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "berry"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "hue_berry_blue"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "upsidedown_driftmas2020_premium"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "upsidedown_enjin_premium"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "upsidedown_halloween2021_premium"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "upsidedown_scifi_premium"
                    },
                    {
                        "vehicleId": "upsidedown",
                        "paintId": "upsidedown_space_premium"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "oldie"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pickup_hue_pink"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "oldie_hue"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pickup_hue_scifi-green"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "scifi"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "adventure"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "giftwrap"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "nationalday"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pickup_heavenride_premium"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pickup_hue_green"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pickup_icegrille_premium"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "pimped"
                    },
                    {
                        "vehicleId": "pickup_truck",
                        "paintId": "sunkenship"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "hue_blue-b"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "pink"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "golden"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "hue_blue-green"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "hue_orange-purple"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "chopper_marina_premium"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "chopper_survivor_premium"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "freerider"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "ghostrider"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "horse"
                    },
                    {
                        "vehicleId": "chopper",
                        "paintId": "hue_blue"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "camo_winter"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "camo_forest"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "battledamage"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "m1"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "tank_hue_blue"
                    },
                    {
                        "vehicleId": "minitank",
                        "paintId": "tank_hue_green"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_blue_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_brown_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_chrome_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_purple_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_red_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_yellow_common"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_burgundy_rare"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_double_rare"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_emerald_rare"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_pinkstreak_rare"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_red_angles_epic"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_splash_epic"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_flame_premium"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_ghost_premium"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_luxury_premium"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_racer_premium"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_retroride_premium"
                    },
                    {
                        "vehicleId": "lowrider",
                        "paintId": "lowrider_survivor_premium"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "blue"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "green"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "purple"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "red"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "orange"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "poison"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "shark"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "water_splash"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "modern"
                    },
                    {
                        "vehicleId": "snowmobile",
                        "paintId": "snowmobile_disco_premium"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "bluestripes"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "bluestripes_hue_pink"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "default_hue_green"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "monowheel_china_premium"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "monowheel_nautilus_premium"
                    },
                    {
                        "vehicleId": "monowheel",
                        "paintId": "monowheel_voltage_premium"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_brown_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_green_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_pink_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_red_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_teal_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_white_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_yellow_common"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_rare_bluecheckers"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_rare_darkgreen"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_rare_tricolor"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_rare_whiteflame"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_rocket_epic"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_tiger_epic"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_chimera_premium"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_driftmas2023_premium"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_old_premium"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_sarcophagus_premium"
                    },
                    {
                        "vehicleId": "beast",
                        "paintId": "beast_spaceship_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_hcr"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_hcraser"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_star"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_vord"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_lash"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_luxury_epic"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "china"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_abstract_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_bomber_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_dragonboat_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_driftmas2021_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_frank"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_green"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_itasha_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_lava_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_lion"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_milk_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_nikita"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_samurai_premium"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_scifi"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_yellow"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "rally_zombie"
                    },
                    {
                        "vehicleId": "rally",
                        "paintId": "workshop"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "fingersoft"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "orangewhite"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "cny"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "formula_green"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "formula_hue_blue"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "formula_survivor_premium"
                    },
                    {
                        "vehicleId": "formula",
                        "paintId": "formula_villain_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_blue_common"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_green_common"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_pink_common"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_red_common"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_yellow_common"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_blueflame_rare"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_checker_rare"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_purpleflame_rare"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_yellowgreen_rare"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_bluegreen_epic"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_popart_epic"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_spectrum_epic"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_splash_epic"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_camo_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_derby_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_halloween_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_lucky_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_skully_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_tiger_premium"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "green"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "red"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "cowboy"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "halloween"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "jet_engine"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "racing_truck_amusement_park_premium"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "racing_truck_cny2021_premium"
                    },
                    {
                        "vehicleId": "racing_truck",
                        "paintId": "racing_truck_diwali-2024"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hue_green"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hue_pink"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hue_purple"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "flames"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "flames2"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "stickers"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_cny2022_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_docshocks_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_heavymetal_mythic"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_illusion_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_mecha_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_modern"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_mummy_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_nikita_premium"
                    },
                    {
                        "vehicleId": "hotrod",
                        "paintId": "hotrod_survivor"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_blue_common"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_green_common"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_purple_common"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_red_common"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_yellow_common"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_blueline_rare"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_chevron_rare"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_stripe_rare"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_flames_epic"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_lightning_epic"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_atom_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_bomberman_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_caustic_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_cookie_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_dragonboat_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_robot_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_scifi_premium"
                    },
                    {
                        "vehicleId": "electric_car",
                        "paintId": "electric_car_unicorn_premium"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "common_hue_1"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "common_hue_2"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "flames"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "flames_hue1"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "steampunk"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_blue_df_epic"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_green_df_epic"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_orange_df_epic"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "falcon"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "justice_bringer"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_enjin_premium"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_mitch"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_racing_black_premium"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_red_premium"
                    },
                    {
                        "vehicleId": "superbike",
                        "paintId": "superbike_villain_premium"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "hue_green"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "hue_pink"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "hue_purple"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "orange"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "red"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "blackwhite"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "bluestripes"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "king"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "orangewhite"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "ace"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "chameleon"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "cny2020"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "lambo_kobra_premium"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "supercar_knight_premium"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "supercar_nikita"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "tattoo"
                    },
                    {
                        "vehicleId": "lambo",
                        "paintId": "xmas"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "icecream"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_hue_black-blue"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_hue_blue"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_tractor"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "black-green"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "lights"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_simple"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "green"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_hue_red"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_lights"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_lunar_premium"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_moonrabbit_premium"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "moonlander_nautilus_premium"
                    },
                    {
                        "vehicleId": "moonlander",
                        "paintId": "saucer"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_blue_common"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_orange_common"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_red_common"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_violet_common"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_yellow_common"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_purple_rare"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_grunge_epic"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_grunge_red_epic"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_leopard_epic"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_yellowblue_epic"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbounder_leopard_purple_epic"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_blue17_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_christmas24_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_cny2024_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_green_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_purple12_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_rough_premium"
                    },
                    {
                        "vehicleId": "rockbouncer",
                        "paintId": "rockbouncer_strawberry_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_blue_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_brown_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_green_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_purple_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_red_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_teal_common"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_greenblue_rare"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_pinkblue_rare"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_purplegray_rare"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_digital_epic"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_grid_epic"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_stars_epic"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "fusell_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_drakkar_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_halloween2024_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_ironclad_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_moooo_premium"
                    },
                    {
                        "vehicleId": "hoverbike",
                        "paintId": "hoverbike_scifi_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_blue_common"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_green_common"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_pink_common"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_purple_common"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_yellow_common"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_geometric_pink_rare"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_geometric_red_rare"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_geometric_yellow_rare"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_orange_rare"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_red_rare"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_hexagon_epic"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_mech_green_epic"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_mech_white_epic"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_cheese_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_cny2025_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_fish_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_gold_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_hazardeer_premium"
                    },
                    {
                        "vehicleId": "raider",
                        "paintId": "raider_spirit_premium"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_blue_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_gray_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_green_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_purple_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_red_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_yellow_common"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_bent_blue_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_bent_burgundy_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_bent_mint_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_colorful_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_star_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_wooden_rare"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_rebel_epic"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_requisitioned_epic"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_christmas25_premium"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_cyber_premium"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_magic_premium"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_rustbucket_premium"
                    },
                    {
                        "vehicleId": "glider",
                        "paintId": "glider_wasp_premium"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_blue_common"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_green_common"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_red_common"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_blue_rare"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_green_rare"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_yellow_rare"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_pop_epic"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_purple_epic"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_phantom_premium"
                    },
                    {
                        "vehicleId": "trusty",
                        "paintId": "trusty_pinata2025_premium"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_red_common"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_sport-blue_common"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_yellow_common"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_mint_rare"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_royale_rare"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_sport-gerbera_rare"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_sport-keke_rare"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_camo_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_circuit_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_circus_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_moo_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_sport-flame_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_sport-flameblue_epic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_futuristic_premium"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_greek_premium"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_halloween25_mythic"
                    },
                    {
                        "vehicleId": "atv",
                        "paintId": "atv_shark_premium"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_blue_common"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_purple_common"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_red_common"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_white_common"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_camo_brown_rare"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_camo_green_rare"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_tendril_green_rare"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_tendril_purple_rare"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_beeple_epic"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_beeple_yellow_epic"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_cny26_premium"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_magenta_epic"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_beeple_pop_premium"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_tactical_blue_premium"
                    },
                    {
                        "vehicleId": "super_offroad",
                        "paintId": "super_offroad_tactical_green_premium"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_nikita_superhero_premium"
                    },
                    {
                        "vehicleId": "motocross",
                        "paintId": "motocross_nikita_acrobat_premium"
                    },
                    {
                        "vehicleId": "musclecar",
                        "paintId": "musclecar_marshal_premium"
                    }
                ],
                "unlockVehicleSpriteVariants": [
                    {
                        "partId": "wheel",
                        "variantId": "hill_climber_tire-10th_anniversary",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-motorcycle",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-old",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-safari",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-simple",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-steampunk",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-tractor",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hill_climber_spring_falls_tire_premium",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-hcr",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-broken_premium",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-goth",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-halloween",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-heavy",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-kangaroo_premium",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-pixel",
                        "vehicleId": "jeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-vip_small",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-motorcycle",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-old",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-simple",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-tractor",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-pierre",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-vip_small",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "scooter_tire-diwali2022_premium",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-goth",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-safari",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-steampunk",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire_moped",
                        "vehicleId": "scooter"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-hcr",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-motorcycle",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-old",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-safari",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-simple",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-steampunk",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-tractor",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-trophy_epic",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_default",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-bandbus_premium",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-chicken_premium",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-goth",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-nightcrawler_premium",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-ramen_premium",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "bus_tire-vip_small",
                        "vehicleId": "bus"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-hcr",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-motorcycle",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-old",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-simple",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-tractor",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-safari",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-steampunk",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-safari_epic",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hill_climber_mk2_tire-saltmaker_premium",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_default",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-goth",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-ninja",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-pro",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-vip_big",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire-xmas",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "superjeep_tire_superhero",
                        "vehicleId": "superjeep"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-hcr",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-motorcycle",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-old",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-simple",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-tractor",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-lizard_epic",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-vip_tilted",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-explorer_premium",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-goth",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-safari",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-steampunk",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-monster",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-old",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-pickup",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-safari",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-tractor",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-pop_epic",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_default",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-juice_premium",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-moonbuggy",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-ninja",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-pimped",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-pro",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-racebuggy",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-skull_premium",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-vip_big",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-warlock_premium",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-waverider",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "dunebuggy_tire-xmas",
                        "vehicleId": "dunebuggy"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-hcr",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-motorcycle",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-old",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-safari",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-simple",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-steampunk",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-tractor",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-moonwalk_epic",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-steampunk_epic",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_default",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-bee_premium",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-bundle",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-drifting_orange_premium",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-flames",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-gloomvale_premium",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-goth",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-halloween",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-oldie_premium",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-snowflake",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "sportscar_tire-vip_small",
                        "vehicleId": "sportscar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-donut",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-steampunk_epic",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_default",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-police_premium",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-survivor",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-usa",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-vip_big",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monster_tire-xmas",
                        "vehicleId": "monster"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-berry",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_default",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-driftmas2020_premium",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-enjin_premium",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-halloween2021_premium",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-space_premium",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire-vip",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "upsidedown_tire_scifi_premium",
                        "vehicleId": "upsidedown"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-hcr",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-motorcycle",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-old",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-safari",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-simple",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-steampunk",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-tractor",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-adventure",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-heaven_premium",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-icegrille-premium",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-nationalday",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-pimped",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-sunkenship",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "pickup_tire-vip_big",
                        "vehicleId": "pickup_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-motorcycle",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-old",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-simple",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "jeep_tire-tractor",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "chopper_tire-horse",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "chopper_tire-marina_premium",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "chopper_tire-survivor_premium",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "chopper_tire_back-ghostrider",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "chopper_tire_back-vip",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-goth",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-safari",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "tire-steampunk",
                        "vehicleId": "chopper"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-red_epic",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-splash_epic",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "car_tire-lowrider_luxury_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_default",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-flame_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-old-ghost_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-racer_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-retro_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-survivor_premium",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lowrider_tire-vip",
                        "vehicleId": "lowrider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-hcr",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-motorcycle",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-old",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-safari",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-simple",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-steampunk",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-tractor",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_default",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-china_premium",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-goth",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-halloween",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-heavy",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-nautilus_premium",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-vip_small",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "monowheel_tire-voltage_premium",
                        "vehicleId": "monowheel"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_chimera_premium",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_default",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_sarcophagus_premium",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_spaceship_premium",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_tire-driftmas2023_premium",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_tire-old_premium",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "beast_vip",
                        "vehicleId": "beast"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-hcr",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-motorcycle",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-old",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-safari",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-simple",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-tractor",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-luxury_epic",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_default",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_itasha_tire-premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-abstract_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-bomber_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-china",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-driftmas2021_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-frank",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-goth",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-green",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-halloween",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-heavy",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-milk_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-nikita",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-samurai_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire-vip_big",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire_lava_premium",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire_scifi",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rally_tire_workshop",
                        "vehicleId": "rally"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-goth",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-hcr",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-motorcycle",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-old",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-safari",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-simple",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-steampunk",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-tractor",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_default",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-bundle",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-cny",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-survivor_premium",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-villain_premium",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "formula_tire-vip_small",
                        "vehicleId": "formula"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-hcr",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-motorcycle",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-old",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-safari",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-simple",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-tractor",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_default",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-camo_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-derby_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-goth",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-halloween_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-lucky_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-skully_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-tiger_premium",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-vip",
                        "vehicleId": "musclecar"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-hcr",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-monster",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-old",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-tractor",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-amusement_park_premium",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-cny2021_premium",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-cowboy",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-diwali-2024_premium",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-shiny",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire-vip",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "racing_truck_tire_halloween",
                        "vehicleId": "racing_truck"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-goth",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-hcr",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-motorcycle",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-simple",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-steampunk",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-king",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_default",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-cny2022_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-docshocks_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-heavymetal_mythic",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-mecha_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-mummy_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-new_survivor",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-nikita_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire-survivor",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire_illusion_premium",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "hotrod_tire_vip",
                        "vehicleId": "hotrod"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_default",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-atom_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-bomberman_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-caustic_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-cookie_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-robot_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-scifi_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-unicorn_premium",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "electric_car_tire-vip",
                        "vehicleId": "electric_car"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-goth",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-hcr",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-motorcycle",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-simple",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-steampunk",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-king",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_default",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-cny2020",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-knight_premium",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-kobra_premium",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-nikita",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-vip_small",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "lambo_tire-xmas2018",
                        "vehicleId": "lambo"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "moonlander_default",
                        "vehicleId": "moonlander"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "moonlander_tire-lunar_premium",
                        "vehicleId": "moonlander"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "moonlander_tire-moonrabbit_premium",
                        "vehicleId": "moonlander"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "moonlander_tire-nautilus_premium",
                        "vehicleId": "moonlander"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "moonlander_tire-vip",
                        "vehicleId": "moonlander"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-common",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-rare",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-grunge-red_epic",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-grunge_epic",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_default",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-blue17_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-christmas24_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-cny2024_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-green_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-purple12_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-rough_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-strawberry_premium",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "rockbouncer_tire-vip_big",
                        "vehicleId": "rockbouncer"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-dark_common",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-decorative_common",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-star_common",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-geometric_pink_rare",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-geometric_red_rare",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-geometric_yellow_rare",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-orange_rare",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-hex_epic",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-mech_green_epic",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-mech_white_epic",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-cheese_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-cny2025_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-default",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-fish_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-gold_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-hazardeer_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-spirit_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "raider_tire-vip_premium",
                        "vehicleId": "raider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-common",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-bent_blue_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-bent_burgundy_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-bent_mint_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-colorful_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-star_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-wooden_rare",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-rebel_epic",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-requisitioned_epic",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_default",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-christmas25_premium",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-cyber_premium",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-magic-premium",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-rustbucket_premium",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-vip",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "glider_tire-wasp_premium",
                        "vehicleId": "glider"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_default",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_default2",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_tire-phantom_premium",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_tire-pinata2025_premium",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_tire-vip",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "trusty_wheel-inferno_premium",
                        "vehicleId": "trusty"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-road_common",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-camo_epic",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-circuit_epic",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_default",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-futuristic_premium",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-greek_premium",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-halloween25_mythic",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-shark_premium",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "atv_tire-vip",
                        "vehicleId": "atv"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-cny26_premium",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-roller",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-roller_rusty",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-gear",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-gear_grimy",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_default",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-tactical_blue_premium",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-tactical_green_premium",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "super_offroad_tire-vip",
                        "vehicleId": "super_offroad"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-nikita_acrobat_premium",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "motocross_tire-nikita_superhero_premium",
                        "vehicleId": "motocross"
                    },
                    {
                        "partId": "wheel",
                        "variantId": "musclecar_tire-marshal_premium",
                        "vehicleId": "musclecar"
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_07",
                "unlockDriverAnimations": [
                    "abduction",
                    "banjo",
                    "big-sad",
                    "blast",
                    "bill-bull",
                    "boppin",
                    "bubblegum",
                    "bubbles",
                    "climb-fiction",
                    "combo",
                    "cossack",
                    "dab",
                    "dang-it",
                    "darksurge",
                    "divine",
                    "dreamy",
                    "drum-solo",
                    "energy-drink",
                    "epic-win",
                    "fire-guitar",
                    "fist-pump",
                    "flip",
                    "gamer-rage",
                    "gift",
                    "ice-cream",
                    "idle",
                    "kippis",
                    "laser",
                    "laser-tool",
                    "marching",
                    "portal",
                    "potion_freezing",
                    "potion_growing",
                    "potion_shrinking",
                    "power-up",
                    "rave",
                    "rockerbill",
                    "scratch",
                    "sneeze",
                    "stretch",
                    "victory",
                    "wicked"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_08",
                "coinAmount": 100000000
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_09",
                "gemAmount": 14000
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_10",
                "currencies": [
                    {
                        "currency": "stars",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_11",
                "currencies": [
                    {
                        "currency": "scrap",
                        "amount": 10000000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_12",
                "currencies": [
                    {
                        "currency": "special_tickets",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_13",
                "currencies": [
                    {
                        "currency": "moon_tickets",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_14",
                "currencies": [
                    {
                        "currency": "distance_tickets",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_15",
                "currencies": [
                    {
                        "currency": "adventure_token",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_16",
                "currencies": [
                    {
                        "currency": "challenge_tickets",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_17",
                "currencies": [
                    {
                        "currency": "event_points",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_18",
                "currencies": [
                    {
                        "currency": "vehicle_blueprint",
                        "amount": 100000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_19",
                "currencies": [
                    {
                        "currency": "video_skips",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_20",
                "masteryBonusXp": 10000000
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_21",
                "currencies": [
                    {
                        "currency": "gacha_token",
                        "amount": 10000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_22",
                "currencies": [
                    {
                        "currency": "team_coins",
                        "amount": 20000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_23",
                "currencies": [
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    },
                    {
                        "currency": "research_points",
                        "amount": 5000
                    }
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_24",
                "chests": [
                    "common"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_25",
                "chests": [
                    "uncommon"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_26",
                "chests": [
                    "rare"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_27",
                "chests": [
                    "epic"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_28",
                "chests": [
                    "champion"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_29",
                "chests": [
                    "legendary_team"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_30",
                "chests": [
                    "free"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_31",
                "chests": [
                    "vip"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_32",
                "chests": [
                    "vip2"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_33",
                "chests": [
                    "video"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_34",
                "chests": [
                    "xpromo"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_35",
                "chests": [
                    "mega"
                ]
            },
            "maxCollectAmount": -1
        },
        {
            "rewardCondition": {
                "criteria": 0,
                "type": "score"
            },
            "lootDefinition": {
                "id": "event_reward_36",
                "chests": [
                    "team_support"
                ]
            },
            "maxCollectAmount": -1
        }
    ]
}

]]
end

__vfs['core/arch.lua'] = function(...)
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
    os.exit()
end

aobs    = data.aobs    or {}
offsets = data.offsets or {}

end

__vfs['core/env.lua'] = function(...)
-- core/env.lua — Java/Android environment gate
-- Loaded before any imports. Calls os.exit() on failure; no return value.

local function fail(msg)
    if gg.alert("Environment check failed!\n\n" .. msg .. "\n\nUse GG: ME by Vekendian.", "Get GG: ME", "OK") == 1 then
        gg.copyText("vekendian.org")
    end
    os.exit()
end

if type(luajava) ~= "table"  then fail("LuaJava not detected.") end
if type(import)  ~= "function" then fail("import() unavailable.") end
if not pcall(function() import("java.lang.String") end)  then fail("Core Java classes unavailable.") end
if not pcall(function() import("android.os.Build") end)  then fail("Android API unavailable.") end

do
    local V = import("android.os.Build$VERSION")
    if V.SDK_INT < 21 then
        fail(("Android 5.0+ (API 21) required. Detected API %d."):format(V.SDK_INT))
    end
end

local required = {
    "android.ext.Tools", "android.ext.rx", "android.ext.Script",
    "android.ext.Config", "android.ext.MainService",
    "org.vekendian.Crypto", "org.vekendian.Ui", "org.vekendian.Zip",
}
local missing = {}
for _, cls in ipairs(required) do
    if not pcall(function() luajava.bindClass(cls) end) then
        missing[#missing + 1] = cls
    end
end
if #missing > 0 then fail("Missing classes:\n" .. table.concat(missing, "\n")) end

end

__vfs['core/json.lua'] = function(...)
--[[
  JSON encoder/decoder module
  Provides methods to serialize Lua tables to JSON and deserialize JSON strings back to Lua tables.
]]

local json = {}

---Escapes special characters in a string for JSON encoding.
---@param s string The string to escape
---@return string Escaped string with special characters properly encoded
local function escape_str(s)
    s = s:gsub('\\', '\\\\')
    s = s:gsub('"', '\\"')
    s = s:gsub('\b', '\\b')
    s = s:gsub('\f', '\\f')
    s = s:gsub('\n', '\\n')
    s = s:gsub('\r', '\\r')
    s = s:gsub('\t', '\\t')
    return s
end

---Encodes a Lua value (nil, boolean, number, string, table) to JSON string.
---@param value any The value to encode (supports nil, boolean, number, string, table)
---@return string The JSON-encoded string representation
function json.encode(value)
    local t = type(value)
    if t == "nil" then
        return "null"
    elseif t == "boolean" then
        return tostring(value)
    elseif t == "number" then
        return tostring(value)
    elseif t == "string" then
        return '"' .. escape_str(value) .. '"'
    elseif t == "table" then
        local isArray = true
        local maxIndex = 0
        for k, v in pairs(value) do
            if type(k) ~= "number" then
                isArray = false
                break
            else
                if k > maxIndex then maxIndex = k end
            end
        end

        local items = {}
        if isArray then
            for i = 1, maxIndex do
                table.insert(items, json.encode(value[i]))
            end
            return "[" .. table.concat(items, ",") .. "]"
        else
            for k, v in pairs(value) do
                table.insert(items, '"' .. escape_str(k) .. '":' .. json.encode(v))
            end
            return "{" .. table.concat(items, ",") .. "}"
        end
    else
        print("Unsupported data type: " .. t)
    end
end

---Decodes a JSON string back into a Lua value.
---Arrays become Lua tables with numeric keys (1-indexed).
---Objects become Lua tables with string keys.
---@param input string The JSON string to decode
---@return any The decoded Lua value (nil, boolean, number, string, or table)
function json.decode(input)
    local pos = 1

    local parseValue, parseString, parseNumber, parseArray, parseObject, skipWhitespace

    ---Advances position past any whitespace characters
    function skipWhitespace()
        while pos <= #input and input:sub(pos,pos):match("%s") do
            pos = pos + 1
        end
    end

    ---Parses any JSON value (string, number, array, object, true, false, null)
    ---@return any The parsed value
    function parseValue()
        skipWhitespace()
        local c = input:sub(pos,pos)
        if c == '"' then return parseString()
        elseif c == '{' then return parseObject()
        elseif c == '[' then return parseArray()
        elseif c:match("[%d%-]") then return parseNumber()
        elseif input:sub(pos,pos+3) == "true" then pos = pos+4; return true
        elseif input:sub(pos,pos+4) == "false" then pos = pos+5; return false
        elseif input:sub(pos,pos+3) == "null" then pos = pos+4; return nil
        else print("Invalid JSON at position " .. pos) end
    end

    ---Parses a JSON string value
    ---@return string The parsed string (with escape sequences resolved)
    function parseString()
        pos = pos + 1
        local startPos = pos
        local result = ""
        while pos <= #input do
            local c = input:sub(pos,pos)
            if c == '"' then
                result = result .. input:sub(startPos, pos-1)
                pos = pos + 1
                return result
            elseif c == '\\' then
                result = result .. input:sub(startPos, pos-1)
                pos = pos + 1
                local esc = input:sub(pos,pos)
                if esc == '"' then result = result .. '"'
                elseif esc == '\\' then result = result .. '\\'
                elseif esc == '/' then result = result .. '/'
                elseif esc == 'b' then result = result .. '\b'
                elseif esc == 'f' then result = result .. '\f'
                elseif esc == 'n' then result = result .. '\n'
                elseif esc == 'r' then result = result .. '\r'
                elseif esc == 't' then result = result .. '\t'
                else print("Invalid escape sequence: \\"..esc) end
                pos = pos + 1
                startPos = pos
            else
                pos = pos + 1
            end
        end
        print("Unterminated string")
    end

    ---Parses a JSON number value (integer or float)
    ---@return number The parsed number
    function parseNumber()
        local startPos = pos
        while pos <= #input and input:sub(pos,pos):match("[0-9eE%+%-%.]") do
            pos = pos + 1
        end
        local numStr = input:sub(startPos, pos-1)
        local num = tonumber(numStr)
        if not num then print("Invalid number: " .. numStr) end
        return num
    end

    ---Parses a JSON array value
    ---@return table A Lua table with numeric keys (1-indexed)
    function parseArray()
        pos = pos + 1
        local arr = {}
        skipWhitespace()
        if input:sub(pos,pos) == "]" then pos = pos+1; return arr end
        while true do
            table.insert(arr, parseValue())
            skipWhitespace()
            local c = input:sub(pos,pos)
            if c == "]" then pos = pos + 1; break
            elseif c == "," then pos = pos + 1
            else print("Expected ',' or ']' in array at position " .. pos) end
        end
        return arr
    end

    ---Parses a JSON object value
    ---@return table A Lua table with string keys
    function parseObject()
        pos = pos + 1
        local obj = {}
        skipWhitespace()
        if input:sub(pos,pos) == "}" then pos = pos+1; return obj end
        while true do
            skipWhitespace()
            local key = parseString()
            skipWhitespace()
            if input:sub(pos,pos) ~= ":" then print("Expected ':' after key at position "..pos) end
            pos = pos + 1
            local value = parseValue()
            obj[key] = value
            skipWhitespace()
            local c = input:sub(pos,pos)
            if c == "}" then pos = pos + 1; break
            elseif c == "," then pos = pos + 1
            else print("Expected ',' or '}' in object at position " .. pos) end
        end
        return obj
    end

    return parseValue()
end

return json

end

__vfs['core/loader.lua'] = function(...)
-- core/loader.lua — Lazy module registry
-- Usage:
--   loader.register("my_feature", "modules/features/my_feature.lua")
--   local mod = loader.get("my_feature")   -- loads on first call only
--   loader.preload({ "a", "b" })           -- bulk-load a subset
--
-- Globals set by main.lua are available since this loads after them.

local registry = {}   -- id → file path
local cache    = {}   -- id → loaded module (nil = not yet loaded)

local loader = {}

-- Register a module path under an id. Does NOT load the file.
function loader.register(id, path)
    registry[id] = path
end

-- Register a table of { id = path } pairs.
function loader.registerAll(map)
    for id, path in pairs(map) do registry[id] = path end
end

-- Retrieve a module by id, loading it on first access.
function loader.get(id)
    if cache[id] ~= nil then return cache[id] end
    local path = registry[id]
    if not path then error("loader: unknown module '" .. id .. "'", 2) end
    local m = loadModule(path)
    cache[id] = m ~= nil and m or false  -- store false to distinguish nil return from "not loaded"
    return m
end

-- Eagerly load a list of ids (e.g. for warm-start on tab open).
function loader.preload(ids)
    for _, id in ipairs(ids) do
        if not cache[id] then pcall(loader.get, id) end
    end
end

-- Evict a cached module (forces reload on next get).
function loader.evict(id) cache[id] = nil end

-- True if the module has been loaded into cache.
function loader.loaded(id) return cache[id] ~= nil end

return loader

end

__vfs['core/memory.lua'] = function(...)
--[[
  Persistent memory handler module
  Manages saving and loading of game state data.

  Two storage scopes:
    Process-scoped  (save / load)       — tied to the current target PID.
                                          Data is wiped automatically when
                                          the process changes (game restart).
    Global-scoped   (saveGlobal / loadGlobal) — PID-independent; survives
                                          across restarts. Intended for user
                                          preferences such as UI colors that
                                          should never be cleared by a process
                                          switch.
]]

local File = import("java.io.File")

-- Shared serializer used by both save scopes.
-- Handles tables (recursively), strings, and scalar values.
local function serialize(v)
    if type(v) == "table" then
        local s = "{"
        for k, val in pairs(v) do
            local key = type(k) == "number" and "[" .. k .. "]" or string.format("[%q]", k)
            s = s .. key .. "=" .. serialize(val) .. ","
        end
        return s .. "}"
    elseif type(v) == "string" then
        return string.format("%q", v)
    else
        return tostring(v)
    end
end

local memory = {
    -- ── Process-scoped helpers ────────────────────────────────────────────────

    ---Checks whether the current GG session is still attached to the same PID.
    ---Clears all process-scoped data automatically when the process changes.
    ---@return boolean True if session is valid (same PID), false if it changed.
    _checkSession = function(self)
        local target = gg.getTargetInfo()
        if not target then return false end

        local currentPid = target.pid
        local pidFile = gg.FILES_DIR .. "/" .. target.packageName

        local oldPid
        local f = io.open(pidFile, "r")
        if f then
            oldPid = tonumber(f:read("*all"))
            f:close()
        end

        if oldPid ~= currentPid then
            self:clearAll()
            f = io.open(pidFile, "w")
            if f then
                f:write(tostring(currentPid))
                f:close()
            end
            return false
        end
        return true
    end,

    ---Saves data to process-scoped persistent storage.
    ---Keyed by package name + PID; automatically invalidated on process change.
    ---@param id string Unique identifier (e.g. "gamestatus", "toggle_states")
    ---@param data any Data to persist (tables are serialized recursively)
    ---@return boolean True if the write succeeded
    save = function(self, id, data)
        self:_checkSession()
        local target = gg.getTargetInfo()
        if not (target and data ~= nil) then return false end

        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local f = io.open(filePath, "w")
        if f then
            f:write("return " .. serialize(data))
            f:close()
            return true
        end
        return false
    end,

    ---Loads previously saved process-scoped data.
    ---Returns nil if the session changed or the data file does not exist.
    ---@param id string Unique identifier for the data to load
    ---@return any Loaded data, or nil
    load = function(self, id)
        if not self:_checkSession() then return nil end

        local target = gg.getTargetInfo()
        if not target then return nil end
        local filePath = gg.FILES_DIR .. "/" .. target.packageName .. "-memoryHandlers-" .. id
        local chunk = loadfile(filePath)
        return chunk and chunk() or nil
    end,

    ---Deletes all process-scoped data files for the current package.
    ---Called automatically when a PID change is detected.
    ---@return nil
    clearAll = function(self)
        local target = gg.getTargetInfo()
        if not target then return end
        local prefix = target.packageName .. "-memoryHandlers-"
        local directory = File(gg.FILES_DIR)
        local files = directory:listFiles()
        if files then
            for i = 1, #files do
                local file = files[i]
                if file:getName():find(prefix, 1, true) == 1 then
                    file:delete()
                end
            end
        end
    end,

    -- ── Global-scoped helpers ─────────────────────────────────────────────────

    ---Saves data to global persistent storage.
    ---Not tied to any process or package; survives game restarts and
    ---process switches. Intended for user preferences (UI colors, etc.).
    ---@param id string Unique identifier (e.g. "ui_prefs")
    ---@param data any Data to persist (tables are serialized recursively)
    ---@return boolean True if the write succeeded
    saveGlobal = function(self, id, data)
        if data == nil then return false end
        local filePath = gg.FILES_DIR .. "/void-global-" .. id
        local f = io.open(filePath, "w")
        if f then
            f:write("return " .. serialize(data))
            f:close()
            return true
        end
        return false
    end,

    ---Loads previously saved global data.
    ---Returns nil if the file does not exist or cannot be parsed.
    ---@param id string Unique identifier for the data to load
    ---@return any Loaded data, or nil
    loadGlobal = function(self, id)
        local filePath = gg.FILES_DIR .. "/void-global-" .. id
        local chunk = loadfile(filePath)
        return chunk and chunk() or nil
    end,
}

return memory

end

__vfs['core/patches.lua'] = function(...)
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
    local preload = memory:load(id)

    if preload then
        local values = {}
        for i, entry in ipairs(entries) do
            if preload[i] then
                table.insert(values, {
                    address = preload[i],
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

end

__vfs['core/scheduler.lua'] = function(...)
--[[
  Task scheduler module
  Manages asynchronous task execution in FIFO queue order.
  Ensures tasks complete before the next one starts, with error recovery.
]]

local scheduler = {}

---@type table Queue of pending tasks
local queue = {}
---@type boolean True if a task is currently being processed
local is_processing = false

---Adds a task function to the queue.
---The task receives a finish_task callback that it must call to complete execution.
---@param task_func fun(finish_task: fun()) The task function to queue
---@return nil
function scheduler:add(task_func)
    table.insert(queue, task_func)
    if not is_processing then
        self:next()
    end
end

---Processes the next task in the queue.
---Automatically called recursively until queue is empty.
---Handles task errors gracefully by logging and continuing.
---@return nil
function scheduler:next()
    if #queue == 0 then
        is_processing = false
        return
    end

    is_processing = true
    local current_task = table.remove(queue, 1)
    
    local success, err = pcall(function()
        current_task(function()
            scheduler:next()
        end)
    end)

    if not success then
        gg.alert("Scheduler Warning: Task crashed -> " .. tostring(err))
        self:next()
    end
end

---Gets the number of pending tasks in the queue.
---@return number Number of tasks waiting to be processed
function scheduler:getQueueCount()
    return #queue
end

---Checks if a task is currently being processed.
---@return boolean True if processing, false otherwise
function scheduler:isProcessing()
    return is_processing
end

return scheduler

end

__vfs['data/manifest.lua'] = function(...)
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

end

__vfs['data/arm64-v8a/v1.73.x.lua'] = function(...)
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

end

__vfs['modules/registry.lua'] = function(...)
-- modules/registry.lua — Lazy tab module registry
-- Returns: tabHandlers (ordered list), categoryHandlers (id → render fn)
--
-- Tab modules are NOT loaded here. Each is loaded exactly once, the first
-- time its tab is opened by the user. This keeps startup allocation flat
-- regardless of how many tabs/features exist.
--
-- To add a tab:
--   1. Append an entry to TAB_DEFS.
--   2. Create the corresponding file in modules/tabs/.
--   No other files need changing.

local TAB_DEFS = {
    -- { id, display_name }
    { "account",   "ACCOUNT MENU"   },
    { "player",    "PLAYER MENU"    },
    { "adventure", "ADVENTURE MENU" },
    { "cups",      "CUPS MENU"      },
    { "team",      "TEAM MENU"      },
    { "event",     "EVENT MENU"     },
    { "creative",  "CREATIVE MENU"  },
    { "shop",      "SHOP MENU"      },
    { "other",     "OTHER MENU"     },
    { "settings",  "SETTINGS MENU"  },
}

local loaded      = {}   -- id → render function (cached after first load)
local tabHandlers = {}

for _, def in ipairs(TAB_DEFS) do
    tabHandlers[#tabHandlers + 1] = def
end

-- categoryHandlers[id](container) — called by ui.lua when a tab is first rendered.
-- Loads the tab file lazily and delegates to the returned render function.
local categoryHandlers = {}

for _, def in ipairs(TAB_DEFS) do
    local id   = def[1]
    local path = "modules/tabs/" .. id .. ".lua"

    categoryHandlers[id] = function(container)
        if not loaded[id] then
            local ok, result = pcall(function() return loadModule(path) end)
            if ok and type(result) == "function" then
                loaded[id] = result
            else
                -- Surface load errors as a read-only card so the rest of the UI stays alive.
                addModule(container, id .. "_err", id,
                    "Load error: " .. tostring(result), "ro", "Error", nil)
                return
            end
        end
        loaded[id](container)
    end
end

return tabHandlers, categoryHandlers

end

__vfs['modules/tabs/account.lua'] = function(...)
--[[
  Account Tab - Player profile modifications
  Features: Change player name, Fake VIP status
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "change_name", "Change Name", "Change your player name", "input", {
        {hint = "Enter Name", value = "", type = "text"}
    }, function(done, val)
        scheduler:add(function(finish_task)
            if val ~= nil and val ~= "" then
                local name = val
                local tempString = {}
                local byteSize = 0

                for _, code in utf8.codes(name) do
                    local encoded = utf8.char(code)
                    local bytes = {encoded:byte(1, -1)}
                    if byteSize + #bytes > 12 then
                        showDialog("Name Too Long", "Your name is too long, please shorten it", "OK")
                        
                        finish_task()
                        done()
                        return
                    end
                    for _, b in ipairs(bytes) do
                        table.insert(tempString, b)
                        byteSize = byteSize + 1
                    end
                end

                while #tempString < 12 do
                    table.insert(tempString, 0)
                end

                local getPlayerNamePtr = gg.getValues({{
                    address = BaseGameStatus + 0x38,
                    flags = 32
                }})[1].value

                local toEdit = {{
                    address = getPlayerNamePtr,
                    flags = 1,
                    value = byteSize * 2
                }}

                for i = 1, #tempString do
                    toEdit[#toEdit + 1] = {
                        address = getPlayerNamePtr + i,
                        flags = 1,
                        value = tempString[i]
                    }
                end

                gg.setValues(toEdit)
                showToast("Name changed to " .. name)
            end
            
            finish_task()
            done()
        end)
    end)

    addArchModule(container, "fake_vip", "Fake VIP", "Toggle vip subscription state locally", "switch", nil, aobs.fakeVip)
    
    addModule(container, "fake_rank", "Fake Rank", "Set your rank to fake legendary automatically", "button", nil, function(done)
        scheduler:add(function(finish_task)
            gg.setValues({{
                address = BaseGameStatus + 0x1CC,
                flags = 16,
                value = 50.0
            }, {
                address = BaseGameStatus + 0x200,
                flags = 16,
                value = 50.0
            }})
            
            showToast("Fake Rank has been injected, please don't do this twice for safety.")
            finish_task()
            done()
        end)
    end)
end

end

__vfs['modules/tabs/adventure.lua'] = function(...)
--[[
  Adventure Tab - Adventure mode features
  Status: TODO - Not yet implemented
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    -- TODO: add adventure modules
end

end

__vfs['modules/tabs/creative.lua'] = function(...)
--[[
  Creative Tab - Creative mode/Custom track features
  Status: TODO - Not yet implemented
  
  @module callback Receives container View to populate with modules
]]
return function(container)
    -- TODO: add creative modules
end

end

__vfs['modules/tabs/cups.lua'] = function(...)
--[[
  Cups Tab - Cup racing modes
  Features: Auto-win races
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    local autoWinPatches = {
        {scan = "h E8 5F 5B A9 15 61 40 B9", offset = 4, patch = "h 55 00 80 52", unpatch = "h 15 61 40 B9"},
        {scan = "h E8 2B 40 F9 0A 4D 40 BD", offset = 4, patch = "h 0A 90 32 1E", unpatch = "h 0A 4D 40 BD"},
        {scan = "h 00 00 48 42 00 00 40 40 00 00 C8 42", offset = 4, patch = "h 00 00 00 00", unpatch = "h 00 00 40 40"},
    }

    --addArchModule(container, "auto_win", "Auto Win", "Automatically win no matter what your race results is", "switch", nil, autoWinPatches)
end

end

__vfs['modules/tabs/event.lua'] = function(...)
--[[
  Event Tab - Evemt mode features
  Features: Event Rewards Patch
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "patch_rewards", "Event Rewards Patch", "Patch the current public event rewards to custom one provided by VOID (require game restart)", "button", nil, function(done)
        -- Determine if environment is natively Rooted or using a Virtual Space
        gg.toast("Checking environment permissions...")
        local suCheck = gg.shell("su -c id")
        local hasRoot = suCheck and suCheck:find("uid=0") ~= nil
        
        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")
    
        local eventsPaths = {
            "/data/data/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/"
        }
    
        local successList = {}
        local failedList = {}
        
        local custom_rewards = loadModule("configs/rewards.lua")
        local jsonMod = nil
        local ok, err = pcall(function()
            jsonMod = json.decode(custom_rewards)
        end)
        if not ok or not jsonMod then
            table.insert(failedList, "Failed to decode rewards JSON")
            jsonMod = nil
        end
    
        -- Workspace allocated for root escalation adjustments
        local safeWorkspace = "/storage/emulated/0/.void_cache/"
        if hasRoot then
            gg.shell("mkdir -p " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            -- Check if file is directly readable (Virtual Space environment scenario)
            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                -- File blocked but root exists: Pull to public space
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                gg.shell("su -c 'cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"'")
                gg.shell("su -c 'chmod 777 \"" .. secureActiveCopy .. "\"'")
                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                -- Inaccessible and no root (Virtual Space misconfiguration or path missing)
                table.insert(failedList, "File inaccessible at path: " .. path)
                goto continue_path
            end
    
            local meta = Crypto.decrypt(targetActivePath, active_decrypted)
            if activeMovedViaRoot then os.remove(targetActivePath) end

            if meta then
                local activeFile = io.open(active_decrypted, "r")
                if activeFile then
                    local activeContent = activeFile:read("*a")
                    activeFile:close()
                    os.remove(active_decrypted)
    
                    local jsonActive = nil
                    local ok2, err2 = pcall(function()
                        jsonActive = json.decode(activeContent)
                    end)
                    if not ok2 or not jsonActive then
                        table.insert(failedList, "Failed to decode active_events.json at path: " .. path)
                        goto continue_path
                    end
    
                    local gameEvents = jsonActive.gameEvents or {}
                    if #gameEvents == 0 then
                        table.insert(failedList, "No active events found at path: " .. path)
                        goto continue_path
                    end
    
                    local labels = {}
                    for i = 1, #gameEvents do labels[i] = tostring(gameEvents[i]) end
    
                    local selections = gg.multiChoice(labels, nil, "Select events to patch:\nPath: " .. path)
                    if not selections then
                        table.insert(failedList, "User cancelled selection for path: " .. path)
                        goto continue_path
                    end
    
                    if not jsonMod then
                        table.insert(failedList, "Embedded rewards not available, skipping patches for path: " .. path)
                        goto continue_path
                    end
                    local eventRewards = jsonMod.eventRewards
    
                    local selectionsExist = false
                    for _, selected in pairs(selections) do
                        if selected then selectionsExist = true; break end
                    end

                    if selectionsExist then
                        local fileTaskDone = false
                        
                        scheduler:add(function(finish_task)
                            local loopOk, loopErr = pcall(function()
                                for idx, selected in pairs(selections) do
                                    if selected then
                                        local eventName = gameEvents[idx]
                                        if eventName then
                                            local eventPath = path .. eventName .. ".json"
                                            local targetEventPath = eventPath
                                            local secureEventCopy = safeWorkspace .. eventName .. ".json"
                                            local decryptedPath = hasRoot and (safeWorkspace .. "." .. eventName) or (path .. "." .. eventName)
                                            local eventMovedViaRoot = false
            
                                            local testEventOpen = io.open(eventPath, "r")
                                            if testEventOpen then
                                                testEventOpen:close()
                                            elseif hasRoot then
                                                gg.shell("su -c 'cp \"" .. eventPath .. "\" \"" .. secureEventCopy .. "\"'")
                                                gg.shell("su -c 'chmod 777 \"" .. secureEventCopy .. "\"'")
                                                targetEventPath = secureEventCopy
                                                eventMovedViaRoot = true
                                            else
                                                table.insert(failedList, "Skipped unreadable event: " .. eventName)
                                                goto next_event
                                            end

                                            local eventMeta = Crypto.decrypt(targetEventPath, decryptedPath)
                                            if eventMovedViaRoot then os.remove(targetEventPath) end
            
                                            if eventMeta then
                                                local eventFile = io.open(decryptedPath, "r+")
                                                if eventFile then
                                                    local writeOk, writeErr = pcall(function()
                                                        local eventContent = eventFile:read("*a")
                                                        local jsonEvent = json.decode(eventContent)
                                                        
                                                        jsonEvent.eventRewards = eventRewards
                                                        jsonEvent.minRankToJoin = 0
                                                        jsonEvent.rankBrackets = 2
                                                        
                                                        local encodedEvent = json.encode(jsonEvent)
                                                        eventFile:seek("set", 0)
                                                        eventFile:write(encodedEvent)
                                                        eventFile:flush()
                                                        eventFile:close()
                                                        
                                                        if eventMovedViaRoot and hasRoot then
                                                            -- Encrypt back into public storage, then push back to native protected dir via root bridge
                                                            local secureEncryptedOut = safeWorkspace .. eventName .. "_patched.json"
                                                            Crypto.encrypt(decryptedPath, secureEncryptedOut, eventMeta)
                                                            
                                                            gg.shell("su -c 'cp \"" .. secureEncryptedOut .. "\" \"" .. eventPath .. "\"'")
                                                            gg.shell("su -c 'chmod 660 \"" .. eventPath .. "\"'")
                                                            os.remove(secureEncryptedOut)
                                                        else
                                                            -- Virtual space configuration: directly encrypt back to root app folder destination
                                                            Crypto.encrypt(decryptedPath, eventPath, eventMeta)
                                                        end
                                                        
                                                        table.insert(successList, eventName)
                                                    end)
            
                                                    if not writeOk then
                                                        pcall(function() eventFile:close() end)
                                                        table.insert(failedList, "Failed processing " .. eventName .. ": " .. tostring(writeErr))
                                                    end
                                                    os.remove(decryptedPath)
                                                else
                                                    table.insert(failedList, "Cannot open decrypted file: " .. decryptedPath)
                                                end
                                            else
                                                table.insert(failedList, "Failed to decrypt event: " .. eventName)
                                            end
                                        end
                                    end
                                    ::next_event::
                                end
                            end)
                    
                            if not loopOk then
                                table.insert(failedList, "Critical file processing loop crash: " .. tostring(loopErr))
                            end
                            
                            finish_task()
                            fileTaskDone = true
                        end)

                        while not fileTaskDone do gg.sleep(50) end
                    end
                else
                    table.insert(failedList, "Cannot open active_events.json at path: " .. path)
                end
            else
                table.insert(failedList, "Failed to decrypt active_events.json at path: " .. path)
            end
            ::continue_path::
        end
    
        -- Final Clean up workspace if created
        if hasRoot then
            gg.shell("rm -rf " .. safeWorkspace)
        end

        local resultMsg = ""
        if #successList > 0 then
            resultMsg = resultMsg .. "Successfully:\n"
            for _, name in ipairs(successList) do
                resultMsg = resultMsg .. "- " .. name .. "\n"
            end
            resultMsg = resultMsg .. "\n"
        end
        if #failedList > 0 then
            resultMsg = resultMsg .. "Failed:\n"
            for _, e in ipairs(failedList) do
                resultMsg = resultMsg .. "- " .. e .. "\n"
            end
        end
    
        showDialog("Patch Results", resultMsg, {"OK"})
        done()
        
        if #successList > 0 then
            print(resultMsg)
            showDialog("Restart Required", "Game is killed and this script gonna exit, start it again and see the patch effects", {"OK"})
            
            if scheduler:getQueueCount() > 0 or scheduler:isProcessing() then
                gg.toast("Finishing pending background tasks... Please wait.")
                while scheduler:getQueueCount() > 0 or scheduler:isProcessing() do
                    gg.sleep(100)
                end
            end

            gg.processKill()
            gg.sleep(1000)
            exitScript()
        else
            showDialog("Failed", "Failed to patch, try again.", {"OK"})
        end
    end)

    addModule(container, "restore_events", "Event Rewards Restore", "Delete modified event JSONs to force game server recovery (requires game restart)", "button", nil, function(done)
        -- Determine if environment is natively Rooted or using a Virtual Space
        gg.toast("Checking environment permissions...")
        local suCheck = gg.shell("su -c id")
        local hasRoot = suCheck and suCheck:find("uid=0") ~= nil
        
        if hasRoot then
            memory:save("shell_states", {root=true})
        else
            memory:save("shell_states", {root=false})
        end

        gg.toast("Scanning active files...")
    
        local eventsPaths = {
            "/data/data/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/",
            "/data/user/0/com.waxmoon.ma.gp/rootfs/data/user/0/com.fingersoft.hcr2/files/content_cache/json/events/"
        }
    
        local successList = {}
        local failedList = {}
    
        -- Workspace allocated for root escalation adjustments
        local safeWorkspace = "/storage/emulated/0/.void_cache/"
        if hasRoot then
            gg.shell("mkdir -p " .. safeWorkspace)
        end

        for _, path in ipairs(eventsPaths) do
            local active = path .. "active_events.json"
            local active_decrypted = hasRoot and (safeWorkspace .. ".active_events") or (path .. ".active_events")
            local targetActivePath = active
            local activeMovedViaRoot = false

            -- Check if file is directly readable (Virtual Space environment scenario)
            local testOpen = io.open(active, "r")
            if testOpen then
                testOpen:close()
            elseif hasRoot then
                -- File blocked but root exists: Pull to public space to parse gameEvents list
                local secureActiveCopy = safeWorkspace .. "active_events.json"
                gg.shell("su -c 'cp \"" .. active .. "\" \"" .. secureActiveCopy .. "\"'")
                gg.shell("su -c 'chmod 777 \"" .. secureActiveCopy .. "\"'")
                targetActivePath = secureActiveCopy
                activeMovedViaRoot = true
            else
                -- Inaccessible and no root (Virtual Space misconfiguration or path missing)
                table.insert(failedList, "File inaccessible at path: " .. path)
                goto continue_path
            end
    
            local meta = Crypto.decrypt(targetActivePath, active_decrypted)
            if activeMovedViaRoot then os.remove(targetActivePath) end

            if meta then
                local activeFile = io.open(active_decrypted, "r")
                if activeFile then
                    local activeContent = activeFile:read("*a")
                    activeFile:close()
                    os.remove(active_decrypted)
    
                    local jsonActive = nil
                    local ok, err = pcall(function()
                        jsonActive = json.decode(activeContent)
                    end)
    
                    if ok and jsonActive then
                        local gameEvents = jsonActive.gameEvents or {}
                        if #gameEvents > 0 then
                            local labels = {}
                            for i = 1, #gameEvents do labels[i] = tostring(gameEvents[i]) end
                            
                            local selections = gg.multiChoice(labels, nil, "Select files to restore (delete):\nPath: " .. path)
                            
                            if selections then
                                local fileTaskDone = false
                                
                                scheduler:add(function(finish_task)
                                    pcall(function()
                                        for idx, selected in pairs(selections) do
                                            if selected then
                                                local eventName = gameEvents[idx]
                                                if eventName then
                                                    local eventPath = path .. eventName .. ".json"
                                                    
                                                    -- Try standard removal first (Virtual Space handling)
                                                    local removed, remErr = os.remove(eventPath)
                                                    
                                                    -- If standard removal fails and we have root escalation privileges
                                                    if not removed and hasRoot then
                                                        local rootRmOut = gg.shell("su -c 'rm \"" .. eventPath .. "\"'")
                                                        -- Verify file deletion over root channel
                                                        local checkFile = gg.shell("su -c '[ -f \"" .. eventPath .. "\" ] && echo yes || echo no'")
                                                        if checkFile and checkFile:find("no") then
                                                            removed = true
                                                        else
                                                            remErr = "Root removal failed or rejected"
                                                        end
                                                    end

                                                    if removed then
                                                        table.insert(successList, eventName)
                                                    else
                                                        table.insert(failedList, "Failed to delete " .. eventName .. ": " .. tostring(remErr))
                                                    end
                                                end
                                            end
                                        end
                                    end)
                                    finish_task()
                                    fileTaskDone = true
                                end)
    
                                while not fileTaskDone do gg.sleep(50) end
                            end
                        else
                            table.insert(failedList, "No active events found at path: " .. path)
                        end
                    else
                        table.insert(failedList, "Failed to decode active_events.json at path: " .. path)
                    end
                else
                    table.insert(failedList, "Cannot open active_events.json at path: " .. path)
                end
            else
                table.insert(failedList, "Failed to decrypt active_events.json at path: " .. path)
            end
            ::continue_path::
        end
        
        -- Final Clean up workspace if created
        if hasRoot then
            gg.shell("rm -rf " .. safeWorkspace)
        end

        local resultMsg = ""
        if #successList > 0 then
            resultMsg = resultMsg .. "Successfully Removed (Will Restore on Restart):\n"
            for _, name in ipairs(successList) do
                resultMsg = resultMsg .. "- " .. name .. ".json\n"
            end
            resultMsg = resultMsg .. "\n"
        end
        if #failedList > 0 then
            resultMsg = resultMsg .. "Failed:\n"
            for _, e in ipairs(failedList) do
                resultMsg = resultMsg .. "- " .. e .. "\n"
            end
        end
    
        showDialog("Restore Results", resultMsg, {"OK"})
        done()
    
        if #successList > 0 then
            print(resultMsg)
            showDialog("Restart Required", "Game will now close to allow server file synchronization.", {"OK"})
            
            if scheduler:getQueueCount() > 0 or scheduler:isProcessing() then
                gg.toast("Finishing pending background tasks...")
                while scheduler:getQueueCount() > 0 or scheduler:isProcessing() do
                    gg.sleep(100)
                end
            end
    
            gg.processKill()
            gg.sleep(1000)
            exitScript()
        end
    end)
end

end

__vfs['modules/tabs/other.lua'] = function(...)
--[[
  Other Tab - Other mode features
  Status: Resolution adjust, Resolution offset adjust
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "resolution", "Resolution Adjust", "Adjust the game width and height (default is 1280x720)", "input", {
        {hint = "Width", type = "number"},
        {hint = "Height", type = "number"}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local width = tonumber(vals[1]) or 1280
            local height = tonumber(vals[2]) or 720

            local results = memory:load("resolution")

            if not results then
                gg.clearResults()
                gg.setRanges(BaseRegion)

                gg.searchNumber(":Cocos2dxGLSurfaceView", 1)
                gg.refineNumber(":C", 1)
                local cocos = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #cocos == 0 then
                    gg.toast("GLSurfaceView not found")
                    finish_task()
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
                    finish_task()
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
                    gg.toast(string.format("Resolution set to %dx%d", width, height))
                end
            end

            finish_task()
            done()
        end)
    end)

    addModule(container, "resolution_offset", "Resolution Offset Adjust", "Adjust the game width offset and height offset (default is 0x0), best for small resolution in a large screen.", "input", {
        {hint = "Width", type = "number"},
        {hint = "Height", type = "number"}
    }, function(done, vals)
        scheduler:add(function(finish_task)
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
                    gg.toast("GLSurfaceView not found")
                    finish_task()
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
                    finish_task()
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
                    gg.toast(string.format("Resolution offset set to %dx%d", width, height))
                end
            end

            finish_task()
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

end

__vfs['modules/tabs/player.lua'] = function(...)
--[[
  Player Tab - Vehicle and character modifications
  Features: Auto-detach parts, No-clip mode, Hide name/flag, Zoom adjust, Gravity adjust
  
  @module callback Receives container View to populate with modules
]]

-- Dependencies: addModule, addArchModule, showToast, memory, BaseGameStatus, BaseRegion, scheduler

return function(container)
    
    addArchModule(container, "auto_detach", "Auto Detach", "Automatically detach parts like the Rally Car roof", "switch", nil, aobs.autoDetach)

    addModule(container, "no_clip", "No-Clip", "Make your player go through objects without dying", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("no_clip")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(8)
                gg.searchNumber("h 0A D7 23 3C 00 00 00 00 00 00 20 C1", 1)
                gg.refineNumber("h 0A D7 23 3C", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("no_clip", results)
            end
            if state then
                gg.editAll("h CD CC 08 C1", 1)
                showToast("No-Clip Enabled", true)
            else
                gg.editAll("h 0A D7 23 3C", 1)
                showToast("No-Clip Disabled", true)
            end
            gg.clearResults()
            
            finish_task() -- Release scheduler block for next mod
            done()        -- Notify UI toggle update
        end)
    end)

    addModule(container, "hide_name", "Hide Name", "Hide your player name at race", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("hide_name")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h BF 7D AD C1 64 CC 73 41 71 3D 0A 3F 71 3D 0A 3F", 1)
                gg.refineNumber("h 71 3D 0A 3F 71 3D 0A 3F", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_name", results)
            end
            if state then
                gg.editAll("h 00 00 00 00 00 00 00 00", 1)
                showToast("Hide Name Enabled", true)
            else
                gg.editAll("h 71 3D 0A 3F 71 3D 0A 3F", 1)
                showToast("Hide Name Disabled", true)
            end
            gg.clearResults()
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "hide_flag", "Hide Flag", "Hide your player flag at race", "switch", nil,
    function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("hide_flag")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h 2E FF D7 C1 36 CD 73 41 00 00 80 3F 00 00 80 3F 00 00 00 3F 00 00 00 3F FF FF FF FF 00 00 08 42 00 00 C0 41", 1)
                gg.refineNumber("h 00 00 08 42 00 00 C0 41", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_flag", results)
            end
            if state then
                gg.editAll("h 00 00 00 00 00 00 00 00", 1)
            else
                gg.editAll("h 00 00 08 42 00 00 C0 41", 1)
            end
            gg.clearResults()
            local preload2 = memory:load("hide_flag2")
            if preload2 then
                gg.clearResults()
                gg.loadResults(preload2)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h 61 32 DB C1 02 9A 70 41 C8 07 5D 3F 63 EE 5A 3F 00 00 00 3F 00 00 00 3F FF FF FF FF 00 00 44 42 00 00 20 42", 1)
                gg.refineNumber("h FF FF FF FF", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("hide_flag2", results)
            end
            if state then
                gg.editAll("h 00 00 00 00", 1)
                showToast("Hide Flag Enabled", true)
            else
                gg.editAll("h FF FF FF FF", 1)
                showToast("Hide Flag Disabled", true)
            end
            gg.clearResults()
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "zoom", "Zoom Adjust", "Adjust how close or far your camera", "slider", {
        {title="Min", min=10, max=100, current=20},
        {title="Max", min=10, max=100, current=50}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local results = memory:load("zoom")
            if not results then
                gg.clearResults()
                gg.setRanges(16)
                gg.searchNumber("20;50::5", 16)
                results = gg.getResults(gg.getResultsCount())
                gg.clearResults()
                if #results > 0 then memory:save("zoom", results) end
            end
            if results then
                for i, v in ipairs(results) do
                    v.value = (i % 2 == 1) and vals[1] or vals[2]
                    v.flags = 16
                end
                gg.setValues(results)
            end
            
            finish_task()
            done()
        end)
    end)

    addModule(container, "gravity", "Gravity Adjust", "Adjust how strong is the gravity", "slider", {
        {title="X", min=-100, max=100, current=0},
        {title="Y", min=-100, max=100, current=-10}
    }, function(done, vals)
        scheduler:add(function(finish_task)
            local allGravity = memory:load("gravity")

            if not allGravity then
                allGravity = { x = {}, y = {} }
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("00000021h;00000000h;0000001Ah;00000000h;00000031h;00000000h;00000028h;00000000h;00000000h;00000017h;00000000h;756F4316h;7972746Eh;65646973h::81", 4)
                gg.refineNumber("00000021h", 4)

                local results = gg.getResults(gg.getResultsCount())
                gg.clearResults()

                if #results > 0 then
                    local toProcess = {}
                    for _, v in ipairs(results) do
                        gg.searchNumber(v.address, 32)
                        local ptrResults = gg.getResults(gg.getResultsCount())
                        gg.clearResults()
                        for __, ptr in ipairs(ptrResults) do
                            local getPtr = gg.getValues({{ address = ptr.address + 0x8, flags = 32 }})[1].value
                            local checkVal = gg.getValues({{ address = getPtr, flags = 4 }})[1].value
                            if checkVal == 0x74616E2A then
                                table.insert(toProcess, ptr.address)
                            end
                        end
                    end

                    for _, baseAddr in ipairs(toProcess) do
                        local currentAddr = baseAddr
                        while true do
                            local gravityPtr = gg.getValues({{ address = currentAddr, flags = 32 }})[1].value
                            if gravityPtr == 0 then break end
                            local region = gg.getValuesRange({{ address = gravityPtr, flags = 32 }})[1]
                            if region == "Ca" or region == "O" then
                                local check = gg.getValues({{ address = gravityPtr + 0x48, flags = 4 }})[1].value
                                if check ~= 0 then
                                    table.insert(allGravity.x, {address = gravityPtr + 0x120, flags = 16})
                                    table.insert(allGravity.y, {address = gravityPtr + 0x124, flags = 16})
                                else
                                    break
                                end
                            else
                                break
                            end
                            currentAddr = currentAddr + 0x8
                        end
                    end
                    memory:save("gravity", allGravity)
                end
            end

            if #allGravity.x > 0 then
                for i = 1, #allGravity.x do
                    allGravity.x[i].value = vals[1]
                    allGravity.y[i].value = vals[2]
                end
                gg.setValues(allGravity.x)
                gg.setValues(allGravity.y)
            end
            
            finish_task()
            done()
        end)
    end)
end

end

__vfs['modules/tabs/settings.lua'] = function(...)
--[[
  Settings Tab - Script settings and UI customization
  Features: Memory info, background opacity, background RGB,
            accent RGB, logo RGB, sub-text RGB

  All color preferences are saved globally (PID-independent) via
  memory:saveGlobal so they survive game restarts without being cleared
  by a process change.
]]

return function(container)
    local saved = memory:loadGlobal("ui_prefs")
    if saved then
        LOG.info("INIT", "User preferences RE-APPLIED")
        for k, v in pairs(saved) do
            if UI[k] ~= nil then UI[k] = v end
        end
    end
    
    local function saveAndRefresh()
        memory:saveGlobal("ui_prefs", UI)
        MainHandler.post(function()
            if menuView then
                menuView.setBackground(getSkin(UI.BG, 16, 0, UI.STROKE))
            end
            if activeTabView then
                loadCategory("settings", activeTabView)
            end
        end)
    end
    -- ── Read-only info ────────────────────────────────────────────────────────

    local function regionName()
        if BaseRegion == -2080896 then return "O: Other"
        elseif BaseRegion == 4 then return "Ca: C++ alloc"
        else return "U: Unknown" end
    end

    addModule(container, "memory_range", "Memory Range", "Current selected memory range", "ro", regionName(), nil)
    addModule(container, "gamestatus_address", "GameStatus", "Current gamestatus address", "ro", string.format("0x%X", BaseGameStatus or 0), nil)

    -- ── Custom Colors Info ────────────────────────────────────────────────────
    -- Allow user to changes colors of this script.
    addModule(container, "colors_info", "About Custom Colors", "Let's you customize this script menu colors, restart this script after customizing for better results.", "ro", "", nil)
    
    -- ── Background Opacity ────────────────────────────────────────────────────
    -- Writes to the alpha byte of UI.BG; HEADER, CARD, and GLASS track it at
    -- fixed ratios so the visual hierarchy stays consistent.

    local function getAlpha(color)
        return (color >> 24) & 0xFF
    end

    local function setLayerAlpha(a)
        local function recolor(base, ratio)
            return (math.min(math.floor(a * ratio), 0xFF) << 24) | (base & 0x00FFFFFF)
        end
        UI.BG = recolor(UI.BG, 1.00)
        UI.HEADER = recolor(UI.HEADER, 1.25)
        UI.CARD = recolor(UI.CARD, 1.55)
        UI.GLASS = recolor(UI.GLASS, 0.75)
    end

    addModule(container, "bg_opacity", "Background Opacity",
        "Transparency of panels, cards, and header",
        "slider",
        {min = 1, max = 255, current = getAlpha(UI.BG), title = "Alpha"},
        function(done, val)
            setLayerAlpha(val)
            saveAndRefresh()
            done()
        end
    )

    -- ── Background RGB ────────────────────────────────────────────────────────
    -- Adjusts the R, G, B hue of UI.BG. HEADER and CARD are derived at fixed
    -- brightness ratios so the layer hierarchy stays intact. Alphas are
    -- preserved as-is (use Background Opacity to change them).

    local function setBgRgb(r, g, b)
        local function recolorRgb(base, ratio)
            local a = (base >> 24) & 0xFF
            local nr = math.min(math.floor(r * ratio), 0xFF)
            local ng = math.min(math.floor(g * ratio), 0xFF)
            local nb = math.min(math.floor(b * ratio), 0xFF)
            return (a << 24) | (nr << 16) | (ng << 8) | nb
        end
        UI.BG = recolorRgb(UI.BG, 1.00)
        UI.HEADER = recolorRgb(UI.HEADER, 1.30)
        UI.CARD = recolorRgb(UI.CARD, 1.55)
    end

    addModule(container, "bg_rgb", "Background RGB",
        "Hue for panel backgrounds (Header and Card scale automatically)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.BG >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.BG >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.BG & 0xFF, title = "B"},
        },
        function(done, vals)
            setBgRgb(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Accent RGB ────────────────────────────────────────────────────────────
    -- ACCENT uses fixed alpha 0x60 (38% opaque).
    -- MUTED is derived automatically at alpha 0x4D with each channel halved.

    local function buildAccent(r, g, b)
        UI.ACCENT = (0x60 << 24) | (r << 16) | (g << 8) | b
        UI.MUTED = (0x4D << 24) | ((r >> 1) << 16) | ((g >> 1) << 8) | (b >> 1)
    end

    addModule(container, "accent_rgb", "Accent RGB",
        "Tint for buttons, toggles, and active cards (muted color auto-derived)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.ACCENT >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.ACCENT >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.ACCENT & 0xFF, title = "B"},
        },
        function(done, vals)
            buildAccent(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Logo (Highlight) RGB ──────────────────────────────────────────────────
    -- LOGO is always fully opaque (alpha 0xFF).
    -- Used for labels, icons, slider arrows, and the wordmark.

    local function buildLogo(r, g, b)
        UI.LOGO = (0xFF << 24) | (r << 16) | (g << 8) | b
    end

    addModule(container, "logo_rgb", "Highlight RGB",
        "Color for labels, icons, and interactive text (always fully opaque)",
        "slider",
        {
            {min = 0, max = 255, current = (UI.LOGO >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.LOGO >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.LOGO & 0xFF, title = "B"},
        },
        function(done, vals)
            buildLogo(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Sub-text RGB ──────────────────────────────────────────────────────────
    -- SUB uses fixed alpha 0xDD (87% opaque).
    -- Used for descriptions and inactive tab labels.

    local function buildSub(r, g, b)
        UI.SUB = (0xDD << 24) | (r << 16) | (g << 8) | b
    end

    addModule(container, "sub_rgb", "Sub-text RGB",
        "Color for descriptions and inactive tab labels",
        "slider",
        {
            {min = 0, max = 255, current = (UI.SUB >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.SUB >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.SUB & 0xFF, title = "B"},
        },
        function(done, vals)
            buildSub(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )
    
    -- ── Text RGB ──────────────────────────────────────────────────────────────
    -- Main text color used throughout the menu.
    
    local function buildText(r, g, b)
        UI.TEXT = (0xFF << 24) | (r << 16) | (g << 8) | b
        UI.LOGO = UI.TEXT
    end
    
    addModule(container, "text_rgb", "Text RGB",
        "Color for main menu text",
        "slider",
        {
            {min = 0, max = 255, current = (UI.TEXT >> 16) & 0xFF, title = "R"},
            {min = 0, max = 255, current = (UI.TEXT >> 8) & 0xFF, title = "G"},
            {min = 0, max = 255, current = UI.TEXT & 0xFF, title = "B"},
        },
        function(done, vals)
            buildText(vals[1], vals[2], vals[3])
            saveAndRefresh()
            done()
        end
    )

    -- ── Window Size ───────────────────────────────────────────────────────────
    
    addModule(container, "win_width", "Menu Width",
        "Width of the floating menu (" .. RESIZE_MIN_W .. " – " .. RESIZE_MAX_W .. " dp)",
        "slider",
        {min = RESIZE_MIN_W, max = RESIZE_MAX_W, current = WIN_W, title = "Width"},
        function(done, val)
            applyWindowResize(val, WIN_H)
            done()
        end
    )

    addModule(container, "win_height", "Menu Height",
        "Height of the scrollable content area (" .. RESIZE_MIN_H .. " – " .. RESIZE_MAX_H .. " dp)",
        "slider",
        {min = RESIZE_MIN_H, max = RESIZE_MAX_H, current = WIN_H, title = "Height"},
        function(done, val)
            applyWindowResize(WIN_W, val)
            done()
        end
    )

end

end

__vfs['modules/tabs/shop.lua'] = function(...)
--[[
  Shop Tab - Shop mode features
  Status: Free chest, Change chest type, Free purchases (also works for special offers as popup/badges).
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    addModule(container, "free_chest", "Free Chest", "Make the chests free in Shop Tab", "switch", nil, function(done, state)
        scheduler:add(function(finish_task)
            local preload = memory:load("free_chest")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(8)
                gg.searchNumber("h CE CC 4C 3F AF 47 E1 3E FA 7E AA 3E 5B B1 BF 3C CD CC CC 3D", 1)
                gg.refineNumber("h CD CC CC 3D", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("free_chest", results)
            end
            
            if state then
                gg.editAll("0", 1)
                showToast("Free Chest Enabled", true)
            else
                gg.editAll("h CD CC CC 3D", 1)
                showToast("Free Chest Disabled", true)
            end
            
            gg.clearResults()
            finish_task()
            done()
        end)
    end)

    addModule(container, "change_chest", "Change Chest", "Change legendary chest to selected chest", "spinner", {
        options = {
            "Common Chest", "Uncommon Chest", "Rare Chest", "Epic Chest",
            "Champion Chest", "Special Chest 1", "Xmas Chest", "Legendary Chest",
            "Blue Chest", "VIP Chest 1", "VIP Chest 2", "Video Chest",
            "Starter Chest", "Special Chest 2", "Fingersoft Chest", "Mega Chest",
            "Team Spirit Chest", "Style Chest", "Mythic Chest"
        },
        default = 8
    }, function(done, item, index)
        scheduler:add(function(finish_task)
            local chestIDs = {
                0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 18, 19, 20
            }
            local preload = memory:load("change_chest")
            if preload then
                gg.clearResults()
                gg.loadResults(preload)
                gg.getResults(gg.getResultsCount())
            else
                gg.clearResults()
                gg.setRanges(BaseRegion)
                gg.searchNumber("h 2A 48 75 67 65 20 43 68 65 73 74 20 6F 66 20 47 6F 6F 64 69 65 73 00 00 E8 03 00 00 07 00 00 00", 1)
                gg.refineNumber("h 07 00 00 00", 1)
                gg.refineNumber("h 07", 1)
                local results = gg.getResults(gg.getResultsCount())
                memory:save("change_chest", results)
            end
            
            gg.editAll(chestIDs[index], 1)
            showToast("Chest changed to " .. item)
            
            gg.clearResults()
            finish_task()
            done()
        end)
    end)
    
    addModule(container, "free_purchases", "Free Purchases", "Make some purchases free in the shop tab (also works for special offers as popup/badges)", "button", nil, function(done)
        scheduler:add(function(finish_task)
            gg.clearResults()
            gg.setRanges(4)
            gg.searchNumber("h 04 65 6E 00", 1)
            gg.refineNumber("h 04", 1)
            
            local results = gg.getResults(gg.getResultsCount())
            local totalres = #results
            if totalres > 0 then
                local min = results[1].address
                local max = results[totalres].address
                
                min = min - 0x4
                max = max + 0x4
                
                local counter = 0 
                local edits = {}
                local tptrs = {}
                
                for _, r in ipairs(results) do
                    gg.clearResults()
                    gg.searchNumber(tostring(r.address), 32, false, gg.SIGN_EQUAL, min, max, 0)
                    local ptrs = gg.getResults(gg.getResultsCount())
                    for _, sp in ipairs(ptrs) do
                        table.insert(tptrs, {sp.address + 0x18, flags = 4})
                    end
                    counter = counter + 1
                    showToast(tostring(counter) .. "/" .. tostring(totalres), true)
                end
                
                local tptrs = gg.getValues(tptrs)
                for _, p in ipairs(tptrs) do
                    local val = p.value
                    if val > 0 and val < 100 then
                        for off = 0x18, 0x2C, 4 do
                            table.insert(edits, {address = p.address + off, flags = 4, value = 0})
                        end
                    end
                end
                
                if #edits > 0 then
                    gg.setValues(edits)
                    gg.toast("Free Purchase Successful")
                end
            end

            gg.clearResults()
            finish_task()
            done()
        end)
    end)
end
end

__vfs['modules/tabs/team.lua'] = function(...)
--[[
  Team Tab - Team mode features
  Status: TODO - Not yet implemented
  
  @module callback Receives container View to populate with modules
]]

return function(container)
    -- TODO: add team modules
end

end

__vfs['ui/ui.lua'] = function(...)
--[[
  UI Module - Interface management and component builder
  Creates and manages all UI elements: tabs, module cards, dialogs, animations
  
  Dependencies: All Android imports from main.lua, UI constants, helper functions
  Exports: loadCategory, addTab, addModule, updateRO, createIconView, createMenuView, initUI
]]


--[[================================
  CATEGORY MANAGEMENT
==================================]]

---Loads and displays a category (tab content) by ID.
---Updates active tab styling and populates moduleContainer with category modules.
---@param id string Tab identifier to load
---@param tabView View The tab TextView that was clicked
---@return nil
function loadCategory(id, tabView)
    LOG.info("loadCategory", "id=" .. tostring(id) .. " tabView=" .. tostring(tabView) .. " moduleContainer=" .. tostring(moduleContainer))
    if not moduleContainer or not tabView then
        LOG.warn("loadCategory", "EARLY RETURN — moduleContainer=" .. tostring(moduleContainer) .. " tabView=" .. tostring(tabView))
        return
    end

    moduleContainer.removeAllViews()

    if activeTabView then
        activeTabView.setTextColor(UI.SUB)
        activeTabView.setBackground(getSkin(UI.BG, 20))
    end

    tabView.setTextColor(UI.TEXT)
    tabView.setBackground(getSkin(UI.CARD, 50, 1, UI.STROKE))
    activeTabView = tabView

    local setCategory = categoryHandlers[id]
    if setCategory then
        local status, err = pcall(function() setCategory(moduleContainer) end)
        if not status then
            local errTxt = TextView(activity)
            errTxt.setText("Error: " .. tostring(err))
            errTxt.setTextColor(UI.RED)
            moduleContainer.addView(errTxt)
        end
    else
        local errTxt = TextView(activity)
        errTxt.setText("Category Not Found")
        errTxt.setTextColor(UI.SUB)
        moduleContainer.addView(errTxt)
    end
end

-- ─────────────────────────────────────────────
-- TAB BUILDER
-- ─────────────────────────────────────────────

---Creates a tab button that loads a category when clicked.
---@param parent View Layout to add tab to
---@param id string Tab identifier
---@param name string Display name for the tab
---@return View The created tab TextView
function addTab(parent, id, name)
    local tab = TextView(activity)
    local params = LinLayoutParams(-2, -2)
    params.rightMargin = dp(8)
    tab.setLayoutParams(params)
    tab.setText(tostring(name))
    tab.setGravity(Gravity.CENTER)
    tab.setPadding(dp(16), dp(6), dp(16), dp(6))
    tab.setTextColor(UI.SUB)
    tab.setTextSize(1, 11)
    tab.setTypeface(Typeface.create("sans-serif", Typeface.BOLD))
    tab.setBackground(getSkin(UI.BG, 20))
    tab.setOnClickListener(View.OnClickListener({
        onClick = function(v) loadCategory(id, v) end
    }))
    parent.addView(tab)
    return tab
end

-- ─────────────────────────────────────────────
-- MODULE CARD BUILDER
-- ─────────────────────────────────────────────

---Creates an interactive module card with various modes (switch, button, spinner, slider, input, ro).
---
--- Mode descriptions:
--- - "switch": Toggle on/off (state saved)
--- - "button": Single action button
--- - "ro": Read-only display (clickable to copy)
--- - "info": Static label with ⓘ indicator; tap card to open a detail dialog
--- - "spinner": Dropdown selector (state saved)
--- - "slider": Single or multi-slider input (state saved)
--- - "input": Single or multi-line text input (state saved)
---
---@param parent View Container to add card to
---@param id string Unique module identifier
---@param title string Display title
---@param desc string Description text
---@param mode string Module type: "switch" | "button" | "ro" | "info" | "spinner" | "slider" | "input"
---@param extra any Mode-specific data. For "info": the detail string shown in the dialog.
---@param callback? fun(done: fun(), ...) Function called on action. Must call done() when finished.
---@return nil
currentInputs = {}
function addModule(parent, id, title, desc, mode, extra, callback)
    if processingStates[id] == nil then processingStates[id] = false end
    if toggleStates[id] == nil then toggleStates[id] = false end
    if lastClickTimes[id] == nil then lastClickTimes[id] = 0 end

    local card = LinearLayout(activity)
    local cp = LinLayoutParams(-1, -2)
    cp.bottomMargin = dp(10)
    card.setLayoutParams(cp)
    card.setOrientation(1)
    card.setPadding(dp(15), dp(12), dp(15), dp(12))
    card.setBackground(getSkin(UI.CARD, 12, 1, UI.STROKE))
    card.setAlpha(1.0)

    local function safeCallback(...)
        local args = {...}
        local now = os.clock() * 1000
        if processingStates[id] or (now - lastClickTimes[id] < CLICK_COOLDOWN) then return end

        lastClickTimes[id] = now
        processingStates[id] = true

        card.setBackground(getSkin(UI.ACCENT, 12, 1, UI.STROKE))
        card.setAlpha(0.25)

        local function done()
            MainHandler.post(Runnable({
                run = function()
                    processingStates[id] = false
                    card.setBackground(getSkin(UI.CARD, 12, 1, UI.STROKE))
                    card.setAlpha(1.0)
                end
            }))
        end

        Thread(Runnable({
            run = function()
                if callback then
                    local status, err = pcall(function()
                        callback(done, table.unpack(args))
                    end)
                    memory:save("toggle_states",  toggleStates)
                    memory:save("input_states",   inputStates)
                    memory:save("spinner_states", spinnerStates)
                    memory:save("slider_states",  sliderStates)
                    if not status then
                        print("Error In Callback: " .. tostring(err))
                        done()
                    end
                else
                    Thread.sleep(CLICK_COOLDOWN)
                    done()
                end
            end
        })).start()
    end

    local topRow = LinearLayout(activity)
    topRow.setOrientation(0)
    topRow.setGravity(Gravity.CENTER_VERTICAL)

    local textLayout = LinearLayout(activity)
    textLayout.setLayoutParams(LinLayoutParams(0, -2, 1.0))
    textLayout.setOrientation(1)

    local t1 = TextView(activity)
    t1.setText(title)
    t1.setTextColor(UI.TEXT)
    t1.setTextSize(1, 14)
    t1.setTypeface(Typeface.create("sans-serif-medium", Typeface.BOLD))

    local t2 = TextView(activity)
    t2.setText(desc)
    t2.setTextColor(UI.SUB)
    t2.setTextSize(1, 10)

    textLayout.addView(t1)
    textLayout.addView(t2)
    topRow.addView(textLayout)

    local actionArea = LinearLayout(activity)
    actionArea.setGravity(Gravity.RIGHT | Gravity.CENTER_VERTICAL)

    if mode == "switch" then
        local sw = TextView(activity)
        sw.setLayoutParams(LinLayoutParams(dp(36), dp(18)))
        local function updateSw()
            sw.setBackground(getSkin(toggleStates[id] and UI.ACCENT or UI.MUTED, 20))
        end
        updateSw()
        card.setOnClickListener(View.OnClickListener({
            onClick = function()
                local now = os.clock() * 1000
                if processingStates[id] or (now - lastClickTimes[id] < CLICK_COOLDOWN) then return end
                toggleStates[id] = not toggleStates[id]
                updateSw()
                safeCallback(toggleStates[id])
            end
        }))
        actionArea.addView(sw)

    elseif mode == "button" then
        local btn = TextView(activity)
        btn.setLayoutParams(LinLayoutParams(dp(40), dp(35)))
        btn.setText("->")
        btn.setTextColor(UI.LOGO)
        btn.setGravity(Gravity.CENTER)
        btn.setTypeface(Typeface.create("sans-serif-black", Typeface.BOLD))
        btn.setTextSize(1, 14)
        btn.setBackground(getSkin(UI.ACCENT, 8))
        local runAction = function() safeCallback() end
        card.setOnClickListener(View.OnClickListener({ onClick = runAction }))
        btn.setOnClickListener(View.OnClickListener({ onClick = runAction }))
        actionArea.addView(btn)

    elseif mode == "ro" then
        local info = TextView(activity)
        local rawText = tostring(extra or "N/A")
        info.setText(rawText)
        info.setTextColor(UI.LOGO)
        info.setTypeface(Typeface.create("sans-serif-medium", Typeface.BOLD))
        info.setFocusable(true)
        info.setClickable(true)
        info.setOnClickListener(View.OnClickListener({
            onClick = function(v)
                local content = tostring(v.getText())
                local cm = activity.getSystemService("clipboard")
                local cd = ClipData.newPlainText("Copy", content)
                cm.setPrimaryClip(cd)
            end
        }))
        RO_Fields[id] = info
        actionArea.addView(info)

    elseif mode == "spinner" then
        local dropdown = LinearLayout(activity)
        dropdown.setOrientation(1)
        dropdown.setVisibility(View.GONE)
        dropdown.setPadding(0, dp(5), 0, dp(5))

        local savedIdx  = spinnerStates[id]
        local defaultIdx = extra.default or 1
        local currentIdx = savedIdx or defaultIdx

        local options     = extra.options or extra
        local initialText = options[currentIdx] or "Select"

        local val = TextView(activity)
        val.setText(tostring(initialText))
        val.setTextColor(UI.LOGO)
        val.setTypeface(Typeface.create("sans-serif-medium", Typeface.BOLD))
        actionArea.addView(val)

        local function buildDropdown()
            dropdown.removeAllViews()
            for i, item in ipairs(options) do
                local opt = TextView(activity)
                opt.setText(tostring(item))
                opt.setTextColor(UI.TEXT)
                opt.setPadding(dp(12), dp(10), dp(12), dp(10))
                opt.setBackground(getSkin(UI.BG, 8, 1, UI.STROKE))
                opt.setOnClickListener(View.OnClickListener({
                    onClick = function()
                        val.setText(tostring(item))
                        dropdown.setVisibility(View.GONE)
                        activeSpinner = nil
                        spinnerStates[id] = i
                        safeCallback(item, i)
                    end
                }))
                local lp = LinLayoutParams(-1, -2)
                lp.topMargin = dp(4)
                dropdown.addView(opt, lp)
            end
        end

        card.setOnClickListener(View.OnClickListener({
            onClick = function()
                if processingStates[id] then return end
                if activeSpinner and activeSpinner ~= dropdown then activeSpinner.setVisibility(View.GONE) end
                if dropdown.getVisibility() == View.GONE then
                    buildDropdown()
                    dropdown.setVisibility(View.VISIBLE)
                    activeSpinner = dropdown
                else
                    dropdown.setVisibility(View.GONE)
                    activeSpinner = nil
                end
            end
        }))
        topRow.addView(actionArea)
        card.addView(topRow)
        card.addView(dropdown)

    elseif mode == "slider" then
        local sliderContainer = LinearLayout(activity)
        sliderContainer.setOrientation(1)
        sliderContainer.setPadding(dp(5), dp(5), dp(5), dp(5))

        local isMulti    = type(extra[1]) == "table"
        local slidersData = isMulti and extra or {extra}

        if not sliderStates[id] then
            if isMulti then
                local temp = {}
                for i, cfg in ipairs(slidersData) do temp[i] = cfg.current end
                sliderStates[id] = temp
            else
                sliderStates[id] = slidersData[1].current
            end
        end

        local currentValues = isMulti and sliderStates[id] or {sliderStates[id]}

        for i, cfg in ipairs(slidersData) do
            local valTxt = TextView(activity)
            valTxt.setText((cfg.title or "Value") .. ": " .. currentValues[i])
            valTxt.setTextColor(UI.SUB)
            valTxt.setTextSize(1, 10)
            valTxt.setPadding(dp(2), dp(5), 0, 0)
            sliderContainer.addView(valTxt)

            local controlsRow = LinearLayout(activity)
            controlsRow.setOrientation(0)
            controlsRow.setGravity(Gravity.CENTER_VERTICAL)

            local isLast    = (i == #slidersData)
            local seekParams = LinLayoutParams(0, dp(35), 1.0)
            if not isLast then seekParams.setMargins(0, 0, dp(40), 0) end

            local seek = SeekBar(activity)
            seek.setLayoutParams(seekParams)
            seek.setMax(cfg.max - cfg.min)
            seek.setProgress(currentValues[i] - cfg.min)
            seek.setOnSeekBarChangeListener(SeekBar.OnSeekBarChangeListener({
                onProgressChanged = function(s, p, f)
                    local newVal = p + cfg.min
                    currentValues[i] = newVal
                    if isMulti then sliderStates[id][i] = newVal else sliderStates[id] = newVal end
                    valTxt.setText((cfg.title or "Value") .. ": " .. newVal)
                end
            }))
            controlsRow.addView(seek)

            if isLast then
                local goBtn = TextView(activity)
                goBtn.setLayoutParams(LinLayoutParams(dp(40), dp(30)))
                goBtn.setText("->")
                goBtn.setTextColor(UI.LOGO)
                goBtn.setGravity(Gravity.CENTER)
                goBtn.setTypeface(Typeface.create("sans-serif-black", Typeface.BOLD))
                goBtn.setBackground(getSkin(UI.ACCENT, 8))
                goBtn.setOnClickListener(View.OnClickListener({
                    onClick = function() safeCallback(sliderStates[id]) end
                }))
                controlsRow.addView(goBtn)
            end
            sliderContainer.addView(controlsRow)
        end
        card.addView(sliderContainer)

    elseif mode == "input" then
        local inputs = {}

        local inputContainer = LinearLayout(activity)
        inputContainer.setOrientation(1)
        inputContainer.setLayoutParams(LinLayoutParams(-1, -2))
        inputContainer.setPadding(0, dp(8), 0, 0)
    
        local dataKeys = type(extra) == "table" and extra or {extra}
    
        if not inputStates[id] then
            if #dataKeys > 1 then
                local temp = {}
                for i, data in ipairs(dataKeys) do 
                    temp[i] = type(data) == "table" and data.value or "" 
                end
                inputStates[id] = temp
            else
                inputStates[id] = type(dataKeys[1]) == "table" and dataKeys[1].value or ""
            end
        end

        local function performMod()
            local results = {}
            for i, e in ipairs(inputs) do
                results[i] = tostring(e.getText() or "")
            end
    
            if #results == 1 then 
                inputStates[id] = results[1] 
            else 
                inputStates[id] = results 
            end

            -- Strong cleanup
            local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
            if menuView then
                imm.hideSoftInputFromWindow(menuView.getWindowToken(), 0)
            end

            for _, e in ipairs(inputs) do
                e.clearFocus()
            end

            mParams.flags = 8 | 32
            windowManager.updateViewLayout(menuView, mParams)

            if #results == 1 then 
                safeCallback(results[1]) 
            else 
                safeCallback(results) 
            end
        end

        -- Create inputs
        for i, data in ipairs(dataKeys) do
            local row = LinearLayout(activity)
            row.setOrientation(0)
            local rp = LinLayoutParams(-1, dp(35))
            if i > 1 then rp.topMargin = dp(6) end
            
            row.setLayoutParams(rp)

            local edit = EditText(activity)
            local editParams = LinLayoutParams(0, -1, 1.0)
            if i < #dataKeys then editParams.setMargins(0, 0, dp(48), 0) end
            
            edit.setLayoutParams(editParams)

            local h        = type(data) == "table" and data.hint or data
            local savedVal = type(inputStates[id]) == "table" and inputStates[id][i] or inputStates[id]
            local itype    = type(data) == "table" and data.type or "text"

            edit.setHint(tostring(h))
            edit.setText(tostring(savedVal))

            if Build.VERSION.SDK_INT >= 12 then 
                edit.setTextIsSelectable(true) 
            end

            if itype == "password" then
                edit.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_VARIATION_PASSWORD)
                edit.setTransformationMethod(PasswordTransformationMethod.getInstance())
                edit.post(Runnable({run = function() edit.setTransformationMethod(PasswordTransformationMethod.getInstance()) end}))
            elseif itype == "number" then
                edit.setInputType(InputType.TYPE_CLASS_NUMBER | InputType.TYPE_NUMBER_FLAG_DECIMAL | InputType.TYPE_NUMBER_FLAG_SIGNED)
            elseif itype == "date" then
                edit.setInputType(InputType.TYPE_CLASS_DATETIME)
            else
                edit.setInputType(InputType.TYPE_CLASS_TEXT | InputType.TYPE_TEXT_FLAG_NO_SUGGESTIONS)
            end
            
            local IME_FLAG_NO_EXTRACT_UI = 16777216
            local IME_FLAG_NO_FULLSCREEN = 33554432
            local IME_ACTION_DONE        = 6
            edit.setImeOptions(IME_FLAG_NO_EXTRACT_UI | IME_FLAG_NO_FULLSCREEN | IME_ACTION_DONE)

            edit.setTextColor(UI.TEXT)
            edit.setHintTextColor(UI.SUB)
            edit.setTextSize(1, 12)
            edit.setSingleLine(true)
            edit.setPadding(dp(10), 0, dp(10), 0)
            edit.setBackground(getSkin(UI.BG, 8, 1, UI.STROKE))

            edit.addTextChangedListener(TextWatcher{
                onTextChanged = function(s, start, before, count)
                    if type(inputStates[id]) == "table" then
                        inputStates[id][i] = tostring(s)
                    else
                        inputStates[id] = tostring(s)
                    end
                end
            })

            edit.setOnKeyListener(View.OnKeyListener{
                onKey = function(v, keyCode, event)
                    if event.getAction() == 0 then
                        if keyCode == 66 then
                            performMod()
                            return true
                        elseif keyCode == 61 then
                            local nextIndex = i + 1
                            if inputs[nextIndex] then
                                inputs[nextIndex].requestFocus()
                            else
                                inputs[1].requestFocus()
                            end
                            return true
                        end
                    end
                    return false
                end
            })
        
            edit.setOnTouchListener(View.OnTouchListener{
                onTouch = function(v, ev)
                    if ev.getAction() == MotionEvent.ACTION_DOWN then
                        mParams.flags = WindowManager.LayoutParams.FLAG_NOT_TOUCH_MODAL | WindowManager.LayoutParams.FLAG_WATCH_OUTSIDE_TOUCH
                        windowManager.updateViewLayout(menuView, mParams)
        
                        v.requestFocus()
                        local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
                        v.postDelayed(function()
                            imm.showSoftInput(v, InputMethodManager.SHOW_IMPLICIT)
                        end, 80)
                    end
                    return false
                end
            })

            table.insert(inputs, edit)
            row.addView(edit)

            if i == #dataKeys then
                local goBtn = TextView(activity)
                local gbp = LinLayoutParams(dp(40), -1)
                gbp.leftMargin = dp(8)
                goBtn.setLayoutParams(gbp)
                goBtn.setText("->")
                goBtn.setTextColor(UI.LOGO)
                goBtn.setGravity(Gravity.CENTER)
                goBtn.setTypeface(Typeface.DEFAULT_BOLD)
                goBtn.setBackground(getSkin(UI.ACCENT, 8))
                goBtn.setOnClickListener(View.OnClickListener{ onClick = performMod })
                row.addView(goBtn)
            end
            
            currentInputs = inputs
            inputContainer.addView(row)
        end

        card.addView(inputContainer)
    end

    if mode ~= "spinner" then
        topRow.addView(actionArea)
        card.addView(topRow, 0)
    end

    parent.addView(card)
end

-- ─────────────────────────────────────────────
-- RO FIELD UPDATER
-- ─────────────────────────────────────────────

---Updates the text content of a read-only field by ID.
---Posts update to main thread for thread safety.
---@param id string Module identifier
---@param newText any New text value (converted to string)
---@return nil
function updateRO(id, newText)
    MainHandler.post(function()
        if RO_Fields[id] then
            RO_Fields[id].setText(tostring(newText))
        end
    end)
end

-- ─────────────────────────────────────────────
-- ICON VIEW (Collapsed Floating Pill)
-- ─────────────────────────────────────────────

---Creates the floating icon view - a minimal draggable pill when menu is minimized.
---Displays title, version, and exit button. Tappable to expand menu.
---@return View The icon view LinearLayout
function createIconView()
    LOG.info("createIconView", "START | activity=" .. tostring(activity))
    local iconRoot = LinearLayout(activity)
    iconRoot.setOrientation(0)
    iconRoot.setGravity(Gravity.BOTTOM)
    iconRoot.setBackground(getSkin(UI.HEADER, 16))
    iconRoot.setPadding(dp(15), dp(10), dp(10), dp(10))
    
    -- Explicit dp(WIN_W) width with plain LayoutParams (not LinLayoutParams).
    -- -1 (MATCH_PARENT) on a direct WM child fills the *entire screen* width,
    -- not just the WM window. We want exactly the same width as menuView's root,
    -- so we set it explicitly. Height is WRAP_CONTENT so the pill only takes
    -- as much vertical space as its content (title + ✕ row), not the full menu height.
    local params = LayoutParams(dp(WIN_W), -2)
    iconRoot.setLayoutParams(params)
    
    -- Title
    local title = TextView(activity)
    title.setText("VOID")
    title.setTextColor(UI.LOGO)
    title.setTextSize(1, 15)
    title.setTypeface(Typeface.create("sans-serif-black", Typeface.BOLD))
    iconRoot.addView(title)

    -- Subtitle
    local sub = TextView(activity)
    sub.setText(" v1.0 • By Vekendian")
    sub.setTextColor(UI.SUB)
    sub.setTextSize(1, 8)
    sub.setPadding(dp(6), 0, 0, dp(2))
    sub.setSingleLine(true)
    sub.setEllipsize(TruncateAt.MARQUEE)
    sub.setMarqueeRepeatLimit(-1)
    sub.setHorizontallyScrolling(true)
    sub.setFocusable(true)
    sub.setFocusableInTouchMode(true)
    sub.requestFocus()
    sub.setSelected(true)
    sub.setTypeface(Typeface.create("sans-serif-medium", Typeface.NORMAL))
    iconRoot.addView(sub)
    
    local xButtonContainer = LinearLayout(activity)
    xButtonContainer.setOrientation(0)
    xButtonContainer.setGravity(Gravity.RIGHT | Gravity.CENTER_VERTICAL)
    
    local xParams = LinLayoutParams(0, -2, 1)
    xButtonContainer.setLayoutParams(xParams)
    iconRoot.addView(xButtonContainer)
    
    local function addHeaderBtn(txt, color, click)
        local b = TextView(activity)
        b.setText(txt)
        b.setTextColor(color)
        b.setTextSize(1, 16)
        b.setPadding(dp(0), dp(0), dp(5), dp(0))
        b.setTypeface(Typeface.DEFAULT_BOLD)
        b.setOnClickListener(View.OnClickListener({
            onClick = function()
                Thread(Runnable({ run = function() pcall(click) end })).start()
            end
        }))
        xButtonContainer.addView(b)
    end
    
    addHeaderBtn("✕", UI.RED, function()
        showDialog("Confirm Exit", "Exit The Script?", {"Yes", function()
            memory:save("toggle_states",  toggleStates)
            memory:save("input_states",   inputStates)
            memory:save("spinner_states", spinnerStates)
            memory:save("slider_states",  sliderStates)
            exitScript()
        end}, {"No"})
    end)
    
    -- Drag & Click
    local initialX, initialY, initialTouchX, initialTouchY

    iconRoot.setOnTouchListener(View.OnTouchListener{
        onTouch = function(v, e)
            if e.getAction() == MotionEvent.ACTION_DOWN then
                initialX      = mParams.x
                initialY      = mParams.y
                initialTouchX = e.getRawX()
                initialTouchY = e.getRawY()
                return true

            elseif e.getAction() == MotionEvent.ACTION_MOVE then
                mParams.x = initialX + (e.getRawX() - initialTouchX)
                mParams.y = initialY + (e.getRawY() - initialTouchY)
                windowManager.updateViewLayout(iconView, mParams)
                return true

            elseif e.getAction() == MotionEvent.ACTION_UP then
                -- Click detection
                if math.abs(e.getRawX() - initialTouchX) < 12 and math.abs(e.getRawY() - initialTouchY) < 12 then
                    switchToMenu()
                end
                return true
            end
            return false
        end
    })

    return iconRoot
end

-- ─────────────────────────────────────────────
-- MENU VIEW  (expanded panel)
-- ─────────────────────────────────────────────

---Creates the full menu view - main UI panel with tabs, content, and header.
---Includes draggable header, tab navigation, and content scroll area.
---@return View The menu FrameLayout containing all UI elements

-- ─────────────────────────────────────────────
-- MENU VIEW HELPERS
-- createMenuView() was a 387-line monolith with 41 locals + 503 bytecodes.
-- Every dp()/addView()/setXxx() call crosses the Lua→Java bridge and burns
-- JVM stack space. Wrapped in _safePcall the cumulative depth overflowed the
-- 8 MB stack. Fix: split into focused helpers so each frame is popped before
-- the next is pushed, keeping peak depth well below the limit.
-- ─────────────────────────────────────────────

---Builds the root LinearLayout for the menu and wires its touch-to-dismiss listener.
---@param base FrameLayout Parent frame
---@return View root LinearLayout
local function _buildMenuRoot(base)
    local root = LinearLayout(activity)
    root.setOrientation(1)
    root.setBackground(getSkin(UI.BG, 16, 0, UI.STROKE))
    root.setLayoutParams(FrameLayout.LayoutParams(dp(WIN_W), -2))
    root.setFocusable(true)
    root.setFocusableInTouchMode(true)
    root.setOnTouchListener(View.OnTouchListener{
        onTouch = function(v, e)
            if e.getAction() == 4 or e.getAction() == MotionEvent.ACTION_DOWN then
                local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
                local currentFocus = activity.getCurrentFocus()
                if currentFocus then
                    currentFocus.clearFocus()
                    imm.hideSoftInputFromWindow(currentFocus.getWindowToken(), 0)
                end
                mParams.flags = 8 | 32 | 16
                windowManager.updateViewLayout(menuView, mParams)
            end
            return false
        end
    })
    return root
end

---Builds the draggable header row (title, subtitle, ✕ button) and adds it to root.
---@param root View Parent LinearLayout
local function _buildMenuHeader(root)
    local headerGroup = LinearLayout(activity)
    headerGroup.setOrientation(0)
    headerGroup.setGravity(Gravity.CENTER_VERTICAL)
    headerGroup.setPadding(dp(15), dp(10), dp(10), dp(10))
    headerGroup.setBackground(getSkin(UI.HEADER, 16))
    headerGroup.setClickable(true)
    headerGroup.setFocusable(false)

    local titleLayout = LinearLayout(activity)
    titleLayout.setOrientation(0)
    titleLayout.setGravity(Gravity.BOTTOM)
    titleLayout.setLayoutParams(LinLayoutParams(0, -2, 1.0))

    local title = TextView(activity)
    title.setText("VOID")
    title.setTextColor(UI.LOGO)
    title.setTextSize(1, 16)
    title.setTypeface(Typeface.create("sans-serif-black", Typeface.BOLD))
    titleLayout.addView(title)

    local sub = TextView(activity)
    sub.setText(" v1.0 • By Vekendian")
    sub.setTextColor(UI.SUB)
    sub.setTextSize(1, 8)
    sub.setPadding(dp(6), 0, 0, dp(2))
    sub.setSingleLine(true)
    sub.setEllipsize(TruncateAt.MARQUEE)
    sub.setMarqueeRepeatLimit(-1)
    sub.setHorizontallyScrolling(true)
    sub.setFocusable(true)
    sub.setFocusableInTouchMode(true)
    sub.requestFocus()
    sub.setSelected(true)
    titleLayout.addView(sub)
    headerGroup.addView(titleLayout)

    -- Drag-to-move + tap-to-minimise
    local sx, sy, lx, ly
    local touchStartTime = 0

    headerGroup.setOnTouchListener(View.OnTouchListener({
        onTouch = function(v, ev)
            local action = ev.getAction()
            if action == MotionEvent.ACTION_DOWN then
                sx = ev.getRawX(); sy = ev.getRawY()
                lx = mParams.x;    ly = mParams.y
                touchStartTime = os.clock() * 1000
                return true
            elseif action == MotionEvent.ACTION_MOVE then
                mParams.x = lx + (ev.getRawX() - sx)
                mParams.y = ly + (ev.getRawY() - sy)
                windowManager.updateViewLayout(menuView, mParams)
                return true
            elseif action == MotionEvent.ACTION_UP then
                local dur  = (os.clock() * 1000) - touchStartTime
                local dist = math.abs(ev.getRawX() - sx) + math.abs(ev.getRawY() - sy)
                if dur < 300 and dist < 20 then
                    switchToIcon(); return true
                end
            end
            return false
        end
    }))

    -- ✕ close button (inlined; no local closure needed)
    local xBtn = TextView(activity)
    xBtn.setText("✕")
    xBtn.setTextColor(UI.RED)
    xBtn.setTextSize(1, 16)
    xBtn.setPadding(dp(10), dp(0), dp(5), dp(0))
    xBtn.setTypeface(Typeface.DEFAULT_BOLD)
    xBtn.setOnClickListener(View.OnClickListener({
        onClick = function()
            Thread(Runnable({ run = function()
                pcall(function()
                    showDialog("Confirm Exit", "Exit The Script?", {"Yes", function()
                        memory:save("toggle_states",  toggleStates)
                        memory:save("input_states",   inputStates)
                        memory:save("spinner_states", spinnerStates)
                        memory:save("slider_states",  sliderStates)
                        exitScript()
                    end}, {"No"})
                end)
            end })).start()
        end
    }))
    headerGroup.addView(xBtn)
    root.addView(headerGroup)
end

---Builds the horizontal tab bar and adds it to root.
---@param root View Parent LinearLayout
---@return View|nil firstTab, string|nil firstTabId
local function _buildMenuTabs(root)
    local tabScroll = HorizontalScrollView(activity)
    tabScroll.setHorizontalScrollBarEnabled(false)
    tabScroll.setPadding(dp(15), dp(15), dp(15), dp(5))

    local tabLayout = LinearLayout(activity)
    tabLayout.setOrientation(0)
    tabScroll.addView(tabLayout)
    root.addView(tabScroll)

    local firstTab, firstTabId = nil, nil
    local menuList = tabHandlers or {{"unknown", "unknown"}}
    for i, m in ipairs(menuList) do
        local t = addTab(tabLayout, m[1], m[2])
        if i == 1 then firstTab = t; firstTabId = m[1] end
    end
    return firstTab, firstTabId
end

---Builds the content ScrollView + moduleContainer and adds them to root.
---@param root View Parent LinearLayout
---@return View scroll The ScrollView (needed by resize handles)
local function _buildMenuContent(root)
    local scroll = ScrollView(activity)
    scroll.setLayoutParams(LinLayoutParams(-1, dp(WIN_H)))
    scroll.setVerticalScrollBarEnabled(false)
    scroll.setPadding(dp(15), dp(10), dp(15), dp(15))

    moduleContainer = LinearLayout(activity)
    moduleContainer.setOrientation(1)
    scroll.addView(moduleContainer)
    root.addView(scroll)
    return scroll
end

-- Window size bounds (dp).  Referenced by applyWindowResize and settings sliders.
RESIZE_MIN_W = 200
RESIZE_MAX_W = 650
RESIZE_MIN_H = 200
RESIZE_MAX_H = 650
-- Fixed dp overhead for header row + tab bar (not part of the resizable scroll area).
-- Keeps mParams.height explicit so WindowManager doesn't expand the overlay to full screen.
-- Global so switchToMenu in main.lua can restore mParams.height correctly.
UI_CHROME_H = 95

-- Module-level upvalues captured from createMenuView so applyWindowResize
-- can reach the inner layout views without being nested inside createMenuView.
local _menuRoot   = nil
local _menuScroll = nil

---Saves the new window dimensions and exits so the user can restart the script.
---Direct WindowManager.updateViewLayout calls crash the Lua environment when
---the target view is not currently attached, so a clean restart is the only
---safe way to apply new dimensions.
---@param newW number Target width in dp
---@param newH number Target height in dp
function applyWindowResize(newW, newH)
    WIN_W = math.max(RESIZE_MIN_W, math.min(RESIZE_MAX_W, math.floor(newW)))
    WIN_H = math.max(RESIZE_MIN_H, math.min(RESIZE_MAX_H, math.floor(newH)))
    memory:saveGlobal("window_size", { w = WIN_W, h = WIN_H })
    showToast("Size saved! Please restart the script to apply.")
    exitScript()
end


---Wires the back-key listener and outside-tap dismissal on the menu overlay.
---Separated so its handleBackButton closure doesn't live in createMenuView's frame.
---@param base FrameLayout The overlay root (menuView)
local function _setupMenuInteraction(base)
    local function handleBackButton()
        local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
        if menuView then
            imm.hideSoftInputFromWindow(menuView.getWindowToken(), 0)
        end
        if currentInputs then
            for _, edit in ipairs(currentInputs) do edit.clearFocus() end
        end
        mParams.flags = 8 | 32
        -- Only update the WM layout when menuView is actually attached.
        -- Calling updateViewLayout on a detached view (e.g. while iconView
        -- is shown) throws IllegalArgumentException and crashes Lua.
        if activeView == menuView then
            windowManager.updateViewLayout(menuView, mParams)
        end
    end

    activity.getWindow().getDecorView().setOnKeyListener(View.OnKeyListener{
        onKey = function(v, keyCode, event)
            if event.getAction() == MotionEvent.ACTION_UP and keyCode == KeyEvent.KEYCODE_BACK then
                if currentInputs and #currentInputs > 0 then
                    handleBackButton(); return true
                end
            end
            return false
        end
    })

    base.setOnTouchListener(View.OnTouchListener{
        onTouch = function(v, event)
            if event.getAction() == MotionEvent.ACTION_DOWN then
                local isTouchOnInput = false
                if currentInputs then
                    for _, edit in ipairs(currentInputs) do
                        local rect = Rect()
                        edit.getGlobalVisibleRect(rect)
                        if rect.contains(event.getRawX(), event.getRawY()) then
                            isTouchOnInput = true; break
                        end
                    end
                end
                if not isTouchOnInput then handleBackButton() end
            end
            return false
        end
    })
end

-- ─────────────────────────────────────────────
-- MENU VIEW  (expanded panel)
-- ─────────────────────────────────────────────

---Creates the full menu view - main UI panel with tabs, content, and header.
---Delegates every major section to a helper function so createMenuView itself
---stays shallow (few locals, few bytecodes) and never overflows the JVM stack.
---@return View The menu FrameLayout containing all UI elements
function createMenuView()
    LOG.info("createMenuView", "START | activity=" .. tostring(activity) .. " WIN_W=" .. tostring(WIN_W))

    local base = FrameLayout(activity)
    base.setLayoutParams(LayoutParams(-2, -2))

    local root   = _buildMenuRoot(base)
    _menuRoot = root
    _buildMenuHeader(root)
    local firstTab, firstTabId = _buildMenuTabs(root)
    local scroll = _buildMenuContent(root)
    _menuScroll = scroll

    -- Defer first-tab load so createMenuView() fully returns before
    -- addModule() closures are built. Loading synchronously here puts
    -- createMenuView + initUI + _safePcall frames on the stack at the
    -- same time as all the addModule closure allocations → StackOverflow.
    if firstTab and firstTabId then
        local _ftab, _ftabId = firstTab, firstTabId
        MainHandler.post(Runnable({ run = function()
            LOG.info("createMenuView", "deferred loadCategory: " .. tostring(_ftabId))
            loadCategory(_ftabId, _ftab)
        end }))
    end

    base.addView(root)
    menuView = base

    -- _setupMenuInteraction is deferred to a fresh MainHandler callback so it
    -- runs OUTSIDE the _safePcall Java frames that caused the StackOverflowError.
    MainHandler.post(Runnable({ run = function()
        LOG.info("createMenuView", "deferred: _setupMenuInteraction")
        _setupMenuInteraction(base)
    end }))

    return base
end

function initUI()
    -- No _safePcall wrappers here — the caller (MainHandler post in main.lua)
    -- already wraps this entire call in _safePcall. Extra layers keep Java
    -- frames on the stack throughout createMenuView's ~100 dp() calls → overflow.
    LOG.info("initUI", "START | WIN_W=" .. tostring(WIN_W) .. " WIN_H=" .. tostring(WIN_H) .. " SDK=" .. tostring(Build.VERSION.SDK_INT))

    windowManager = activity.getSystemService(Context.WINDOW_SERVICE)
    LOG.info("initUI", "windowManager acquired: " .. tostring(windowManager))

    mParams = LayoutParams(dp(WIN_W), dp(WIN_H + UI_CHROME_H), Build.VERSION.SDK_INT >= 26 and 2038 or 2002, 8, -3)
    mParams.gravity = Gravity.TOP | Gravity.LEFT
    mParams.x, mParams.y = 100, 200
    LOG.info("initUI", "mParams type=" .. tostring(Build.VERSION.SDK_INT >= 26 and 2038 or 2002))

    LOG.info("initUI", "calling createMenuView()")
    menuView = createMenuView()
    LOG.info("initUI", "menuView=" .. tostring(menuView))

    LOG.info("initUI", "calling createIconView()")
    iconView = createIconView()
    LOG.info("initUI", "iconView=" .. tostring(iconView))

    LOG.info("initUI", "calling switchToIcon()")
    switchToIcon()
    LOG.info("initUI", "DONE | menuView=" .. tostring(menuView) .. " iconView=" .. tostring(iconView) .. " activeView=" .. tostring(activeView))
end

end

local scriptDir = gg.getFile():match("(.*/)") or ""

function loadModule(name)
    local key = name:gsub("^%./", "")
    if not key:match("%.lua$") then key = key .. ".lua" end
    local vchunk = __vfs[key]
    if vchunk then return vchunk() end
    local path = scriptDir .. name
    local chunk, err = loadfile(path)
    if not chunk then
        gg.alert("VFS miss: " .. name .. "\n" .. tostring(err))
        os.exit()
    end
    return chunk()
end


-- ── MAIN ENTRYPOINT ──────────────────────────────────────────────────────


-- VOID v1 — HCR2 Modding Framework
-- Load order: env → imports → constants → core → arch+data → modules → ui → init → loop

do
    local LOG_TO_FILE = true
    local LOG_TO_TOAST = false
    local LOG_TO_PRINT = true
    local MAX_FILE_BYTES = 2 * 1024 * 1024

    local _logFile = (gg.getFile():match("(.*)/") or "/sdcard") .. "/void_debug.log"
    local _logBuf = {}
    local _lineCount = 0
    local _startTime = os.clock()
    local _indent = 0

    local function _ts()
        return ("%.3f"):format(os.clock() - _startTime)
    end

    local function _write(level, tag, msg)
        local prefix = string.rep("  ", _indent)
        local line = ("[%s] [%s] %s%s"):format(_ts(), level, prefix, tostring(msg))
        if tag and tag ~= "" then
            line = ("[%s] [%s] [%s] %s%s"):format(_ts(), level, tag, prefix, tostring(msg))
        end
        _lineCount = _lineCount + 1
        _logBuf[#_logBuf + 1] = line

        if LOG_TO_TOAST then
            pcall(gg.toast, line)
        end

        if LOG_TO_FILE and (#_logBuf >= 20 or level == "FATAL") then
            pcall(function()
                local f = io.open(_logFile, "a")
                if f then
                    for _, l in ipairs(_logBuf) do f:write(l, "\n") end
                    f:close()
                end
            end)
            _logBuf = {}
        end
    end

    LOG = {}

    function LOG.info(tag, msg) _write("INFO ", tag, msg) end
    function LOG.warn(tag, msg) _write("WARN ", tag, msg) end
    function LOG.error(tag, msg) _write("ERROR", tag, msg) end
    function LOG.fatal(tag, msg) _write("FATAL", tag, msg) end
    function LOG.dbg(tag, msg) _write("DEBUG", tag, msg) end

    function LOG.flush()
        if not LOG_TO_FILE or #_logBuf == 0 then return end
        pcall(function()
            local f = io.open(_logFile, "a")
            if f then
                for _, l in ipairs(_logBuf) do f:write(l, "\n") end
                f:close()
            end
        end)
        _logBuf = {}
    end

    function LOG.dump()
        LOG.flush()
        local recent = {}
        pcall(function()
            local f = io.open(_logFile, "r")
            if f then
                for line in f:lines() do
                    recent[#recent + 1] = line
                    if #recent > 60 then table.remove(recent, 1) end
                end
                f:close()
            end
        end)
        gg.alert("[VOID Logger] Last lines:\n" .. table.concat(recent, "\n"))
    end

    function LOG.try(tag, fn, ...)
        _indent = _indent + 1
        local ok, err = pcall(fn, ...)
        _indent = _indent - 1
        if not ok then
            LOG.error(tag, "pcall FAILED: " .. tostring(err))
            LOG.flush()
        end
        return ok, err
    end

    
    LOG.info("LOGGER", "══════ VOID Logger started ══════")
    LOG.info("LOGGER", "Log date: " .. os.date())
    LOG.info("LOGGER", "Log file: " .. _logFile)
    LOG.info("LOGGER", "Script started at t=0.001")

    _G.__rawLoadModule = nil
    
    _safePcall = pcall
end

local scriptDir = gg.getFile():match("(.*)/")

LOG.info("MAIN", "scriptDir resolved: " .. tostring(scriptDir))

loadModule("core/env.lua")

-- ── Java imports (global; available to all subsequently loaded modules) ──────

Build = import("android.os.Build")
Config = import("android.ext.Config")
Crypto = import("org.vekendian.Crypto")
MainService = import("android.ext.MainService")
rx = import("android.ext.rx")
Script = import("android.ext.Script")
Tools = import("android.ext.Tools")
Ui = import("org.vekendian.Ui")
Zip = import("org.vekendian.Zip")

ClipData = import("android.content.ClipData")
Color = import("android.graphics.Color")
Context = import("android.content.Context")
EditText = import("android.widget.EditText")
File = import("java.io.File")
FileOutputStream = import("java.io.FileOutputStream")
FrameLayout = import("android.widget.FrameLayout")
GradientDrawable = import("android.graphics.drawable.GradientDrawable")
Gravity = import("android.view.Gravity")
Handler = import("android.os.Handler")
HorizontalScrollView = import("android.widget.HorizontalScrollView")
InputType = import("android.text.InputType")
LayoutParams = import("android.view.WindowManager$LayoutParams")
LinearLayout = import("android.widget.LinearLayout")
LinLayoutParams = import("android.widget.LinearLayout$LayoutParams")
Looper = import("android.os.Looper")
MotionEvent = import("android.view.MotionEvent")
PasswordTransformationMethod = import("android.text.method.PasswordTransformationMethod")
Runnable = import("java.lang.Runnable")
ScrollView = import("android.widget.ScrollView")
SeekBar = import("android.widget.SeekBar")
TextWatcher = import("android.text.TextWatcher")
TextView = import("android.widget.TextView")
Thread = import("java.lang.Thread")
TruncateAt = luajava.bindClass("android.text.TextUtils$TruncateAt")
Typeface = import("android.graphics.Typeface")
TypedValue = import("android.util.TypedValue")
View = import("android.view.View")
WindowManager = import("android.view.WindowManager")
MainHandler = Handler(Looper.getMainLooper())


-- ── Constants ─────────────────────────────────────────────────────────────────

FORCE_EXIT = false
WIDTH = 300
CLICK_COOLDOWN = 500
DEVICE_ARCH = "unknown"
DEFAULT_ARCH = "arm64-v8a"

UI = loadModule("configs/colors.lua")

-- ── Global state ──────────────────────────────────────────────────────────────

exit = false
WIN_W = nil    -- resolved after memory loads (see below)
WIN_H = nil    -- resolved after memory loads (see below)
loader = nil
menuView = nil
iconView = nil
activeView = nil
windowManager = nil
mParams = nil
moduleContainer = nil
activeTabView = nil
activeSpinner = nil
BaseGameStatus = nil
BaseRegion = nil
BaseLib = nil
toggleStates = {}
inputStates = {}
spinnerStates = {}
sliderStates = {}
processingStates = {}
lastClickTimes = {}
RO_Fields = {}


-- ── UI utilities (global; needed by modules before ui.lua loads) ──────────────

-- Cache density once so dp() is a pure Lua multiply — no Java call per use.
-- createMenuView calls dp() ~100 times; each Java crossing burns stack space.
local _dpDensity = nil
function dp(v)
    if not _dpDensity then
        _dpDensity = activity.getResources().getDisplayMetrics().density
        LOG.info("dp", "density cached: " .. tostring(_dpDensity))
    end
    return math.floor(v * _dpDensity + 0.5)
end

function getSkin(color, radius, strokeW, strokeC)
    local d = GradientDrawable()
    d.setColor(color)
    d.setCornerRadius(dp(radius))
    if strokeW and strokeC then d.setStroke(dp(strokeW), strokeC) end
    return d
end

function showToast(msg, fast) Tools.a(msg, fast and 0 or 1) end

function showDialog(title, msg, pos, neg, neu)
    local ctx = Tools.e()
    if not ctx then return 0 end
    local function wrap(b)
        if type(b) == "table"  then return {tostring(b[1])}
        elseif type(b) == "string" then return {b} end
    end
    local r = Ui.showDialog(ctx, title or "", msg or "", wrap(pos), wrap(neg), wrap(neu))
    local function fire(b) if type(b) == "table" and type(b[2]) == "function" then pcall(b[2]) end end
    if r == 1 then fire(pos) elseif r == 2 then fire(neg) elseif r == 3 then fire(neu) end
    return r
end

function switchToMenu()
    LOG.info("switchToMenu", "called | activeView=" .. tostring(activeView) .. " menuView=" .. tostring(menuView) .. " iconView=" .. tostring(iconView))
    MainHandler.post(function()
        LOG.info("switchToMenu", "MainHandler running")
        if activeView == menuView then
            LOG.warn("switchToMenu", "EARLY RETURN — activeView is already menuView")
            return
        end
        if iconView and activeView == iconView then
            LOG.info("switchToMenu", "removing iconView from windowManager")
            pcall(function() iconView.setAlpha(0); windowManager.removeView(iconView) end)
        end
        LOG.info("switchToMenu", "attempting windowManager.addView(menuView) | menuView=" .. tostring(menuView) .. " mParams=" .. tostring(mParams) .. " windowManager=" .. tostring(windowManager))
        local ok, err = _safePcall(function()
            -- Restore full menu height (was set to -2 for the icon pill).
            mParams.height = dp(WIN_H + UI_CHROME_H)
            menuView.setAlpha(0.0); menuView.setScaleX(0.9); menuView.setScaleY(0.9)
            windowManager.addView(menuView, mParams); activeView = menuView
            menuView.animate().alpha(1.0).scaleX(1.0).scaleY(1.0).setDuration(200).start()
        end)
        if not ok then
            LOG.fatal("switchToMenu", "addView FAILED: " .. tostring(err))
            LOG.flush()
        else
            LOG.info("switchToMenu", "menuView added OK | activeView=" .. tostring(activeView))
        end
    end)
end

function switchToIcon()
    LOG.info("switchToIcon", "called | activeView=" .. tostring(activeView) .. " iconView=" .. tostring(iconView) .. " menuView=" .. tostring(menuView))
    MainHandler.post(function()
        LOG.info("switchToIcon", "MainHandler running")
        if activeView == iconView then
            LOG.warn("switchToIcon", "EARLY RETURN — activeView is already iconView")
            return
        end
        local imm = activity:getSystemService(Context.INPUT_METHOD_SERVICE)
        if menuView then pcall(function() imm.hideSoftInputFromWindow(menuView.getWindowToken(), 0) end) end
        mParams.flags = 8 | 32
        LOG.info("switchToIcon", "mParams.flags set to 8|32 | mParams=" .. tostring(mParams))
        if menuView and activeView == menuView then
            LOG.info("switchToIcon", "removing menuView (no animation) | menuView=" .. tostring(menuView))
            pcall(function() windowManager.removeView(menuView) end)
        end
        LOG.info("switchToIcon", "attempting windowManager.addView(iconView) | iconView=" .. tostring(iconView))
        local ok, err = _safePcall(function()
            -- Use WRAP_CONTENT height for the icon pill; the full menu height
            -- is restored in switchToMenu before menuView is added back.
            mParams.height = -2
            iconView.setAlpha(0.0); windowManager.addView(iconView, mParams); activeView = iconView
            iconView.animate().alpha(1.0).setDuration(180).start()
        end)
        if not ok then
            LOG.fatal("switchToIcon", "addView(iconView) FAILED: " .. tostring(err))
            LOG.flush()
        else
            LOG.info("switchToIcon", "iconView added OK | activeView=" .. tostring(activeView))
        end
    end)
end

function exitScript()
    local pending = scheduler:getQueueCount() or 0
    if pending > 0 or scheduler:isProcessing() then
        showDialog("Warning: Active Operations",
        ("There are %d background task(s) running.\nForce exit may corrupt game state."):format(pending),
        {"Wait (Safe)", function() showToast("Waiting...") end},
        {"Force Exit", function()
        if activeView then pcall(function() windowManager.removeView(activeView) end) end
            exit = true
        end})
    else
        if activeView then pcall(function() windowManager.removeView(activeView) end) end
        exit = true
    end
end

function isARM64() return DEVICE_ARCH == "arm64-v8a" end


-- ── Core modules ──────────────────────────────────────────────────────────────

json = loadModule("core/json.lua")
memory = loadModule("core/memory.lua")
scheduler = loadModule("core/scheduler.lua")
loader = loadModule("core/loader.lua")

-- Window size preferences (persisted globally across restarts)
-- WIN_W : panel width in dp  (default = WIDTH = 300)
-- WIN_H : scroll-area height in dp  (default = 220)
do
    local prefs = memory:loadGlobal("window_size")
    WIN_W = (prefs and prefs.w) or WIDTH
    WIN_H = (prefs and prefs.h) or 220
end
loadModule("core/patches.lua")

-- Detects arch, loads matching data from manifest → sets globals: aobs, offsets
loadModule("core/arch.lua")

-- Lazy tab registry → returns {tabHandlers, categoryHandlers}
tabHandlers, categoryHandlers = loadModule("modules/registry.lua")

loadModule("ui/ui.lua")


-- ── Process attachment ────────────────────────────────────────────────────────

local PKG = "com.fingersoft.hcr2"
gg.setVisible(false)
showToast("Initializing...", true)

local targetInfo = gg.getTargetInfo()
if not targetInfo then gg.alert("No app found"); os.exit() end
if not targetInfo.x64 then
    showDialog("64-bit Required", "ARMv8a is mandatory. x86_64 is partially supported.")
    os.exit()
end

if Config.E ~= "com.waxmoon.ma.gp" and Config.vSpaceReal then
    local r = gg.alert(
        ("Unsupported VM: %s (%s)\nOnly Multi App Ultra is supported."):format(tostring(Config.F), tostring(Config.E)),
        "Exit", "", "Download Now")
    if r == 3 then gg.gotoBrowser("https://vekendian.org/") end
    os.exit()
end

local function attachToProcess(pkg)
    gg.showUiButton()
    local t, warned = 0, false
    while gg.getTargetPackage() ~= pkg do
        if gg.isVisible() and not warned then
            gg.alert('Click "Sx" to stop'); warned = true
        end
        if gg.isClickedUiButton() then gg.hideUiButton(); return false end
        t = t + 1
        if t % 7 == 0 then showToast("Waiting for " .. pkg .. "...") end
        gg.setProcess(pkg); gg.sleep(500)
    end
    gg.hideUiButton(); return true
end

if targetInfo.packageName ~= PKG then
    if not attachToProcess(PKG) then showToast("Cancelled"); os.exit() end
end

local function awaitLib(lib)
    local t = 0
    while #gg.getRangesList(lib) == 0 do
        t = t + 1
        if t % 7 == 0 then showToast("Waiting for " .. lib .. "...") end
        gg.sleep(500)
        if t > 120 then return false end
    end
    return true
end

if not awaitLib("libcocos2dcpp.so") then os.exit() end


-- ── GameStatus resolution ─────────────────────────────────────────────────────

local regions = { gg.REGION_C_ALLOC, gg.REGION_OTHER }
local saved = memory:load("gamestatus")

shellStates = memory:load("shell_states") or {root=false}
toggleStates = memory:load("toggle_states") or {}
inputStates = memory:load("input_states") or {}
spinnerStates = memory:load("spinner_states") or {}
sliderStates = memory:load("slider_states") or {}

if saved then
    BaseRegion, BaseGameStatus = saved[1], saved[2]
else
    for _, region in ipairs(regions) do
        gg.clearResults(); gg.setRanges(region)
        gg.searchNumber("h 73 74 61 72 74 75 70 5F 63 6F 75 6E 74", gg.TYPE_BYTE)
        gg.refineNumber("h 73", gg.TYPE_BYTE)
        local res = gg.getResults(gg.getResultsCount())
        gg.clearResults()
        local hits = {}
        for _, d in ipairs(res) do
            local ptr = gg.getValues({{ address = d.address + 0x1F, flags = gg.TYPE_QWORD }})[1]
            if ptr and ptr.value ~= 0 then
                local ver = gg.getValues({{ address = ptr.value + 0x10, flags = gg.TYPE_DWORD }})[1]
                local v = ver and tonumber(ver.value)
                if v == 65792 or v == 65793 or v == 16843008 or v == 16843009 then
                    local tp = gg.getValues({{ address = ptr.value + 0x80, flags = gg.TYPE_QWORD }})[1]
                    if tp and tp.value ~= 0 then
                        local td = gg.getValues({{ address = tp.value, flags = gg.TYPE_DWORD }})[1]
                        if td then table.insert(hits, td.address) end
                    end
                end
            end
        end
        if #hits > 0 then
            BaseRegion, BaseGameStatus = region, hits[1]
            memory:save("gamestatus", { region, hits[1] })
            break
        end
    end
end

showToast("Initialized", true)
LOG.info("INIT", "Initialized | BaseGameStatus=" .. tostring(BaseGameStatus) .. " BaseRegion=" .. tostring(BaseRegion))

if BaseGameStatus == nil or BaseRegion == nil then
    LOG.fatal("INIT", "BaseGameStatus or BaseRegion is NIL — floating menu will NOT appear!")
    LOG.flush()
    showToast("GameStatus Not Found"); exit = true
else
    LOG.info("INIT", "BaseGameStatus OK=" .. tostring(BaseGameStatus) .. " | scheduling initUI() via MainHandler")
    
    local savedc = memory:loadGlobal("ui_prefs")
    if savedc then
        LOG.info("INIT", "User preferences RE-APPLIED")
        for k, v in pairs(savedc) do
            if UI[k] ~= nil then UI[k] = v end
        end
    end
    
    MainHandler.post(function()
        LOG.info("INIT", "MainHandler: calling initUI()")
        local ok, err = _safePcall(function() initUI() end)
        if not ok then
            LOG.fatal("INIT", "initUI() CRASHED: " .. tostring(err))
            LOG.flush()
        else
            LOG.info("INIT", "initUI() completed | menuView=" .. tostring(menuView) .. " iconView=" .. tostring(iconView) .. " activeView=" .. tostring(activeView))
        end
    end)
end

LOG.info("INIT", "activeView check before switchToIcon: activeView=" .. tostring(activeView))
if activeView == nil then
    LOG.warn("INIT", "activeView is nil — calling switchToIcon() as fallback")
    switchToIcon()
end


-- ── Main loop ─────────────────────────────────────────────────────────────────
LOG.info("MAIN", "Entering main loop | exit=" .. tostring(exit) .. " activeView=" .. tostring(activeView))
LOG.flush()

while not exit do
    local ok, err = pcall(function()
        if gg.isVisible(true) then gg.setVisible(false); gg.toast("Don't interrupt this script") end
        if FORCE_EXIT then exitScript() end
        gg.sleep(100)
    end)
    if not ok then
        LOG.fatal("MAIN", "Main loop crashed: " .. tostring(err))
        LOG.flush()
        exitScript()
        break
    end
end
