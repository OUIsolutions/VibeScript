private_vibescript.configure_props_functions = function(config_json)


    function get_prop(prop_name,default)
        if not config_json.props[prop_name] then
            return default
        end
        return config_json.props[prop_name]
    end 

    function set_prop(prop_name, prop_value)
        if not config_json.props[prop_name] then
            config_json.props[prop_name] = {}
        end
        config_json.props[prop_name] = prop_value
        private_vibescript.save_config_json(config_json)
    end
end 