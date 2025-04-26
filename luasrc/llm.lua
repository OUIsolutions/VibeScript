
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
            {name = "file",descryption="the file name" type = "string", required = true},
        }
        local callback = function(args)
            return dtw.load_file(args.file)
        end
        llm.add_function("read", "read a file", callback,args)
    end

  return llm


end 