argv = function()


private_luargv =  {}
luargv = {}
private_lua_argv_string_functions = {}
-- file: src/luargv/base_flags.lua

luargv.get_flag_size = function(flags)
    if luargv.type(flags) == "string" then
        flags = { flags }
    end
    local total_found = 0
    local args_size = luargv.get_total_args_size()
    local capturing_flags = false
    for i = 1, args_size do
        local current = luargv.get_arg_by_index_not_adding_to_used(i)
        local possible_flag = private_luargv.get_formmated_flag_if_its_a_flag(current)
        if possible_flag then
            if private_luargv.is_inside(flags, possible_flag) then
                capturing_flags = true
            else
                capturing_flags = false
            end
        end

        if capturing_flags and not possible_flag then
            total_found = total_found + 1
        end
    end

    return total_found
end

luargv.get_flag_arg_by_index = function(flags, index, default)
    if luargv.type(flags) == "string" then
        flags = { flags }
    end
    local total_found = 0
    local args_size = luargv.get_total_args_size()
    local capturing_flags = false
    local possible_flag_index = nil
    for i = 1, args_size do
        local current = luargv.get_arg_by_index_not_adding_to_used(i)
        local possible_flag = private_luargv.get_formmated_flag_if_its_a_flag(current)
        if possible_flag then
            if private_luargv.is_inside(flags, possible_flag) then
                possible_flag_index = i
                capturing_flags = true
            else
                capturing_flags = false
            end
        end

        if capturing_flags and not possible_flag then
            total_found = total_found + 1
            if total_found == index then
                if possible_flag_index then
                    luargv.add_used_args_by_index(possible_flag_index)
                end
                luargv.add_used_args_by_index(i)
                return current
            end
        end
    end

    return default
end


luargv.flags_exist = function(flags)
    local args_size = luargv.get_total_args_size()

    for i = 1, args_size do
        local current = luargv.get_arg_by_index_not_adding_to_used(i)
        local possible_flag = private_luargv.get_formmated_flag_if_its_a_flag(current)
        if possible_flag then
            if private_luargv.is_inside(flags, possible_flag) then
                return true
            end
        end
    end
    return false
end

-- file: src/luargv/basic.lua

luargv.one_of_args_exist = function(args_list)
    if luargv.type(args_list) == "string" then
        args_list = { args_list }
    end
    for i = 1, #args_list do
        local arg_value = args_list[i]
        local size = luargv.get_total_args_size()
        for i = 1, size do
            local current = luargv.get_arg_by_index_not_adding_to_used(i)
            if current == arg_value then
                luargv.add_used_args_by_index(i)
                return true
            end
        end
        return false
    end
end

luargv.get_total_args_size = function()
    local count = 0
    for i = -3, 1000000 do
        local current = luargv.argslist[i]
        if current then
            count = count + 1
        end

        if i > 0 and current == nil then
            return count
        end
    end

    return 0
end

luargv.get_arg_by_index_not_adding_to_used = function(index)
    local decrementer = 0
    for i = 0, 1000000 do
        local converted_i = i * -1
        if luargv.argslist[converted_i] == nil then
            break
        end
        decrementer = decrementer + 1
    end
    return luargv.argslist[index - decrementer]
end

luargv.get_arg_by_index = function(index)
    luargv.add_used_args_by_index(index)
    return luargv.get_arg_by_index_not_adding_to_used(index)
end

-- file: src/luargv/compact_flag.lua

luargv.get_compact_flags = function(flags, index, default)
    local converted_flags = flags
    if luargv.type(flags) == "string" then
        ---@type string
        flags = flags
        flags = { flags }
    end


    local total = 0
    for i = 1, #flags do
        local flag_name = flags[i]
        local flag_size = luargv.get_str_size(flag_name)
        local args_size = luargv.get_total_args_size()
        for i = 1, args_size do
            local current = luargv.get_arg_by_index_not_adding_to_used(i)

            if private_luargv.starts_with(current, flag_name) then
                total = total + 1
                if total == index then
                    local current_size = luargv.get_str_size(current)
                    local formmated = luargv.substr_func(current, flag_size + 1, current_size)
                    luargv.add_used_args_by_index(i)
                    return formmated
                end
            end
        end
    end

    return default
end

luargv.get_compact_flags_size = function(flags)
    local converted_flags = flags
    if luargv.type(flags) == "string" then
     
        flags = { flags }
    end
    local total = 0
    for i = 1, #flags do
        local flag_name = flags[i]
        local flag_size = luargv.get_str_size(flag_name)
        local args_size = luargv.get_total_args_size()
        for i = 1, args_size do
            local current = luargv.get_arg_by_index_not_adding_to_used(i)

            if private_luargv.starts_with(current, flag_name) then
                total = total + 1
            end
        end
    end

    return total
end

-- file: src/luargv/constructor.lua

luargv.argslist = arg
luargv.flag_identifiers = { "-", "--" }
luargv.used_args = {}
if string then
    luargv.substr_func = string.sub
    luargv.get_str_size = string.len
end



luargv.type = type

if not luargv.get_str_size then
    luargv.get_str_size = function(str)
        return #str
    end
end

-- file: src/luargv/used_flags.lua

luargv.add_used_args_by_index = function(index)
    if index > luargv.get_total_args_size() then
        return
    end

    if not private_luargv.is_inside(luargv.used_args, index) then
        luargv.used_args[#luargv.used_args + 1] = index
    end
end

luargv.get_total_unused_args = function()
    return luargv.get_total_args_size() - #luargv.used_args
end

luargv.get_unsed_arg_by_index = function(index)
    local total       = 0
    local total_flags = luargv.get_total_args_size()
    for i = 1, total_flags do
        if not private_luargv.is_inside(luargv.used_args, i) then
            total = total + 1
            if total == index then
                return luargv.get_arg_by_index_not_adding_to_used(i)
            end
        end
    end
    return nil
end

luargv.get_next_unused_index = function()
    local total_flags = luargv.get_total_args_size()
    for i = 1, total_flags do
        if not private_luargv.is_inside(luargv.used_args, i) then
            return i
        end
    end
    return nil
end


luargv.get_next_unused = function()
    local i = luargv.get_next_unused_index()
    if i then
        return luargv.get_arg_by_index(i)
    end
end

-- file: src/private_luargv/algo.lua

private_luargv.starts_with = function(str, target)
    local target_size = luargv.get_str_size(target)
    local divided = luargv.substr_func(str, 1, target_size)

    if divided == target then
        return true
    end
    return false
end


private_luargv.get_array_size = function(array)
    local i     = 1
    local count = 0
    while array[i] do
        count = count + 1
        i = i + 1
    end
    return count
end

private_luargv.is_inside = function(array, item)
    local size = private_luargv.get_array_size(array)
    for i = 1, size do
        if array[i] == item then
            return true
        end
    end
    return false
end

-- file: src/private_luargv/formmated_flags.lua

private_luargv.get_formmated_flag_if_its_a_flag = function(current_arg)
    local total_flags = private_luargv.get_array_size(luargv.flag_identifiers)
    local chose_flag_size = 0
    for i = 1, total_flags do
        local current_flag = luargv.flag_identifiers[i]
        if private_luargv.starts_with(current_arg, current_flag) then
            local current_flag_size = luargv.get_str_size(current_flag)
            if current_flag_size >= chose_flag_size then
                chose_flag_size = current_flag_size
            end
        end
    end
    -- means its a flag
    if chose_flag_size > 0 then
        local args_size = luargv.get_str_size(current_arg)
        return luargv.substr_func(current_arg, chose_flag_size + 1, args_size)
    end
    return nil
end

-- file: src/types.lua

---@class Argv
---@field get_flag_size fun(flags:string[]|string):number
---@field get_flag_arg_by_index fun(flags:string[]|string,index:number,default:string | nil):string|nil
---@field flags_exist fun(flags:string[]):boolean
---@field one_of_args_exist fun(arg:string[] | string):boolean
---@field get_total_args_size fun():number
---@field get_arg_by_index_not_adding_to_used fun(index:number):string
---@field get_arg_by_index fun(index:number):string | nil
---@field get_compact_flags fun(flags:string[]|string,index,default:string | nil):string|nil
---@field get_compact_flags_size fun(flags:string[]|string):number
---@field used_args number[]
---@field type fun(value:any):string
---@field argslist string[]
---@field substr_func fun(str:string,start:number,endnum:number):string
---@field get_str_size fun(str:string):number
---@field flag_identifiers string[]
---@field add_used_args_by_index fun(used_flag:number)
---@field get_total_unused_args fun():number
---@field get_unsed_arg_by_index fun(index:number):string|nil
---@field get_next_unused_index fun():number|nil
---@field get_next_unused fun():string|nil


---@class PrivateArgv
---@field starts_with fun(str:string,target:string):boolean
---@field get_array_size fun(array:table):number
---@field is_inside fun(array:table,item:any):boolean
---@field get_formmated_flag_if_its_a_flag fun(current_arg:string):string |nil



---@type PrivateArgv
private_luargv = private_luargv


---@type Argv
luargv = luargv



---@type PrivateArgv
private_luargv = private_luargv


---@type Argv
luargv = luargv

return luargv
end
argv = argv()
