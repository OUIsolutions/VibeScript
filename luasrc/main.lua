

function main()
 local files = dtw.list_files_recursively("luasrc",true);
    for i=1,#files do
        print("file:",files[i])
    end
end 