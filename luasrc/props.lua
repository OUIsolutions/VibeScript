private_vibescript.configure_props_functions = function(config_json)


    function get_prop(prop_name, default)
        if not prop_name then
            error("prop_name is required")
        end
    
        local data =  cvibescript.save_encrypted_prop(private_vibescript.props_path,prop_name)
        if not data then
            return default
        end
        return data 
    end 

    function set_prop(prop_name, prop_value)
        if not prop_name then
            error("prop_name is required")
        end
        if not prop_value then
            error("prop_value is required")
        end
        cvibescript.save_encrypted_prop(private_vibescript.props_path,prop_name,prop_value)
    end
end 