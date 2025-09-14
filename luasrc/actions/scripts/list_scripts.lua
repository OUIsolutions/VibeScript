
private_vibescript.list_scripts = function()
    local start_filtrage =  argv.get_next_unused()
    local scripts = get_prop("scripts", {})

    for i =1 , #scripts do
        local current_script = scripts[i]
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
            if current_script.description then
                output = output.." - "..current_script.description
            end
            print(output)
        end 
    end
end