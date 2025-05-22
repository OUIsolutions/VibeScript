
function relative_load(path)
    local old_script_dir_name = script_dir_name
    local old_filename = filename
    filename = dtw.concat_path(script_dir_name, path)
    if not dtw.isfile(filename) then
        local error_filename = filename
        filename = old_filename
        script_dir_name = old_script_dir_name
        error("File ("..error_filename..") does not exist",0)
    end

    dofile(filename)
    script_dir_name = old_script_dir_name
    filename = old_filename
end 