private_vibescript.remove_script = function()
    
    local name = argv.get_next_unused()
    if not name then
        error("No script name provided", 0)
    end
    local scripts = get_prop("scripts", {})
    local script_found = false
    for i = 1, #scripts do
        if scripts[i].name == name then
            table.remove(scripts, i)
            script_found = true
            break
        end
    end

    if not script_found then
        error("Script (" .. name .. ") does not exist", 0)
    end

    set_prop("scripts", scripts)
end