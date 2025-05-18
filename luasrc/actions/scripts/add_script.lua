
private_vibescript.add_script  = function(config_json)
    local file = argv.get_flag_arg_by_index({ private_vibescript.FILE },1)
    if not file then
        error("No file ("..private_vibescript.FILE..") provided",0)
    end
    local name =  argv.get_next_unused()
    if not name then
        error("No script name provided",0)
    end
    if not dtw.isfile(file) then
        error("File ("..file..") does not exist",0)
    end

    local absolute = dtw.get_absolute_path(file)
    if not absolute then
        error("Failed to get absolute path for file ("..file..")",0)
    end

    for i=1,#config_json.scripts do
        if config_json.scripts[i].name == name then
            error("Script ("..name..") already exists",0)
        end
    end
    
    local script = {
        name = name,
        file = absolute,
    }
    config_json.scripts[#config_json.scripts+1] = script
    private_vibescript.save_config_json(config_json)
end 