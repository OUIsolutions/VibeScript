private_vibescript.internal_main = function()
     local config_json = private_vibescript.get_config_json()
     --dtw.write_file("teste.json",json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()
     private_vibescript.configure_newRawLLMFunction(config_json)
     private_vibescript.configure_props_functions(config_json)
     if argv.one_of_args_exist({"version"}) or argv.flags_exist({"version","v"}) then 
          print("vibescript "..private_vibescript.VERSION)
          return
     end 
     if action == private_vibescript.HELP or argv.flags_exist({"help","h"}) then
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
     if action == private_vibescript.LIST_SCRIPTS then
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
     
     path = script_name
     local found_path = false

     for i = 1 , #config_json.scripts do
          if config_json.scripts[i].name == script_name then
               path = config_json.scripts[i].file
               found_path = true
               break
          end
     end
     
     if not found_path then 
          path = dtw.get_absolute_path(script_name)          
     end
     if not path then
          error("File ("..script_name..") does not exist",0)
     end

     script_dir_name = dtw.newPath(path).get_dir()
     dofile(path)

end 
private_vibescript.main = function()
     argv.get_next_unused()

   
     local ok, error = pcall(private_vibescript.internal_main)
     if not ok then
         print(private_vibescript.RED..error..private_vibescript.RESET)
     end
     return 0

end