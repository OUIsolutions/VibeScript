private_vibescript.configure_newRawLLMFunction = function(config_json)
    local chosed_model = nil
    if config_json.default_model  then
        for i=1,#config_json.models do
            local current_model = config_json.models[i]
            if current_model.name == config_json.default_model then
                chosed_model = current_model
                break
            end
        end 
    end
    if chosed_model == nil then
        chosed_model = config_json.models[1]
    end
    if chosed_model == nil then
        return 
    end
    newRawLLM = function()
        return private_vibescript.newRawLLM(chosed_model.url, chosed_model.api_key, chosed_model.model)
    end
end


function newLLM(permissions)
    if not newRawLLM then
        error("no model configured")
    end

    local llm = newRawLLM()
    local old_generate = llm.generate
    local files = {}
    if type(permissions) ~= "table" then
        error("permissions must be a table")
    end


    local validPermissions = {
        "read",
        "write",
        "execute",
        "delete",
        "list"
    }
    for _, permission in ipairs(permissions) do
        if not table.contains(validPermissions, permission) then
            error("Invalid permission: " .. permission)
        end
        if type(permission) ~= "boolean" then
            error("Permission must be a boolean")
        end
    end
    
    llm.add_file = function(filename)
        files[#files + 1] = {filename = filename,already_added = false}
    end

    llm.add_dir = function(dir)
        local concat_path = true
        local dir_files = dtw.list_files_recursively(dir,concat_path)
        for _, file in ipairs(dir_files) do
            files[#files + 1] = {filename = file,already_added = false}
        end
    end
    llm.generate = function()
        local content = ""
        for _, file in ipairs(files) do
            if not file.already_added then
                local file_content = dtw.load_file(file.filename)
                if file_content == nil then
                    error("File not found: " .. file.filename)
                    return
                end
                content = content.."file: " .. file.filename .. "\n" .. file_content .. "\n"
                file.already_added = true
            end
        end
        if content ~= "" then
            llm.add_user_prompt(content)
        end
        return old_generate()
    end
       

    if permissions.read then

        local args = {
            {name = "file",description="the file name", type = "string", required = true},
        }
        local callback = function(args)
            print(YELLOW.."Reading file: "..args.file..RESET)
            return dtw.load_file(args.file)
        end
        llm.add_function("read", "read a file and return the content of the file",args,callback)
    end
    if permissions.write then
        local args = {
            {name = "file",description="the file name", type = "string", required = true},
            {name = "content",description="the content to write", type = "string", required = true},
        }
        local callback = function(args)
            print(YELLOW.."Writing file: "..args.file..RESET)
            dtw.write_file(args.file, args.content)
            return "file written"
        end
        llm.add_function("write", "write a file and return the content of the file",args,callback)
    end
    if permissions.execute then
        local args = {
            {name = "command",description="the command to execute", type = "string", required = true},
        }
        local callback = function(args)
            print(YELLOW.."Executing command: "..args.command..RESET)
            return os.execute(args.command)
        end
        llm.add_function("execute", "execute a command and return the output",args,callback)

    end
    if permissions.delete then
        local args = {
            {name = "element",description="the element to remove", type = "string", required = true},
        }
        local callback = function(args)
            print(YELLOW.."Deleting element: "..args.element..RESET)
            dtw.remove_any(args.element)
            return "element removed"
        end
        llm.add_function("delete", "delete a file or a dir",args,callback)
    end



    if permissions.list then
        local args = {
            {name = "dir",description="the directory to list", type = "string", required = true},
        }
        local callback = function(args)
            print(YELLOW.."Listing directory: "..args.dir..RESET)
            local files ,size= dtw.list_files_recursively(args.dir)
            return files
        end
        llm.add_function("list", "list a directory and return the content of the directory",args,callback)
    end


  return llm


end 