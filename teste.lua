llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_system_prompt("You are a helpful assistant.")
llm.add_user_prompt("list the luasrc dir, and explain what's inside")
response = llm.generate()
print("Response: " .. response)