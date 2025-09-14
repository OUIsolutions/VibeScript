
private_vibescript.configure_paths = function()
    local config_path = argv.get_flag_arg_by_index({ private_vibescript.CONFIG },1)
    
    if config_path then
        return config_path
    end
    local name = ".vibescript/"
    if os_name == "windows" then
        private_vibescript.config_path = os.getenv("APPDATA") .. "/"..name.."/"
    end

    private_vibescript.config_path = os.getenv("HOME") ..  "/.config/"..name.."/"
    private_vibescript.props_path = private_vibescript.config_path .. "props/"
    private_vibescript.amalgamation_path = private_vibescript.config_path .. "amalgamation/"
end
