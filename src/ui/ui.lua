--[[
  UI Module - Interface management and component builder
  Creates and manages all UI elements: tabs, module cards, dialogs, animations
  
  Dependencies: All Android imports from main.lua, UI constants, helper functions
  Exports: loadCategory, addTab, addModule, updateRO, createIconView, createMenuView, initUI
]]


--[[================================
  CATEGORY MANAGEMENT
==================================]]

-- Sidebar tab registry: id → { container, iconTV, labelTV }
-- Keyed by tab id string so loadCategory can recolor children without
-- relying on Java object equality as table keys.
local _tabData    = {}
local _activeTabId = nil

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

    -- Deactivate previous tab (reset background + both child text colors)
    if _activeTabId and _tabData[_activeTabId] then
        local prev = _tabData[_activeTabId]
        prev.container.setBackground(getSkin(UI.BG, 8))
        prev.iconTV.setTextColor(UI.SUB)
        prev.labelTV.setTextColor(UI.SUB)
    end

    -- Activate newly selected tab
    if _tabData[id] then
        local curr = _tabData[id]
        curr.container.setBackground(getSkin(UI.ACCENT, 8))
        curr.iconTV.setTextColor(UI.TEXT)
        curr.labelTV.setTextColor(UI.TEXT)
    end

    _activeTabId  = id
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

-- Unicode icon map keyed by tab id.
-- These are basic BMP characters that render on all Android versions.
local _TAB_ICONS = {
    account = "\xe2\x8a\x99",   -- ⊙  profile/user
    player = "\xe2\x96\xb7",   -- ▷  play/game
    adventure = "\xe2\x97\x86",   -- ◆  quest/adventure
    cups = "\xe2\x96\xb2",   -- ▲  trophy/cups
    team = "\xe2\x8a\x9e",   -- ⊞  grid/team
    event = "\xe2\x96\xa3",   -- ▣  calendar/event
    creative = "\xe2\x98\x85",   -- ★  star/creative
    shop = "\xe2\x97\x91",   -- ◑  coin/shop
    other = "\xe2\x8b\xaf",   -- ⋯  ellipsis/other
    settings = "\xe2\x9a\x99",   -- ⚙  gear/settings
    about = "\xe2\x84\xb9",   -- ℹ  info/about
}

---Creates a sidebar tab row (icon + label) that loads a category when tapped.
---Registers icon+label refs in _tabData[id] for later recoloring by loadCategory.
---@param parent View Layout to add tab to
---@param id string Tab identifier
---@param name string Display name for the tab
---@return View The created tab container
function addTab(parent, id, name)
    local icon_char = UI.TABS_ICON -- _TAB_ICONS[id]

    -- Outer container (horizontal: icon | label)
    local container = LinearLayout(activity)
    container.setOrientation(0)
    local params = LinLayoutParams(-1, -2)
    params.bottomMargin = dp(2)
    container.setLayoutParams(params)
    container.setPadding(dp(8), dp(8), dp(6), dp(8))
    container.setGravity(Gravity.CENTER_VERTICAL)
    container.setBackground(getSkin(UI.BG, 8))

    -- Icon column
    local iconTV = TextView(activity)
    local iconParams = LinLayoutParams(dp(20), dp(20))
    iconParams.rightMargin = dp(7)
    iconTV.setLayoutParams(iconParams)
    iconTV.setText(icon_char)
    iconTV.setTextColor(UI.SUB)
    iconTV.setTextSize(1, 13)
    iconTV.setGravity(Gravity.CENTER)
    iconTV.setTypeface(Typeface.DEFAULT_BOLD)
    container.addView(iconTV)

    -- Label column (wraps to 2 lines for long names)
    local labelTV = TextView(activity)
    labelTV.setLayoutParams(LinLayoutParams(0, -2, 1.0))
    labelTV.setText(tostring(name))
    labelTV.setTextColor(UI.SUB)
    labelTV.setTextSize(1, 9)
    labelTV.setTypeface(Typeface.create("sans-serif", Typeface.BOLD))
    labelTV.setSingleLine(false)
    labelTV.setMaxLines(2)
    container.addView(labelTV)

    container.setOnClickListener(View.OnClickListener({
        onClick = function(v) loadCategory(id, container) end
    }))

    -- Register for loadCategory recoloring
    _tabData[id] = { container = container, iconTV = iconTV, labelTV = labelTV }

    parent.addView(container)
    return container
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
-- SEPARATOR
-- ─────────────────────────────────────────────

function addTabSep(parent, text)
    local sep = TextView(activity)
    local rp = LinLayoutParams(-1, -2)
    rp.topMargin = dp(4)
    rp.bottomMargin = dp(2)
    sep.setLayoutParams(rp)
    sep.setText(tostring(text))
    sep.setTextColor(UI.TEXT)
    sep.setTextSize(1, 9)
    sep.setTypeface(Typeface.create("sans-serif", Typeface.BOLD))
    sep.setGravity(Gravity.CENTER)
    sep.setPadding(dp(6), dp(5), dp(6), dp(5))
    sep.setBackground(getSkin(UI.CARD, 8))

    parent.addView(sep)
end

function addModuleSep(parent, text)
    local sep = TextView(activity)
    local rp = LinLayoutParams(-1, -2)
    rp.topMargin = dp(6)
    rp.bottomMargin = dp(4)
    sep.setLayoutParams(rp)
    sep.setText(tostring(text))
    sep.setTextColor(UI.TEXT)
    sep.setTextSize(1, 13)
    sep.setTypeface(Typeface.create("sans-serif-medium", Typeface.NORMAL))
    sep.setGravity(Gravity.CENTER)
    sep.setPadding(dp(10), dp(5), dp(10), dp(5))
    sep.setBackground(getSkin(UI.CARD, 12, 1, UI.STROKE))

    parent.addView(sep)
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
    sub.setText(scriptSubHeader)
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
    sub.setText(scriptSubHeader)
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

---Builds the vertical sidebar tab column and adds it to root.
---@param root View Parent LinearLayout (horizontal)
---@return View|nil firstTab, string|nil firstTabId
local function _buildMenuTabs(root, _lastTab)
    -- Reset registry so a UI rebuild starts clean
    _tabData     = {}
    _activeTabId = nil

    -- Sidebar wrapper: fixed width, full available height
    local sideBar = LinearLayout(activity)
    sideBar.setOrientation(1)
    local sbParams = LinLayoutParams(dp(SIDEBAR_W), -1)
    sideBar.setLayoutParams(sbParams)
    sideBar.setBackground(getSkin(UI.BG, 0))

    -- Thin right divider line
    local divider = View(activity)
    local dvParams = LinLayoutParams(dp(1), -1)
    divider.setLayoutParams(dvParams)
    divider.setBackgroundColor(UI.STROKE)

    -- Scrollable tab list
    local tabScroll = ScrollView(activity)
    tabScroll.setVerticalScrollBarEnabled(false)
    tabScroll.setLayoutParams(LinLayoutParams(-1, -1))
    tabScroll.setPadding(dp(6), dp(8), dp(6), dp(8))

    local tabLayout = LinearLayout(activity)
    tabLayout.setOrientation(1)
    tabScroll.addView(tabLayout)

    sideBar.addView(tabScroll)
    root.addView(sideBar)
    root.addView(divider)

    local firstTab, firstTabId = nil, nil
    local menuList = tabHandlers or {{"unknown", "unknown"}}
    local firstTabFound = false
    for i, m in ipairs(menuList) do
        if m[1] == "separator" then
            addTabSep(tabLayout, m[2])
        else
            local t = addTab(tabLayout, m[1], m[2])
            if _lastTab and m[1] == _lastTab then
                firstTab = t
                firstTabId = m[1]
                firstTabFound = true
            else
                if not firstTabFound then
                    firstTab = t
                    firstTabId = m[1]
                    firstTabFound = true
                end
            end
        end
    end
    return firstTab, firstTabId
end

---Builds the content ScrollView + moduleContainer and adds them to root.
---@param root View Parent LinearLayout (horizontal inner row)
---@return View scroll The ScrollView (needed by resize handles)
local function _buildMenuContent(root)
    local scroll = ScrollView(activity)
    -- Weight=1 fills remaining width after sidebar
    local sp = LinLayoutParams(0, -1, 1.0)
    scroll.setLayoutParams(sp)
    scroll.setVerticalScrollBarEnabled(false)
    scroll.setPadding(dp(10), dp(10), dp(10), dp(10))

    moduleContainer = LinearLayout(activity)
    moduleContainer.setOrientation(1)
    scroll.addView(moduleContainer)
    root.addView(scroll)
    return scroll
end

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
    memory:save_global("window_size", { w = WIN_W, h = WIN_H })
    showToast("Size saved! Restart the script")
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

---Creates the full menu view - main UI panel with header on top and [sidebar | content] below.
---Delegates every major section to a helper function so createMenuView itself
---stays shallow (few locals, few bytecodes) and never overflows the JVM stack.
---@return View The menu FrameLayout containing all UI elements
function createMenuView(lastTab)
    LOG.info("createMenuView", "START | Initializing Configurable Background Stack")

    local base = FrameLayout(activity)
    base.setLayoutParams(LayoutParams(-2, -2))
    
    local isBgLoaded = false

    local targetPath = UI.BG_IMAGE.PATH
    if targetPath ~= "no_media" then
        local fileCheck = io.open(targetPath, "r")
        
        if fileCheck then
            fileCheck:close()
            
            local bgImage = ImageView(activity)
            local bgParams = FrameLayout.LayoutParams(-1, -1)
            bgImage.setLayoutParams(bgParams)
            bgImage.setScaleType(ScaleType.FIT_XY)
            
            local bitmap = BitmapFactory.decodeFile(targetPath)
            if bitmap then
                local drawable = BitmapDrawable(activity.getResources(), bitmap)
                bgImage.setImageDrawable(drawable)
                bgImage.setImageAlpha(UI.BG_IMAGE.ALPHA & 0xFF)
                
                base.addView(bgImage)
                isBgLoaded = true -- Set state flag to true
                LOG.info("createMenuView", "Configurable static background mounted successfully.")
            else
                LOG.error("createMenuView", "Failed to decode static target bitmap asset data structure.")
            end
        else
            LOG.warn("createMenuView", "Configured background asset completely missing at path: " .. tostring(targetPath))
        end
    end

    -- Outer: VERTICAL — header on top, then the sidebar+content row below
    local outer = LinearLayout(activity)
    outer.setOrientation(1)
    
    -- Dynamic Adaptive Styling Configuration
    if isBgLoaded then
        outer.setBackgroundColor(0x00000000)
    else
        outer.setBackground(getSkin(UI.BG, 16, 0, UI.STROKE))
    end

    outer.setLayoutParams(FrameLayout.LayoutParams(dp(WIN_W), -2))

    outer.setFocusable(true)
    outer.setFocusableInTouchMode(true)
    outer.setOnTouchListener(View.OnTouchListener{
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

    -- Header sits at the top of outer
    _buildMenuHeader(outer)

    -- Inner: HORIZONTAL — sidebar tabs on the left, content scroll on the right
    local inner = LinearLayout(activity)
    inner.setOrientation(0)
    local innerParams = LinLayoutParams(-1, dp(WIN_H))
    inner.setLayoutParams(innerParams)
    _menuRoot = inner
    outer.addView(inner)

    local firstTab, firstTabId = _buildMenuTabs(inner, lastTab)
    local scroll = _buildMenuContent(inner)
    _menuScroll = scroll

    -- Defer first-tab load so createMenuView() fully returns before
    -- addModule() closures are built.
    if firstTab and firstTabId then
        local _ftab, _ftabId = firstTab, firstTabId
        MainHandler.post(Runnable({ run = function()
            LOG.info("createMenuView", "deferred loadCategory: " .. tostring(_ftabId))
            loadCategory(_ftabId, _ftab)
        end }))
    end

    base.addView(outer)
    menuView = base

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
