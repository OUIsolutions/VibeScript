## Creating a LLM

To create a basic LLM connection, you can use the following Lua code:

~~~lua 
llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_system_prompt("You are a helpful assistant.")
llm.add_user_prompt("list the src dir, and explain what's inside")
response = llm.generate()
print("Response: " .. response)
~~~

This code initializes an LLM with full permissions to read, write, execute, delete, and list. It then sets a system prompt to define the assistant's role and a user prompt to list and explain the contents of the 'src' directory. The `generate` method is called to get a response from the LLM, which is then printed.

### Creating a Basic Chatbot Implementation

For a simple chatbot, you can use the following Lua code:

~~~lua 
llm = newLLM({})
while true do 
    io.write(GREEN.."User: ")
    llm.add_user_prompt(io.read("*l"))
    response = llm.generate()
    print(BLUE.."AI: " .. response)
end 
~~~

This code creates an LLM instance and enters an infinite loop where it prompts the user for input, adds it as a user prompt to the LLM, generates a response, and prints it in blue.

### Creating a Function

To create a function within the LLM, you can use the following C code:

~~~c 
llm = newLLM({})

user_color = GREEN
ai_color = BLUE

local parameters = {
    {
        name="color",
        description="the color of the ai, format in ('red','green','blue','yellow')", 
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
llm.add_function("change_ai_color","change the ai color",parameters,callback)

llm.add_user_prompt("change the color to yellow")
local response = llm.generate()
print(ai_color..response..RESET)
~~~

This code defines a function `change_ai_color` that allows changing the AI's color. It uses a callback to update the color based on the user's input and then generates a response to confirm the change.
