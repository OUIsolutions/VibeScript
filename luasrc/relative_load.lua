
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

function relative_dir_load(path)
    local target_dir = dtw.concat_path(script_dir_name, path)
    local files = dtw.list_files_recursively(target_dir, true)
    for i=1,#files do 
        local current = dtw.get_absolute_path(files[i])
        
        -- avoid recursive loading of the same file
        if current ~= filename  then 
            dofile(current)
        end 
    end
end 