
private_vibescript.get_config_path = function()
    local config_path = argv.get_flag_arg_by_index({ private_vibescript.CONFIG },1)
    
    if config_path then
        return config_path
    end
    local name = ".vibescript/"
    if os_name == "windows" then
        return os.getenv("APPDATA") .. "/"..name
    end

    return os.getenv("HOME") ..  "/.config/"..name
end
