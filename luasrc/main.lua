
private_vibescript.internal_main = function()
     local config_json = private_vibescript.get_config_json()
     print(json.dumps_to_string(config_json))
end 
private_vibescript.main = function()
     local ok, err = pcall(private_vibescript.internal_main)
     if not ok then
         print("mensagem de erro:(" .. err..")")
         os.exit(1)
     end
end 