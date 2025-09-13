


private_vibescript.get_config_json = function()
    local config_path = private_vibescript.get_config_path()
    local data = dtw.load_file(config_path)
    if not data then
        return {
            scripts ={},
            models = {},
            props = {},
        }
    end 
    
    local decrypted = cvibescript.get_data(data)
    if not decrypted then
        error("Failed to decrypt config file: " .. config_path,0) 
    end
    local json = json.load_from_string(decrypted)
    if not json then
        error("Failed to parse config file: " .. config_path,0) 
    end
    return json
end

private_vibescript.save_config_json = function(json_props)
    local config_path = private_vibescript.get_config_path()
    local data =json.dumps_to_string(json_props)
    if not data then
        error("Failed to serialize config file: " .. config_path,0) 
    end

    local encrypted = cvibescript.set_data(data)
    if not encrypted then
        error("Failed to encrypt config file: " .. config_path,0) 
    end

    dtw.write_file(config_path,encrypted)
end