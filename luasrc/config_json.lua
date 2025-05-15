
private_vibescript.get_config_path = function()
    local config_path = argv.get_flag_arg_by_index({ "config" },0)
    if config_path then
        return config_path
    end
    local name = cvibescript.get_config_name()
    if os_name == "windows" then
        return os.getenv("APPDATA") .. "/"..name
    end

    return os.getenv("HOME") ..  "/.config/"..name
end