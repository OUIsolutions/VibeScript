private_vibescript.configure_patch = function ()
    function ApllyPatch(patch)
        if not patch then
            error("No patch provided")
        end
        if not patch.repo then 
            error("No repo provided in patch")
        end
        local patch_dest = os.getenv("HOME").."/.vibescript_patches/"
        local hasher = dtw.newHash()
        hasher.digest(patch.repo)

        local patch_folder = patch_dest..hasher.get_value()
        dtw.create_dir_recursively(patch_folder)
        os.execute("git clone "..patch.repo.." "..patch_folder)

    end
end