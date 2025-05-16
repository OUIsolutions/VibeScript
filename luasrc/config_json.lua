
private_vibescript.get_config_path = function()
    local config_path = argv.get_flag_arg_by_index({ private_vibescript.CONFIG },1)
    
    if config_path then
        return config_path
    end

    local name = cvibescript.get_config_name()
    if os_name == "windows" then
        return os.getenv("APPDATA") .. "/"..name
    end

    return os.getenv("HOME") ..  "/.config/"..name
end


private_vibescript.get_config_json = function()
    local config_path = private_vibescript.get_config_path()
    local data = dtw.load_file(config_path)
    if not data then
        return {
            dirs ={},
            models = {},
        }
    end 
    
    local decrypted = cvibescript.get_data(data)
    if not decrypted then
        error("Failed to decrypt config file: " .. config_path,0) 
    end
    local json = dtw.json.loads(decrypted)
    if not json then
        error("Failed to parse config file: " .. config_path,0) 
    end

end