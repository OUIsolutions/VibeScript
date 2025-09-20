private_vibescript.internal_main = function()
    private_vibescript.configure_paths()
     private_vibescript.configure_props_functions()
     --dtw.write_file("teste.json",json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()
     private_vibescript.configure_newRawLLMFunction()
    
     
     if action == "set_prop" then 
          local prop_key = argv.get_next_unused()
          local prop_value = argv.get_next_unused()
          set_prop(prop_key, prop_value)
          return  0
     end 
     if action == "get_prop" then 
          local prop_key = argv.get_next_unused()
          local prop_value = get_prop(prop_key)
          if not prop_value then
               print(private_vibescript.RED.."Property not found: "..prop_key..private_vibescript.RESET)
          else
               print(private_vibescript.GREEN..prop_value..private_vibescript.RESET)
          end
          return 0
     end
     if action == "eval" then 
          local all_args = {}
          while true do 
               local arg = argv.get_next_unused()
               if not arg then break end
               table.insert(all_args,arg)
          end
          local command = table.concat(all_args," ")
           load(command)()
          return 0
     end 

     
     if action == "version" or action == "--version"  then 
          print("vibescript "..private_vibescript.VERSION)
          return
     end 
     if action == "help" or action == "--help" then
          print(PRIVATE_VIBESCRIPT_HELP_TEXT)
          return
     end

     if action == private_vibescript.RESET_CONFIG then
          return private_vibescript.reset()
     end
     if action == private_vibescript.ADD_SCRIPT then
          return private_vibescript.add_script()
     end
    
     if action == private_vibescript.REMOVE_SCRIPT then
          return private_vibescript.remove_script()
     end
     if action == private_vibescript.LIST_SCRIPTS or action == private_vibescript.LIST_SCRIPTS_OPTION2 then
          return private_vibescript.list_scripts()
     end

     if action == private_vibescript.CONFIGURE_MODEL then
          return private_vibescript.add_model()
     end
     if action == private_vibescript.LIST_MODELS then
          return private_vibescript.list_models()
     end
     if action == private_vibescript.REMOVE_MODEL then
          return private_vibescript.remove_model()
     end
     if action == private_vibescript.SET_MODEL_AS_DEFAULT then
          return private_vibescript.set_model_as_default()
     end

     --if it gets here , it will make the normal operation, which is to interpret the first arg
     local script_name = action
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
     dofile(filename)

end 

private_vibescript.main = function()
   
     if vibescript_extension_main then 
          return vibescript_extension_main()
     end
   
     argv.get_next_unused()

     local ok, error = pcall(private_vibescript.internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
     end
     return 0

end