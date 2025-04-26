local files = dtw.list_files_recursively("src")

for i=1, #files do
    local file = files[i]
   print(file)
end