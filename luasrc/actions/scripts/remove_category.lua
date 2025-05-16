

private_vibescript.remove_category = function(json_props)

    local category = argv.get_flag_arg_by_index({ private_vibescript.CATEGORY }, 1)
    
    if not category then
        error("--" .. private_vibescript.CATEGORY .. " is required", 0)
    end

    local category_found = false

    for i = #json_props.category_scripts, 1, -1 do
        if json_props.category_scripts[i] == category then
            table.remove(json_props.category_scripts, i)
            category_found = true
            break
        end
    end

    if not category_found then
        error("Category does not exist", 0)
    end

    private_vibescript.save_config_json(json_props)
end