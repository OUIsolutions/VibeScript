

private_vibescript.main = function()
    local config_path = private_vibescript.get_config_path()
    print(config_path)
     local config_json = private_vibescript.get_config_json()
     print(json.dumps_to_string(config_json))
end 