private_vibescript.internal_main = function()
     local config_json = private_vibescript.get_config_json()
     --dtw.write_file("teste.json",json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()


   
     if action == private_vibescript.RESET_CONFIG then
          return private_vibescript.reset()
     end
     if action == private_vibescript.ADD_SCRIPT then
          return private_vibescript.add_script(config_json)
     end
    
     if action == private_vibescript.REMOVE_SCRIPT then
          return private_vibescript.remove_script(config_json)
     end
     if action == private_vibescript.LIST_SCRIPTS then
          return private_vibescript.list_scripts(config_json)
     end
     if action == private_vibescript.ADD_MODEL then
          return private_vibescript.add_model(config_json)
     end
     if action == private_vibescript.LIST_MODELS then
          return private_vibescript.list_models(config_json)
     end
     if action == private_vibescript.REMOVE_MODEL then
          return private_vibescript.remove_model(config_json)
     end

     --if it gets here , it will make the normal operation, which is to interpret the first arg
     local script_name = action
     
     filename = script_name
     local found_filename = false

     for i = 1 , #config_json.scripts do
          if config_json.scripts[i].name == script_name then
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

 
     dofile(filename)

end 
private_vibescript.main = function()
     argv.get_next_unused()
     local ok, error = pcall(private_vibescript.internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
         os.exit(1)
     end
     os.exit(0)

end