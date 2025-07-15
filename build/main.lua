---@class Darwin
darwin = darwin


function main()


    if not darwin.argv.flags_exist({ "no_dep_install" }) then 
        Install_dependencies()
    end 
  
    local build_funcs = create_build_funcs()


    darwin.dtw.remove_any("release")
    darwin.dtw.remove_any(".cache")
    local i = 1
    for name, buld_lambda in pairs(build_funcs) do
        if darwin.argv.one_of_args_exist(name) then
            print("\n=========================================================================================")
            print("\tstarted of build:", i, "of ", name,  "\n")
            buld_lambda()
            print("\n\tA build [" .. i .. "] finished")
            print("=========================================================================================\n\n")
            i = i + 1
        end
    end

    darwin.dtw.move_any_overwriting("release/alpine_static_bin.out","release/"..PROJECT_NAME..".out")
    darwin.dtw.move_any_overwriting("release/windows64.exe","release/"..PROJECT_NAME.."64.exe")
    darwin.dtw.move_any_overwriting("release/windowsi32.exe","release/"..PROJECT_NAME.."i32.exe")
    darwin.dtw.move_any_overwriting("release/debian_static.deb","release/"..PROJECT_NAME..".deb")
    darwin.dtw.move_any_overwriting("release/rpm_static_build.rpm","release/"..PROJECT_NAME..".rpm")

end