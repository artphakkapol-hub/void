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
