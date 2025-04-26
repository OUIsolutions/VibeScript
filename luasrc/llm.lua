
function newLLM(permissions)
    local llm = newRawLLM()
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
        local content = dtw.load_file(filename)
        local formmtated = "file: " .. filename .. "\n" .. content
        llm.add_user_prompt(formmtated)
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