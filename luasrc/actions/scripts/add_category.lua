
private_vibescript.add_category = function(json_props)

    local category = argv.get_flag_arg_by_index({ private_vibescript.CATEGORY },1)
    
    if not category then
        error("--" ..private_vibescript.CATEGORY.."is required",0)
    end

    for i=1,#json_props.category_scripts do
        local current_category = json_props.category_scripts[i]
        if current_category == category then
            error("Category already exists",0)
        end
    end
    
    json_props.category_scripts[#json_props.category_scripts + 1] = category

    private_vibescript.save_config_json(json_props)
end 