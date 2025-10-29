
private_vibescript.remove_itens_of_list = function (itens,itens_to_exclude)
    local filtered_itens = {}
    for i=1,#itens do
        local item = itens[i]
        local exclude_item = false
        
   
    end
end

private_vibescript.configure_patch = function ()
    function ApplyPatch(patch)



        if not patch then
            error("No patch provided")
        end
        if not patch.repo then 
            error("No repo provided in patch")
        end

        if not patch.src then
            patch.src = "."
        end
        if not patch.dest then
            patch.dest = "."
        end


        local patch_dest = os.getenv("HOME").."/.vibescript_patches/"
        local hasher = dtw.newHasher()
        hasher.digest(patch.repo)

        local patch_folder = patch_dest..hasher.get_value()
        dtw.create_dir_recursively(patch_folder)
        if not dtw.isdir(patch_folder) then 
            os.execute("git clone "..patch.repo.." "..patch_folder)
        end 
        local git_pull_command = "cd "..patch_folder.." && git pull"
        os.execute(git_pull_command)

        local itens_to_copy = dtw.list_files_recursively(patch_folder.."/"..patch.src)

        local internal_excudes = {
            ".git/*"
        }


    end
end