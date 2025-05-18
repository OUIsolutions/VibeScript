local add_model = {}

private_vibescript.add_model = function(config_json)
    local model_name = argv.get_flag_arg_by_index({ private_vibescript.MODEL }, 1)
    if not model_name then
        error("No model name provided", 0)
    end

    local model_url = argv.get_flag_arg_by_index({ private_vibescript.URL }, 1)
    if not model_url then
        error("No model URL provided", 0)
    end

    local model_key = argv.get_flag_arg_by_index({ private_vibescript.KEY }, 1)
    if not model_key then
        error("No model key provided", 0)
    end

    for i = 1, #config_json.models do
        if config_json.models[i].name == model_name then
            error("Model (" .. model_name .. ") already exists", 0)
        end
    end

    local model = {
        name = model_name,
        url = model_url,
        key = model_key,
    }

    config_json.models[#config_json.models + 1] = model
    private_vibescript.save_config_json(config_json)
end

return add_model