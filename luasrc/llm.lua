
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
            while true do 
                local permit = input("Do you want to write the file? "..args.file.."(y/n): ")
                if permit == "y" then
                    print(YELLOW.."Writing file: "..args.file..RESET)
                    break
                elseif permit == "n" then
                    print(RED.."Aborting write file: "..args.file..RESET)
                    return "User aborted"
                else
                    print(RED.."Invalid input, please enter y or n"..RESET)
                end
            end 
            return dtw.write_file(args.file, args.content)
        end
        llm.add_function("write", "write a file and return the content of the file",args,callback)
    end

  return llm


end 