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

function loadModule(name)
    local path = scriptDir .. "/" .. name
    LOG.info("loadModule", "-> loading: " .. name)
    local chunk, err = loadfile(path)
    if not chunk then
        LOG.fatal("loadModule", "FAILED: " .. name .. " | " .. tostring(err))
        LOG.flush()
        gg.alert("Load failed: " .. name .. "\n" .. tostring(err)); os.exit()
    end
    local results = table.pack(_safePcall(chunk))
    local ok = results[1]
    if not ok then
        local err = results[2]
        LOG.fatal("loadModule", "RUNTIME ERROR in: " .. name .. " | " .. tostring(err))
        LOG.flush()
        gg.alert("Runtime error in: " .. name .. "\n" .. tostring(err)); os.exit()
    end
    LOG.info("loadModule", "OK loaded: " .. name .. " | returns=" .. tostring(results.n - 1))
    return table.unpack(results, 2, results.n)
end

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
WIDTH = 480
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
BaseGameStatusRaw = nil
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

cast = loadModule("core/cast.lua")
json = loadModule("core/json.lua")
memory = loadModule("core/memory.lua")
scheduler = loadModule("core/scheduler.lua")
loader = loadModule("core/loader.lua")

-- Window size preferences (persisted globally across restarts)
-- WIN_W : panel width in dp
-- WIN_H : scroll-area height in dp 
do
    local prefs = memory:loadGlobal("window_size")
    WIN_W = (prefs and prefs.w) or WIDTH
    WIN_H = (prefs and prefs.h) or 333
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

function readString(addr, maxLen)
    maxLen = maxLen or 64
    local reads = {}
    for i = 0, maxLen - 1 do
        table.insert(reads, { address = addr + i, flags = 1 })
    end
    local result = gg.getValues(reads)
    local bytes = {}
    for _, v in ipairs(result) do
        if v.value == 0 then break end
        local b = v.value < 0 and v.value + 256 or v.value
        table.insert(bytes, string.char(b))
    end
    return table.concat(bytes)
end

-- ── GameStatus resolution ─────────────────────────────────────────────────────

local regions = { gg.REGION_C_ALLOC, gg.REGION_OTHER }
local saved = memory:load("gamestatus")

shellStates = memory:load("shell_states") or {root=false}
toggleStates = memory:load("toggle_states") or {}
inputStates = memory:load("input_states") or {}
spinnerStates = memory:load("spinner_states") or {}
sliderStates = memory:load("slider_states") or {}

if saved then
    BaseRegion, BaseGameStatus, BaseGameStatusRaw = saved[1], saved[2], saved[3]
else
    for _, region in ipairs(regions) do
        gg.clearResults(); gg.setRanges(region)
        gg.searchNumber("h 73 74 61 72 74 75 70 5F 63 6F 75 6E 74", gg.TYPE_BYTE)
        gg.refineNumber("h 73", gg.TYPE_BYTE)
        local res = gg.getResults(gg.getResultsCount())
        gg.clearResults()
        local hits = {}
        local raw_hits = {}
        for _, d in ipairs(res) do
            local ptr = gg.getValues({{ address = d.address + 0x1F, flags = gg.TYPE_QWORD }})[1]
            if ptr and ptr.value ~= 0 then
                local ver = gg.getValues({{ address = ptr.value + 0x10, flags = gg.TYPE_DWORD }})[1]
                local v = ver and tonumber(ver.value)
                if v == 65792 or v == 65793 or v == 16843008 or v == 16843009 then
                    table.insert(raw_hits, ver.address)
                    local tp = gg.getValues({{ address = ptr.value + 0x80, flags = gg.TYPE_QWORD }})[1]
                    if tp and tp.value ~= 0 then
                        local td = gg.getValues({{ address = tp.value, flags = gg.TYPE_DWORD }})[1]
                        if td then table.insert(hits, td.address) end
                    end
                end
            end
        end
        if #hits > 0 then
            BaseRegion, BaseGameStatus, BaseGameStatusRaw = region, hits[1], raw_hits[1]
            memory:save("gamestatus", { region, hits[1], raw_hits[1] })
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
