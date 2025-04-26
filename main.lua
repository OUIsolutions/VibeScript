llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("read the content of README.md file")

response = llm.generate()
print("Response: " .. response)