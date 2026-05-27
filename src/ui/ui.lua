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
    if not moduleContainer or not tabView then return end

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
--- - "spinner": Dropdown selector (state saved)
--- - "slider": Single or multi-slider input (state saved)
--- - "input": Single or multi-line text input (state saved)
---
---@param parent View Container to add card to
---@param id string Unique module identifier
---@param title string Display title
---@param desc string Description text
---@param mode string Module type: "switch" | "button" | "ro" | "spinner" | "slider" | "input"
---@param extra any Mode-specific data (options, config, etc.)
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

---@type table Animation frames with text and color pairs for glitch effect
local GLITCH_FRAMES = {
    {"VOID",  UI.LOGO},
    {"V0ID",  UI.GLOW},
    {"VO1D",  UI.LOGO},
    {"VØĪD",  UI.GLOW},
    {"VŌ1D",  UI.TEXT},
    {"V0ID",  UI.GLOW},
    {"VOID",  UI.LOGO},
    {"XXXX",  UI.GLOW},
    {"VOID",  UI.LOGO}
}

---Starts an animated glitch effect on a TextView with title animation.
---Alternates between normal and glitched text periodically.
---@param textView View The TextView to animate
---@return nil
local function startGlitchLoop(textView)
    local frame   = 1
    local ticks   = 0
    local NORMAL_HOLD = 2.5
    local GLITCH_HOLD = 2
    local inGlitch = false
    local glitchCount = 0

    local function tick()
        if not textView then return end
        ticks = ticks + 1

        if not inGlitch then
            if ticks >= NORMAL_HOLD then
                ticks     = 0
                inGlitch  = true
                glitchCount = math.random(3, 6)
                frame     = 2
            end
            
            textView.setText(GLITCH_FRAMES[1][1])
            textView.setTextColor(GLITCH_FRAMES[1][2])
        else
            textView.setText(GLITCH_FRAMES[frame][1])
            textView.setTextColor(GLITCH_FRAMES[frame][2])
            ticks = ticks + 1
            if ticks >= GLITCH_HOLD then
                ticks  = 0
                frame  = (frame % (#GLITCH_FRAMES - 1)) + 2 
                glitchCount = glitchCount - 1
                if glitchCount <= 0 then
                    inGlitch = false
                    frame    = 1
                end
            end
        end

        MainHandler.postDelayed(Runnable({ run = tick }), 150)
    end

    MainHandler.postDelayed(Runnable({ run = tick }), 500)
end

-- ─────────────────────────────────────────────
-- ICON VIEW (Collapsed Floating Pill)
-- ─────────────────────────────────────────────

---Creates the floating icon view - a minimal draggable pill when menu is minimized.
---Displays title, version, and exit button. Tappable to expand menu.
---@return View The icon view LinearLayout
function createIconView()
    local iconRoot = LinearLayout(activity)
    iconRoot.setOrientation(0)
    iconRoot.setGravity(Gravity.BOTTOM)
    iconRoot.setBackground(getSkin(UI.HEADER, 16))
    iconRoot.setPadding(dp(15), dp(10), dp(10), dp(10))
    
    local params = LinLayoutParams(dp(WIDTH - 40), -2)
    iconRoot.setLayoutParams(params)
    
    -- Title
    local title = TextView(activity)
    title.setText("VOID")
    title.setTextColor(UI.LOGO)
    title.setTextSize(1, 15)
    title.setTypeface(Typeface.create("sans-serif-black", Typeface.BOLD))
    iconRoot.addView(title)

    startGlitchLoop(title)

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
function createMenuView()
    local base = FrameLayout(activity)
    base.setLayoutParams(LayoutParams(-2, -2))

    local root = LinearLayout(activity)
    root.setOrientation(1)
    root.setBackground(getSkin(UI.BG, 16, 2, UI.STROKE))
    root.setLayoutParams(FrameLayout.LayoutParams(dp(WIDTH), -2))
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

    -- header
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

    startGlitchLoop(title)

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
    
    local sx, sy, lx, ly
    local touchStartTime = 0
    
    headerGroup.setOnTouchListener(View.OnTouchListener({
        onTouch = function(v, ev)
            local action = ev.getAction()
            
            if action == MotionEvent.ACTION_DOWN then
                sx = ev.getRawX()
                sy = ev.getRawY()
                lx = mParams.x
                ly = mParams.y
                touchStartTime = os.clock() * 1000
                return true
                
            elseif action == MotionEvent.ACTION_MOVE then
                mParams.x = lx + (ev.getRawX() - sx)
                mParams.y = ly + (ev.getRawY() - sy)
                windowManager.updateViewLayout(menuView, mParams)
                return true
                
            elseif action == MotionEvent.ACTION_UP then
                local touchDuration = (os.clock() * 1000) - touchStartTime
                local moveDistance = math.abs(ev.getRawX() - sx) + math.abs(ev.getRawY() - sy)
                
                if touchDuration < 300 and moveDistance < 20 then
                    switchToIcon()
                    return true
                end
            end

            return false
        end
    }))

    local function addHeaderBtn(txt, color, click)
        local b = TextView(activity)
        b.setText(txt)
        b.setTextColor(color)
        b.setTextSize(1, 16)
        b.setPadding(dp(10), dp(0), dp(5), dp(0))
        b.setTypeface(Typeface.DEFAULT_BOLD)
        b.setOnClickListener(View.OnClickListener({
            onClick = function()
                Thread(Runnable({ run = function() pcall(click) end })).start()
            end
        }))
        headerGroup.addView(b)
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
    root.addView(headerGroup)

    -- tab bar
    local tabScroll = HorizontalScrollView(activity)
    tabScroll.setHorizontalScrollBarEnabled(false)
    tabScroll.setPadding(dp(15), dp(15), dp(15), dp(5))

    local tabLayout = LinearLayout(activity)
    tabLayout.setOrientation(0)
    tabScroll.addView(tabLayout)
    root.addView(tabScroll)

    local firstTab   = nil
    local firstTabId = nil

    local menuList = tabHandlers or {{"unknown", "unknown"}}
    for i, m in ipairs(menuList) do
        local t = addTab(tabLayout, m[1], m[2])
        if i == 1 then
            firstTab   = t
            firstTabId = m[1]
        end
    end

    -- content scroll
    local scroll = ScrollView(activity)
    scroll.setLayoutParams(LinLayoutParams(-1, dp(220)))
    scroll.setVerticalScrollBarEnabled(false)
    scroll.setPadding(dp(15), dp(10), dp(15), dp(15))

    moduleContainer = LinearLayout(activity)
    moduleContainer.setOrientation(1)
    scroll.addView(moduleContainer)
    root.addView(scroll)

    if firstTab and firstTabId then
        loadCategory(firstTabId, firstTab)
    end

    base.addView(root)
    menuView = base
    
    local function handleBackButton()
        local imm = activity.getSystemService(Context.INPUT_METHOD_SERVICE)
    
        if menuView then
            imm.hideSoftInputFromWindow(menuView.getWindowToken(), 0)
        end
    
        if currentInputs then
            for _, edit in ipairs(currentInputs) do
                edit.clearFocus()
            end
        end
    
        mParams.flags = 8 | 32
        windowManager.updateViewLayout(menuView, mParams)
    end

    activity.getWindow().getDecorView().setOnKeyListener(View.OnKeyListener{
        onKey = function(v, keyCode, event)
            if event.getAction() == MotionEvent.ACTION_UP and keyCode == KeyEvent.KEYCODE_BACK then
                if currentInputs and #currentInputs > 0 then
                    handleBackButton()
                    return true  -- block default back behavior
                end
            end
            return false
        end
    })
    
    menuView.setOnTouchListener(View.OnTouchListener{
        onTouch = function(v, event)
            if event.getAction() == MotionEvent.ACTION_DOWN then
                local isTouchOnInput = false
                
                if currentInputs then
                    for _, edit in ipairs(currentInputs) do
                        local rect = Rect()
                        edit.getGlobalVisibleRect(rect)
                        if rect.contains(event.getRawX(), event.getRawY()) then
                            isTouchOnInput = true
                            break
                        end
                    end
                end

                if not isTouchOnInput then
                    handleBackButton()   -- reuse the same function
                end
            end
            return false
        end
    })

    return base
end

-- ─────────────────────────────────────────────
-- INIT
-- ─────────────────────────────────────────────

---Initializes the entire UI system.
---Sets up WindowManager, creates menu and icon views, and starts with icon view visible.
---@return nil
function initUI()
    windowManager = activity.getSystemService(Context.WINDOW_SERVICE)
    mParams = LayoutParams(dp(WIDTH), -2, Build.VERSION.SDK_INT >= 26 and 2038 or 2002, 8, -3)
    mParams.gravity = Gravity.TOP | Gravity.LEFT
    mParams.x, mParams.y = 100, 200
    menuView  = createMenuView()
    iconView  = createIconView()
    switchToIcon()
end
