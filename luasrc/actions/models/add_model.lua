
private_vibescript.add_model = function()
    local model_name = argv.get_flag_arg_by_index({ private_vibescript.MODEL }, 1)
    if not model_name then
        error("No model (--"..private_vibescript.MODEL ..") provided", 0)
    end

    local model_url = argv.get_flag_arg_by_index({ private_vibescript.URL }, 1)
    if not model_url then
        error("No url (--" .. private_vibescript.URL .. ") provided", 0)
    end

    local model_key = argv.get_flag_arg_by_index({ private_vibescript.KEY }, 1)
    if not model_key then
        error("No model key (--" .. private_vibescript.KEY .. ") provided", 0)
    end
    
    local model = {
        name = model_name,
        url = model_url,
        key = model_key,
    }
    local models = get_prop("models", {})
    local replaced = false
    for i=1,#models do
        if models[i].name == model_name then
            models[i] = model
            replaced = true
        end
    end
    if not replaced then 
        models[#models + 1] = model
    end

    set_prop("models", models)
end

