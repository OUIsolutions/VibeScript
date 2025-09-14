
private_vibescript.add_script  = function()
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
    local scripts = get_prop("scripts", {})

    local description = argv.get_flag_arg_by_index({ private_vibescript.DESCRIPTION },1)
    
    local script = {                
        name = name,
        file = absolute,
    }
    
    if description then
        script.description = description
    end
    local replaced = false
    for i=1,#scripts do
        if scripts[i].name == name then
            scripts[i] = script
            replaced = true
            break
        end
    end

    if not replaced then
        scripts[#scripts+1] = script
    end
    set_prop("scripts", scripts)
    if os_name == "linux" or os_name == "mac" then 
        local code = string.format("vibescript %s \"$@\"", name)
        local path
        if os_name == "linux" then
            path = os.getenv("HOME").."/.local/bin/"..name
        else
            path = "/usr/local/bin/"..name
        end
        dtw.write_file(path, code)
        os.execute("chmod +x "..path)
    end

    print("Script ("..name..") added successfully")

end 