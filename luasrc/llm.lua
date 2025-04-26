
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

  return llm


end 