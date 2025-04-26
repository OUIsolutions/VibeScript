llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("use the function read to read README.md and bring me a resume")

response = llm.generate()
print("Response: " .. response)