

private_vibescript.main = function()
     local config_json = private_vibescript.get_config_json()
     print(json.dumps_to_string(config_json))
end 