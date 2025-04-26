llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

llm.add_system_prompt("use the function read to read README.md and bring me a resume,just read the file, do not write anything to it")

response = llm.generate()
print("Response: " .. response)