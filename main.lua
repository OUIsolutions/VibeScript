llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("delete README.md")

response = llm.generate()
print("Response: " .. response)