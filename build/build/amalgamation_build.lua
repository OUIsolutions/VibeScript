local alreay_amalamated_done = false
function amalgamation_build()
    if alreay_amalamated_done then
        return
    end
    alreay_amalamated_done = true


    local project = darwin.create_project("VibeScript")

    local src_files = darwin.dtw.list_files_recursively("luasrc",true);
    for i=1,#src_files do
        local file = src_files[i]
        project.add_lua_file(file);
    end
    project.add_lua_code("main()\n")

    project.generate_c_file({output="release/amalgamation.c",include_lua_cembed=true})

end
