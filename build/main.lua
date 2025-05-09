function main()
    Install_all_dependencies()

    local valid_builds = {
        "build_source",
        "build_linux",
        "build_linux_from_docker",
        "build_windows",
        "build_windows_from_source"
    }
    local generate_source = false
    for _, item in ipairs(valid_builds) do
        if vibescript.argv.one_of_args_exist(item) then
            generate_source = true
        end
    end

    if generate_source then
        local project = vibescript.create_project("VibeScript")
        Embed_c_code(project)
        Create_api_assets(project)
        Embed_types(project)

        if vibescript.argv.one_of_args_exist("build_linux") then
            project.add_lua_code("vibescript.os = 'linux'")
        end
        if vibescript.argv.one_of_args_exist("build_windows") then
            project.add_lua_code("vibescript.os = 'windows'")
        end
        project.add_lua_code("vibescript.dtw=private_vibescript_dtw")
        project.add_lua_code("vibescript.json=private_vibescript_json")
        project.add_lua_code("vibescript.candango=private_vibescript_candango")
        local lua_argv_content = vibescript.dtw.load_file("dependencies/luargv.lua")
        project.add_lua_code(string.format(
            "vibescript.argv = function()\n %s\n end \n",
            lua_argv_content
        ))
        project.add_lua_code("vibescript.argv = vibescript.argv()")


        local lua_ship_content = vibescript.dtw.load_file("dependencies/LuaShip.lua")
        project.add_lua_code(string.format(
            "vibescript.ship = function()\n %s\n end \n",
            lua_ship_content
        ))
        project.add_lua_code("vibescript.ship = vibescript.ship()")


        project.add_lua_code("private_vibescript = {}")

        
        project.add_lua_code("private_vibescript.main()")
        project.generate_lua_file({ output = "debug.lua" })
        project.generate_c_file({ output = "release/vibescript.c", include_lua_cembed = false })
    end


    if vibescript.argv.one_of_args_exist("build_windows_from_docker") then
        local image = vibescript.ship.create_machine("debian:latest")
        image.add_comptime_command("apt-get update")
        image.add_comptime_command("apt-get -y install mingw-w64")
        image.start({
            volumes = {
                { "./release", "/release" }
            },
            command = "i686-w64-mingw32-gcc --static /release/vibescript.c -o /release/vibescript.exe"
        })
    end
    if vibescript.argv.one_of_args_exist("build_windows") then
        os.execute("i686-w64-mingw32-gcc  --static release/vibescript.c -o  release/vibescript.exe")
    end

    if vibescript.argv.one_of_args_exist("build_linux_from_docker") then
        local image = vibescript.ship.create_machine("alpine:latest")
        image.add_comptime_command("apk update")
        image.add_comptime_command("apk add --no-cache gcc musl-dev curl")

        image.start({
            volumes = {
                { "./release", "/release" }
            },
            command = "gcc --static /release/vibescript.c -o /release/vibescript.out"
        })
    end

    if vibescript.argv.one_of_args_exist("build_linux") then
        if vibescript.argv.one_of_args_exist("no_static") then
            os.execute("gcc   release/vibescript.c -o  release/vibescript.out")
        else
            os.execute("gcc --static  release/vibescript.c -o  release/vibescript.out")
        end
    end
    if vibescript.argv.one_of_args_exist("debug") then
        os.execute("gcc release/vibescript.c -o  release/debug.out")
    end
end
