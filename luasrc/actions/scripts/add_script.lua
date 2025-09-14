
private_vibescript.add_script  = function()
    local file = argv.get_flag_arg_by_index({ private_vibescript.FILE },1)
    if not file then
        error("No file ("..private_vibescript.FILE..") provided",0)
    end
    local name =  argv.get_next_unused()
    if not name then
        error("No script name provided",0)
    end
    local copy = argv.flags_exist({ "copy", "cp" })

    local already_copied = false
    if not dtw.isfile(file) then

        local requisition = luabear.fetch({url=file})
        local ok, content  = pcall(requisition.read_body)
        if ok then 
            local name_sha = dtw.generate_sha(name)
            local path = private_vibescript.amalgamation_path .. name_sha .. ".lua"
            dtw.write_file(path, content)
            file = path
            copy = true
            already_copied = true 
        else
            error("File ("..file..") does not exist",0)
        end
    end
    if copy and not already_copied then
        local name_sha = dtw.generate_sha(name)
        local path = private_vibescript.amalgamation_path .. name_sha .. ".lua"
        dtw.copy_any_overwriting(file, path)
        file = path
    end


    local absolute = dtw.get_absolute_path(file)
    if not absolute then
        error("Failed to get absolute path for file ("..file..")",0)
    end
    local scripts = get_prop("scripts", {})

    local description = argv.get_flag_arg_by_index({ private_vibescript.DESCRIPTION },1)
    
    local script = {                
        name = name,
        copy=copy,
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
        local code = string.format("%s %s \"$@\"", argv.get_arg_by_index(1), name)
        local path
        if os_name == "linux" then
            path = os.getenv("HOME").."/.local/bin/"..name
        else -- mac
            path = "/usr/local/bin/"..name
        end
        dtw.write_file(path, code)
        os.execute("chmod +x "..path)
    elseif os_name == "windows" then
        local code = string.format("@echo off\n%s %s %%*", argv.get_arg_by_index(1), name)
        local path = os.getenv("USERPROFILE").."\\AppData\\Local\\Microsoft\\WindowsApps\\"..name..".bat"
        dtw.write_file(path, code)
    end

    print("Script ("..name..") added successfully")

end 