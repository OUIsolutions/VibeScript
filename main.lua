llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})


llm.add_user_prompt("make the content of docs/native_api.md more 'complete', with a better explanation and write to file")
response = llm.generate()
print("Response: " .. response)