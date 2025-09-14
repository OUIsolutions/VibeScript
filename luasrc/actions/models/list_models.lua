
private_vibescript.list_models = function()
    local models = get_prop("models", {})
    
    for i = 1, #models do
        local model = models[i]
        if model.isdefault then
            print("Default: True")
        end
        print("Model Name: " .. model.name)
        print("URL: " .. model.url)
        print("-------------------------")
    end
end
