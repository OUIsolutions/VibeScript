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
    project.add_lua_code("private_vibescript = {}\n")
    project.embed_global("PRIVATE_VIBESCRIPT_HELP_TEXT",darwin.dtw.load_file("assets/help.txt"))

    project.add_lua_code("argv = function()\n")
    project.add_lua_file("dependencies/luargv.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("argv = argv()\n")

    project.add_lua_code("ship = function()\n")
    project.add_lua_file("dependencies/LuaShip.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("ship = ship()\n")

    project.add_lua_code("webdriver = function()\n")
    project.add_lua_file("dependencies/luaWebDriver.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("webdriver = webdriver()\n")

    project.add_lua_code("luaberrante = function()\n")
    project.add_lua_file("dependencies/LuaBerrante.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("luaberrante = luaberrante()\n")

    project.add_lua_code("heregitage = function()\n")
    project.add_lua_file("dependencies/heregitage.lua")
    project.add_lua_code("end\n")
    project.add_lua_code("heregitage = heregitage()\n")
    
    project.add_lua_code("clpr_module = ")
    project.add_lua_file("dependencies/clpr.lua")
    project.add_lua_code("\n")
    local src_files = darwin.dtw.list_files_recursively("luasrc",true);
    for i=1,#src_files do
        local file = src_files[i]
        project.add_lua_file(file);
    end
    project.add_lua_code("private_vibescript.main()\n")
    project.c_external_code[#project.c_external_code + 1] ="#define VIBE_AMALGAMATION\n"
    project.add_c_file("csrc/start.c",true)
    project.load_lib_from_c("vibescript_start","cvibescript")
    project.generate_c_file({output="release/amalgamation.c",include_lua_cembed=false})
end
