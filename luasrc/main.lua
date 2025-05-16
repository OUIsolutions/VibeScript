
private_vibescript.internal_main = function()
     local config_json = private_vibescript.get_config_json()
     print(json.dumps_to_string(config_json))
     local action =   argv.get_next_unused()

     if action == private_vibescript.ADD_CATEGORY then
          return private_vibescript.add_category(config_json)
     end
     if action == private_vibescript.REMOVE_CATEGORY then
          return private_vibescript.remove_category(config_json)
     end

     if action == private_vibescript.RESET_CONFIG then
          return private_vibescript.reset()
     end
     if action == private_vibescript.ADD_SCRIPT then
          return private_vibescript.add_script(config_json)
     end
     if action == private_vibescript.LIST_CATEGORYS then
          return private_vibescript.list_categorys(config_json)
     end

     

     print("interpreting"..action)
end 
private_vibescript.main = function()
     argv.get_next_unused()
     local ok, err = pcall(private_vibescript.internal_main)
     if not ok then
         print(private_vibescript.RED..err..private_vibescript.RESET)
         os.exit(1)
     end

end 