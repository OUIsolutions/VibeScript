
private_vibescript.get_config_path = function()
    local config_path = argv.get_flag_arg_by_index({ "config" },0)
    if config_path then
        return config_path
    end

    if os_name == "windows" then
        return os.getenv("APPDATA") .. "/vibescript"
    end

    return os.getenv("HOME") ..  "/.config/.vibescript.json"
end