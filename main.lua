llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_system_prompt("dont ask the user for anything, just do what i say")
llm.add_folder("docs/")
llm.add_file("src/main.lua")
llm.add_user_prompt("make a project overwiew and save it into README.md")
response = llm.generate()
print("Response: " .. response)