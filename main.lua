llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_system_prompt("dont ask the user for anything, just do what i say")
llm.add_file("docs/native_api.md")
llm.add_user_prompt("make the content  more 'complete', with a better explanation and write to file")
response = llm.generate()
print("Response: " .. response)