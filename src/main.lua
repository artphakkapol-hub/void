--[[
  VOID - Hill Climb Racing 2 Script
  Main entry point and initialization module
  
  Load order: core/json → core/memory → core/patches → modules/init → ui/ui → initUI
  
  Dependencies: GameGuardian, LuaJava, Android API 21+, GG: ME by Vekendian
]]


---Displays an error message and exits the script.
---Shows alert with context about the error and offers option to copy website URL.
---@param msg string Error message to display
---@return nil
local function fail(msg)
    if gg.alert("Environment verification failed!\n\n" .. msg .. "\n\n\nPlease use GG: ME by Vekendian to ensure it is synced with Void", "Get GG: ME", "OK") == 1 then gg.copyText("vekendian.org") end
    os.exit()
end

if type(luajava) ~= "table" then fail("LuaJava not detected.") end
if type(import) ~= "function" then fail("import() function not available.") end

local okJava = pcall(function() import("java.lang.String") end)
if not okJava then fail("Core Java classes unavailable.") end

local okAndroid = pcall(function() import("android.os.Build") end)
if not okAndroid then fail("Android API not available.") end

do
    local VERSION = import("android.os.Build$VERSION")
    if VERSION.SDK_INT < 21 then
        fail("Android version too old.\nRequired: Android 5.0+ (API 21)\nDetected API: " .. tostring(VERSION.SDK_INT))
    end
end

local requiredClasses = {
    "android.ext.Tools", "android.ext.rx", "android.ext.Script",
    "android.ext.Config", "android.ext.MainService", "android.ext.Tools",
    "org.vekendian.Crypto", "org.vekendian.Ui", "org.vekendian.Zip"
    
}
local missing = {}
for _, cls in ipairs(requiredClasses) do
    if not pcall(function() luajava.bindClass(cls) end) then table.insert(missing, cls) end
end
if #missing > 0 then fail("Missing required classes:\n" .. table.concat(missing, "\n")) end

local scriptDir = gg.getFile():match("(.*/)")
---Loads and executes a Lua module file.
---@param name string Relative path to module (e.g. "core/json.lua")
---@return any Return value of the loaded module
function loadModule(name)
    local path = scriptDir .. name
    local chunk, err = loadfile(path)
    if not chunk then
        gg.alert("Failed to load " .. name .. ":\n" .. tostring(err))
        os.exit()
    end
    return chunk()
end


--[[================================
  ANDROID IMPORTS (Global references)
  Required classes bound from Java via LuaJava
  Available to all loaded modules
==================================]]

-- Vekendian custom classes
Build = import("android.os.Build")
Crypto = import("org.vekendian.Crypto")
Config = import("android.ext.Config")
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
FrameLayout = import("android.widget.FrameLayout")
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
ScrollView = import("android.widget.ScrollView")
SeekBar = import("android.widget.SeekBar")
TextView = import("android.widget.TextView")
TextWatcher = import("android.text.TextWatcher")
Thread = import("java.lang.Thread")
TruncateAt = luajava.bindClass("android.text.TextUtils$TruncateAt")
TypedValue = import("android.util.TypedValue")
View = import("android.view.View")
WindowManager = import("android.view.WindowManager")
Typeface = import("android.graphics.Typeface")
File = import("java.io.File")
FileOutputStream = import("java.io.FileOutputStream")
GradientDrawable = import("android.graphics.drawable.GradientDrawable")
Runnable = import("java.lang.Runnable")
MainHandler = Handler(Looper.getMainLooper())


--[[================================
  GLOBAL CONSTANTS
==================================]]

---@type number Display width in dp (device-independent pixels)
WIDTH = 300
---@type number Minimum milliseconds between interactive clicks (debounce)
CLICK_COOLDOWN = 500
---@type string Current device CPU architecture (detected at runtime)
DEVICE_ARCH = "unknown"
---@type string Default architecture for patches (arm64-v8a)
DEFAULT_ARCH = "arm64-v8a"

---@type table Color palette for UI (ARGB format)
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


--[[================================
  GLOBAL STATE
==================================]]

---@type boolean Script exit flag
exit = false
---@type View Main menu view (LinearLayout)
menuView = nil
---@type View Floating icon view (minimal UI)
iconView = nil
---@type View Currently visible view (menuView or iconView)
activeView = nil
---@type object Android WindowManager instance
windowManager = nil
---@type object WindowManager layout parameters
mParams = nil
---@type View Container for module cards (ScrollView child)
moduleContainer = nil
---@type View Currently active tab view (TextView)
activeTabView = nil
---@type View Currently open dropdown spinner (if any)
activeSpinner = nil
---@type number Base game status structure address
BaseGameStatus = nil
---@type number Memory region ID where game status is located
BaseRegion = nil
---@type any Game library handle/base address
BaseLib = nil

---@type table UI state: toggle switches (id -> boolean)
toggleStates = {}
---@type table UI state: text inputs (id -> string|table)
inputStates = {}
---@type table UI state: dropdown selections (id -> index)
spinnerStates = {}
---@type table UI state: slider values (id -> number|table)
sliderStates = {}
---@type table Processing flags to prevent concurrent callbacks (id -> boolean)
processingStates = {}
---@type table Last click timestamps for cooldown tracking (id -> number)
lastClickTimes = {}
---@type table Read-only field views (id -> TextView)
RO_Fields = {}


--[[================================
  HELPER FUNCTIONS
==================================]]

---Converts device-independent pixels (dp) to screen pixels.
---@param v number Value in dp
---@return number Value in screen pixels
function dp(v)
    return math.floor(TypedValue.applyDimension(1, v, activity.getResources().getDisplayMetrics()))
end

---Creates a GradientDrawable with color, rounded corners, and optional stroke.
---@param color number ARGB color value
---@param radius number Corner radius in dp
---@param strokeWidth? number Stroke width in dp (optional)
---@param strokeColor? number Stroke color in ARGB (optional)
---@return object GradientDrawable configured with given parameters
function getSkin(color, radius, strokeWidth, strokeColor)
    local draw = GradientDrawable()
    draw.setColor(color)
    draw.setCornerRadius(dp(radius))
    if strokeWidth and strokeColor then draw.setStroke(dp(strokeWidth), strokeColor) end
    return draw
end

---Shows a dialog with up to 3 buttons and optional callbacks.
---Button structure: string for label only, or {label, callback_function}
---@param title string Dialog title
---@param message string Dialog message
---@param positive any Positive button (first button on left)
---@param negative? any Negative button (second button, optional)
---@param neutral? any Neutral button (third button, optional)
---@return number Button pressed (1=positive, 2=negative, 3=neutral)
function showDialog(title, message, positive, negative, neutral)
    local ctx = Tools.e()
    if not ctx then return 0 end
    local function btnStr(btn)
        if type(btn) == "table" then return {tostring(btn[1])}
        elseif type(btn) == "string" then return {btn} end
        return nil
    end
    local result = Ui.showDialog(ctx, title or "", message or "", btnStr(positive), btnStr(negative), btnStr(neutral))
    local function callCb(btn)
        if type(btn) == "table" and type(btn[2]) == "function" then pcall(btn[2]) end
    end
    if result == 1 then callCb(positive)
    elseif result == 2 then callCb(negative)
    elseif result == 3 then callCb(neutral) end
    return result
end

---Displays a toast notification message.
---@param message string Text to display
---@param fast boolean If true, show for 0.5s; if false, show for 1.5s
---@return nil
function showToast(message, fast)
    Tools.a(message, fast and 0 or 1)
end

---Switches UI from icon view to full menu view with animation.
---Hides the icon view if currently visible, then animates in the menu.
---@return nil
function switchToMenu()
    MainHandler.post(function()
        if activeView == menuView then return end

        if iconView and activeView == iconView then
            pcall(function() 
                iconView.setAlpha(0)
                windowManager.removeView(iconView) 
            end)
        end

        pcall(function()
            menuView.setAlpha(0.0)
            menuView.setScaleX(0.9)
            menuView.setScaleY(0.9)
            
            windowManager.addView(menuView, mParams)
            activeView = menuView

            menuView.animate()
                .alpha(1.0)
                .scaleX(1.0)
                .scaleY(1.0)
                .setDuration(200)
                .start()
        end)
    end)
end

---Switches UI from menu view to floating icon view with animation.
---Hides the menu and shows a minimal floating icon instead.
---@return nil
function switchToIcon()
    MainHandler.post(function()
        if activeView == iconView then return end
        
        local imm = activity:getSystemService(Context.INPUT_METHOD_SERVICE)
        if menuView then 
            pcall(function()
                imm.hideSoftInputFromWindow(menuView.getWindowToken(), 0)
            end)
        end

        mParams.flags = 8 | 32
        
        if menuView and activeView == menuView then
            pcall(function()
                menuView.animate()
                    .alpha(0.0)
                    .scaleX(0.9)
                    .scaleY(0.9)
                    .setDuration(150)
                    .withEndAction(Runnable({
                        run = function()
                            pcall(function() windowManager.removeView(menuView) end)
                        end
                    }))
                    .start()
            end)
        else
            pcall(function() windowManager.removeView(menuView) end)
        end

        -- Show icon
        pcall(function()
            iconView.setAlpha(0.0)
            windowManager.addView(iconView, mParams)
            activeView = iconView

            iconView.animate()
                .alpha(1.0)
                .setDuration(180)
                .start()
        end)
    end)
end

---Exits the script after checking for pending background tasks.
---Shows warning if tasks are still processing, offers safe wait or force exit.
---@return nil
function exitScript()
    MainHandler.post(function()
        local pendingCount = scheduler:getQueueCount() or 0
        local isProcessing = scheduler:isProcessing() and scheduler:isProcessing() or false

        if pendingCount > 0 or isProcessing then
            showDialog(
                "Warning: Active Operations",
                string.format("There are still %d background task(s) processing.\nExiting now could corrupt game states or saves.\n\nDo you want to force exit?", pendingCount),
                {"Wait (Safe)", function()
                    gg.toast("Waiting for tasks to finish...")
                end},
                {"Force Exit", function()
                    if activeView then pcall(function() windowManager.removeView(activeView) end) end
                    exit = true
                end}
            )
        else
            if activeView then pcall(function() windowManager.removeView(activeView) end) end
            exit = true
        end
    end)
end


---Checks if current device is ARM64 (arm64-v8a architecture).
---@return boolean True if running on ARM64, false otherwise
function isARM64()
    return DEVICE_ARCH == "arm64-v8a"
end


--[[================================
  MODULE LOADING & INITIALIZATION
==================================]]
json = loadModule("core/json.lua")
memory = loadModule("core/memory.lua")
scheduler = loadModule("core/scheduler.lua")
loadModule("core/patches.lua")
tabHandlers, categoryHandlers = loadModule("modules/init.lua")
loadModule("ui/ui.lua")


-- initializer
local pkgName = "com.fingersoft.hcr2"
local pkgVersion = "1.73.0"
gg.setVisible(false)
showToast("Initializing...", true)

local targetInfo = gg.getTargetInfo()
if not targetInfo then gg.alert("No app found") os.exit() end
if not targetInfo.x64 then
    showDialog("64-bit Required", "ARMv8a is mandatory for this script, Also support x86_64 but limited.")
    os.exit()
end

if Config.E ~= "com.waxmoon.ma.gp" and Config.vSpaceReal then
    local message = string.format(
        "Unsupported VM detected\n%s (%s)\n\nThis script only supports:\nMulti App Ultra (com.waxmoon.ma.gp)",
        tostring(Config.F), tostring(Config.E)
    )
    local userChoice = gg.alert(message, "Exit Script", "", "Download Now")
    if userChoice == 3 then gg.gotoBrowser("https://vekendian.org/") end
    os.exit()
end

---Waits for the target package to be attached in GameGuardian.
---Shows UI button and periodic toasts while waiting. Returns false if interrupted.
---@param pkg string Target package name (e.g. "com.fingersoft.hcr2")
---@return boolean True if successfully attached, false if interrupted
local function attachToProcess(pkg)
    gg.showUiButton()
    local counter = 0
    local onlyShowOnceState = true
    while gg.getTargetPackage() ~= pkg do
        if gg.isVisible() and onlyShowOnceState then gg.alert("Click the \"Sx\" button to stop this script or interrupt it"); onlyShowOnceState = false end
        if gg.isClickedUiButton() then gg.hideUiButton(); return false end
        counter = counter + 1
        if counter % 7 == 0 then showToast("Waiting for " .. pkg .. "...") end
        gg.setProcess(pkg)
        gg.sleep(500)
    end
    gg.hideUiButton()
    return true
end

if targetInfo.packageName ~= pkgName then
    if not attachToProcess(pkgName) then
        showToast("Execution cancelled")
        os.exit()
    end
end

---Checks if a library is loaded in the target process.
---Waits up to 50 seconds with periodic toasts if library not found.
---@param libName string Library name (e.g. "libcocos2dcpp.so")
---@return boolean True if library loaded, false if timeout
local function isLibLoaded(libName)
    local counter = 0
    while #gg.getRangesList(libName) == 0 do
        counter = counter + 1
        if counter % 7 == 0 then showToast("Waiting for " .. libName .. " being loaded ...") end
        gg.sleep(500)
        if counter > 120 then return false end
    end
    return true
end

---Detects the device CPU architecture by checking ELF header in libcocos2dcpp.so.
---Maps ELF machine type to architecture string (arm64-v8a, x86_64, armeabi-v7a, x86).
---@return string Detected architecture ("arm64-v8a", "x86_64", "armeabi-v7a", "x86", or "unknown")
local function getArch()
    local ranges = gg.getRangesList("libcocos2dcpp.so")
    if #ranges == 0 then return nil end
    local checkArch = gg.getValues({{
        address = ranges[1].start + 0x10,
        flags = gg.TYPE_DWORD
    }})[1].value
    local archMap = {
        [11993091] = "arm64-v8a",
        [4063235] = "x86_64",
        [2621443] = "armeabi-v7a",
        [196611] = "x86"
    }
    DEVICE_ARCH = archMap[checkArch] or "unknown"
    return DEVICE_ARCH
end

if not isLibLoaded("libcocos2dcpp.so") then os.exit() end
if getArch() ~= "arm64-v8a" then
    showDialog("Warning", "Your Architecture is " .. DEVICE_ARCH .. ".\nsome (could be all) lib-patches will not work on this Architecture.", "Proceed Anyway")
end

if targetInfo.versionName ~= pkgVersion then
    showDialog("Warning", "This script made for HCR2 " .. pkgVersion .. ", But your HCR2 is " .. targetInfo.versionName .. ", Some features may not work!", "Proceed Anyway")
end

local gamestatus = memory:load("gamestatus")
local region = { gg.REGION_C_ALLOC, gg.REGION_OTHER }

toggleStates = memory:load("toggle_states")  or {}
inputStates = memory:load("input_states")   or {}
spinnerStates = memory:load("spinner_states") or {}
sliderStates = memory:load("slider_states")  or {}

if gamestatus then
    BaseRegion = gamestatus[1]
    BaseGameStatus = gamestatus[2]
else
    for i = 1, #region do
        gg.clearResults()
        gg.setRanges(region[i])
        gg.searchNumber("h 73 74 61 72 74 75 70 5F 63 6F 75 6E 74", gg.TYPE_BYTE)
        gg.refineNumber("h 73", gg.TYPE_BYTE)

        local count = gg.getResultsCount()
        if count > 0 then
            local res = gg.getResults(count)
            gg.clearResults()
            local final = {}

            for _, data in ipairs(res) do
                local ok = true
                local ptrData = gg.getValues({{ address = data.address + 0x1F, flags = gg.TYPE_QWORD }})[1]
                if not ptrData or not ptrData.value or ptrData.value == 0 then ok = false end

                if ok then
                    local getPtr = ptrData.value
                    local verifyData = gg.getValues({{ address = getPtr + 0x10, flags = gg.TYPE_DWORD }})[1]
                    if not verifyData or not verifyData.value then
                        ok = false
                    else
                        local verify = tonumber(verifyData.value)
                        if verify ~= 65792 and verify ~= 65793
                            and verify ~= 16843008 and verify ~= 16843009 then
                            ok = false
                        end
                    end

                    if ok then
                        local targetPtrData = gg.getValues({{ address = getPtr + 0x80, flags = gg.TYPE_QWORD }})[1]
                        if not targetPtrData or not targetPtrData.value or targetPtrData.value == 0 then
                            ok = false
                        else
                            local targetData = gg.getValues({{ address = targetPtrData.value, flags = gg.TYPE_DWORD }})[1]
                            if targetData then table.insert(final, targetData.address) end
                        end
                    end
                end
            end

            if #final > 0 then
                BaseRegion     = region[i]
                BaseGameStatus = final[1]
                memory:save("gamestatus", {BaseRegion, BaseGameStatus})
                break
            end
        else
            gg.clearResults()
        end
    end
end

showToast("Initialized", true)
if BaseGameStatus == nil or BaseRegion == nil then
    showToast("GameStatus Not Found")
    exit = true
else
    MainHandler.post(function() initUI() end)
end

if activeView == nil then switchToIcon() end


-- looper
while true do
    if exit then break end
    if gg.isVisible(true) then
        gg.setVisible(false)
        gg.toast("Please don't interrupt this script")
    end
    gg.sleep(100)
end
