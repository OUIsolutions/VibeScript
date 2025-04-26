llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("create a quck explanation of flask in README.md")

response = llm.generate()
print("Response: " .. response)