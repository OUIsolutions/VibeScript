
private_vibescript.list_scripts = function(config_json)
    local start_filtrage =  argv.get_next_unused()
    
    for i =1 , #config_json.scripts do
        local current_script = config_json.scripts[i]
        local print_script = false         
        if start_filtrage then
            if private_vibescript.is_str_inside(current_script.name, start_filtrage) then
                print_script = true
            end
        end 
        if not start_filtrage then
            print_script = true 
        end     
        if print_script then 
            local output = i..": "..current_script.name
            if current_script.description and current_script.description ~= "" then
                output = output .. " - " .. current_script.description
            end
            print(output)
        end 
    end
end