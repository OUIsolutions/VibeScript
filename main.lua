llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_user_prompt("liste a src e me fale o que tem nela ")

response = llm.generate()
print("Response: " .. response)