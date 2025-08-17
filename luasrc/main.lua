private_vibescript.internal_main = function()
     local config_json = private_vibescript.get_config_json()
     --dtw.write_file("teste.json",json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()
     private_vibescript.configure_newRawLLMFunction(config_json)
     private_vibescript.configure_props_functions(config_json)
     
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
          return private_vibescript.add_script(config_json)
     end
    
     if action == private_vibescript.REMOVE_SCRIPT then
          return private_vibescript.remove_script(config_json)
     end
     if action == private_vibescript.LIST_SCRIPTS or action == private_vibescript.LIST_SCRIPTS_OPTION2 then
          return private_vibescript.list_scripts(config_json)
     end

     if action == private_vibescript.CONFIGURE_MODEL then
          return private_vibescript.add_model(config_json)
     end
     if action == private_vibescript.LIST_MODELS then
          return private_vibescript.list_models(config_json)
     end
     if action == private_vibescript.REMOVE_MODEL then
          return private_vibescript.remove_model(config_json)
     end
     if action == private_vibescript.SET_MODEL_AS_DEFAULT then
          return private_vibescript.set_model_as_default(config_json)
     end

     --if it gets here , it will make the normal operation, which is to interpret the first arg
     local script_name = action
     filename = script_name
     local found_filename = false

     local name_num = tonumber(script_name)
     for i = 1 , #config_json.scripts do
          if config_json.scripts[i].name == script_name then
               filename = config_json.scripts[i].file
               found_filename = true
               break
          end
          if name_num == i then
               filename = config_json.scripts[i].file
               found_filename = true
               break
          end

     end

     if not found_filename then 
          filename = dtw.get_absolute_path(script_name)          
     end
     if not filename then
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