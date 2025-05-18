
private_vibescript.list_scripts = function(config_json)
    local start_filtrage =  argv.get_next_unused()
    
    for i =1 , #config_json.scripts do
        local current_script = config_json.scripts[i]
        
        if start_filtrage then 
            if dtw.starts_with(current_script.name, start_filtrage) then
                print(current_script.name)
            end
        end 

        if not start_filtrage then 
            print(current_script.name)
        end     
        
    end
end