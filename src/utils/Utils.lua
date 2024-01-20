-- TODO Create method that will force numbers as strings to keep zeros to x place

Utils = {}

function Utils.process_args(class_meta, ...)
    local args = { ... }
    local processed_args

    if type(args[1]) == "table" then
        if getmetatable(args[1]) == class_meta then
            processed_args = args
        else
            processed_args = args[1]
        end
    else
        processed_args = args
    end

    return processed_args
end

function Utils.has_non_integer_keys(t)
    for k, _ in pairs(t) do
        if type(k) ~= "number" or k ~= math.floor(k) or k < 1 then
            return true
        end
    end
    return false
end

-- TODO Refactor this to be more generic

function Utils.deep_copy_color(color_table)
    local copy = {}
    for i = 1, #color_table do
        copy[i] = color_table[i]
    end
    return copy
end

function Utils.table_to_string(t, truncate, places)
    truncate = truncate or false
    places = places or 0

    local parts = {}
    local function process_value(v)
        if truncate and type(v) == "number" then
            return Math.truncate(v, places)
        elseif type(v) == "table" then
            return Utils.table_to_string(v, truncate, places)
        else
            return tostring(v)
        end
    end

    if Utils.has_non_integer_keys(t) then
        for k, v in pairs(t) do
            v = process_value(v)
            parts[#parts + 1] = tostring(k) .. " = " .. v
        end
    else
        for _, v in ipairs(t) do
            v = process_value(v)
            parts[#parts + 1] = v
        end
    end
    return "{ " .. table.concat(parts, ", ") .. " }"
end

function Utils.get_peak_memory(interval)
    if _PeakMemory == nil then
        _PeakMemory = math.floor(collectgarbage("count"))
    end

    if Time == nil then Time = 0 end
    local current_memory_usage = math.floor(collectgarbage("count"))
    local truncated_time = math.floor(Time * 100) / 100

    if _PeakMemory < current_memory_usage then
        _PeakMemory = current_memory_usage
    end

    if truncated_time % interval == 0 then _PeakMemory = 0 end

    return _PeakMemory
end
