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
