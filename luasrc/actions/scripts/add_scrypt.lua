
private_vibescript.add_script = function(json_props)
    local file = argv.get_flag_arg_by_index({ private_vibescript.FILE }, 1)
    if not file then
        error("--" .. private_vibescript.FILE .. " is required", 0)
    end

    if not dtw.isfile(file) then
        error("File "..file.." does not exist", 0)
    end

    local absolute_file = dtw.get_absolute_path(file)
    if not absolute_file then
        error("File"..file.."does not exist", 0)
    end
 
    local name = argv.get_flag_arg_by_index({ private_vibescript.NAME }, 1)
    if not name then
        error("--" .. private_vibescript.NAME .. " is required", 0)
    end

   
    local category = argv.get_flag_arg_by_index({ private_vibescript.CATEGORY }, 1)

    if category then
        -- check if category exists
        local category_found = false
        for i = 1, #json_props.category_scripts do
            if json_props.category_scripts[i] == category then
                category_found = true
                break
            end
        end
        if not category_found then
            error("Category does not exist", 0)
        end
    end 

    -- check if script already exists
    for  i = 1, #json_props.scripts do
        local current_script = json_props.scripts[i]
        if current_script.name == name and current_script.category == category then
            error("Script with the name"..name.." already exists", 0)
        end
    end

     json_props.scripts[#json_props.scripts + 1] = {
        name = name,
        file = absolute_file,
        category = category
     }

    private_vibescript.save_config_json(json_props)
end