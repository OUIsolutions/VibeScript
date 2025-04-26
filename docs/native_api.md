
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
