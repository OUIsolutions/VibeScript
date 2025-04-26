
function create_lua_src()
    local lua_argv = darwin.dtw.load_file("dependencies/luargv.lua")
    local content = [[argv = function()]]
    content = content .. lua_argv
    content = content .. "end\n"
    content = content .. "argv = argv()\n"
    local lua_src_files = darwin.dtw.list_files_recursively("luasrc", false)

    for _, file in ipairs(lua_src_files) do
        local file_content = darwin.dtw.load_file("src/"..file)
        content = content .. file_content
    end

    darwin.dtw.write_file("assets/lua_src.lua", content)
end 