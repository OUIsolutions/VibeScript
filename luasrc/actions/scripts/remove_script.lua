private_vibescript.remove_script = function(config_json)
    local name = argv.get_next_unused()
    if not name then
        error("No script name provided", 0)
    end

    local script_found = false
    for i = 1, #config_json.scripts do
        if config_json.scripts[i].name == name then
            table.remove(config_json.scripts, i)
            script_found = true
            break
        end
    end

    if not script_found then
        error("Script (" .. name .. ") does not exist", 0)
    end

    private_vibescript.save_config_json(config_json)
    print("Script (" .. name .. ") removed successfully.")
end