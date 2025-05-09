

function main()

    local user = {
        name = 'Mateus',
        age = 27,
        married = true,
        children = {
            {name = 'Child1', married = false}
        }
    }
    
    local indent = true
    local jsonString = json.dumps_to_string(user, indent)
    print(jsonString)
    
end 