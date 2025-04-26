
## Creating a llm 
for creating a  basic llm conection?

~~~lua 
llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_system_prompt("You are a helpful assistant.")
llm.add_user_prompt("list the src dir , and explain what its inside ")
response = llm.generate()
print("Response: " .. response)
~~~

creating a basic chatbot implementaion:
~~~lua 

llm = newLLM({})
while true do 
    io.write(GREEN.."User: ")
    llm.add_user_prompt(io.read("*l"))
    response = llm.generate()
    print(BLUE.."AI: " .. response)
end 

~~~
creating  a function: 
~~~c 
llm = newLLM({})

user_color = GREEN
ai_color = BLUE

local parameters = {
    {
        name="color",
        description="the color of the ai , format in ('red','green','blue',yellow)", 
        type = "string",
         required = true
    }
}
local callback  = function(args)
    if args.color == "red" then
        ai_color = RED
    elseif args.color == "green" then
        ai_color = GREEN
    elseif args.color == "blue" then
        ai_color = BLUE
    elseif args.color == "yellow" then
        ai_color = YELLOW
    else
        return "invalid color"
    end
    return "ai color changed to "..args.color
end 
llm.add_function("change_ai_color","chamge the ai color",parameters,callback)

llm.add_user_prompt("channge the color to yellow")
local response = llm.generate()
print(ai_color..response..RESET)


~~~