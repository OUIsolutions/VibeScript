
private_vibescript.get_config_path = function()

    if os_name == "windows" then
        return os.getenv("APPDATA") .. "/vibescript"
    end
    return os.getenv("HOME") .. "/.vibescript"
end