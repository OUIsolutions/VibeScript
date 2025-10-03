load_global_module = function(script_name,is_main)

     filename = script_name
     local found_filename = false
     local scripts = get_prop("scripts", {})
     local name_num = tonumber(script_name)
     for i = 1 , #scripts do
          if scripts[i].name == script_name then
               filename = scripts[i].file
               found_filename = true
               break
          end
          if name_num == i then
               filename = scripts[i].file
               found_filename = true
               break
          end

     end

     if not found_filename then 
          filename = dtw.get_absolute_path(script_name)          
     end
     if not filename then

          local ok, requisition = pcall(luabear.fetch,{url=script_name})
          if ok then 
                 local ok, code  = pcall(requisition.read_body)
               if ok then
                    load(code)()
                    return
               end
          end 
          error("File ("..script_name..") does not exist",0)
     end
     
     script_dir_name = dtw.newPath(filename).get_dir()
     is_main_script = is_main
     dofile(filename)
     is_main_script = false

end 