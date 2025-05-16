private_vibescript.list_categorys = function(json_props)

    if #json_props.category_scripts == 0 then
        print("No categories available.")
        return
    end

    print("Available categories:")
    for i, category in ipairs(json_props.category_scripts) do
        print(i .. ". " .. category)
    end
end

