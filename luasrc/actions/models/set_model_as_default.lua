private_vibescript.set_model_as_default = function(config_json)
    local model_name = argv.get_flag_arg_by_index({ private_vibescript.MODEL }, 1)
    if not model_name then
        error("No model (--" .. private_vibescript.MODEL .. ") provided", 0)
    end

    local model_found = false
    for i = 1, #config_json.models do
        if config_json.models[i].name == model_name then
            config_json.default_model = model_name
            model_found = true
            break
        end
    end

    if not model_found then
        error("Model (" .. model_name .. ") does not exist", 0)
    end

    private_vibescript.save_config_json(config_json)
end