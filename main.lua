llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("create a dir called test")

response = llm.generate()
print("Response: " .. response)