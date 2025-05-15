local alreay_amalamated_done = false
function amalgamation_build()
    if alreay_amalamated_done then
        return
    end
    alreay_amalamated_done = true

    darwin.silverchain.generate({
        src = "csrc",
        project_short_cut = PROJECT_NAME,
        tags = { 
            "dep_declare",
            "macros",
            "types",
            "consts",
            "fdeclare",
            'globals',
            "fdefine",
    }})


    local project = darwin.create_project(PROJECT_NAME)

    local src_files = darwin.dtw.list_files_recursively("luasrc",true);
    for i=1,#src_files do
        local file = src_files[i]
        project.add_lua_file(file);
    end
    project.add_lua_code("private_vibescript = {}\n")
    project.add_lua_code("argv = function()\n")
    project.add_lua_file("dependencies/luargv.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("argv = argv()\n")


    project.add_lua_code("ship = function()\n")
    project.add_lua_file("dependencies/LuaShip.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("ship = ship()\n")


    project.add_lua_code("main()\n")

    project.add_c_file("csrc/start.c",true)
    project.load_lib_from_c("vibescript_start","cvibescript")
    project.generate_c_file({output="release/amalgamation.c",include_lua_cembed=false})
end
