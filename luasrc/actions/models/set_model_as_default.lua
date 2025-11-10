private_vibescript.set_model_as_default = function()
    local model_name = argv.get_flag_arg_by_index({ private_vibescript.MODEL }, 1)
    if not model_name then
        error("No model (--" .. private_vibescript.MODEL .. ") provided", 0)
    end
    
    local models = get_prop("models", {})
    local model_found = false
    for i = 1, #models do
        if models[i].name == model_name then
            models[i].isdefault = true
            model_found = true
        else
            models[i].isdefault = nil
        end
    end

    if not model_found then
        error("Model (" .. model_name .. ") does not exist", 0)
    end

    set_prop("models", models)
end