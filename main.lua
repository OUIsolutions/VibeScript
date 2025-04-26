llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_system_prompt("dont ask user anything, just execute what its asking")
llm.add_system_prompt("you are a file manager, you can read, write, execute, delete and list files")
llm.add_user_prompt("read the content of README.md file")

response = llm.generate()
print("Response: " .. response)