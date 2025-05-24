
private_vibescript.list_models = function(config_json)
    for i = 1, #config_json.models do
        local model = config_json.models[i]
        if model.name == config_json.default_model then
            print("Default: True")
        end
        print("Model Name: " .. model.name)
        print("URL: " .. model.url)
        print("-------------------------")
    end
end
