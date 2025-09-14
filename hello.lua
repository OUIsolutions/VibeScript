llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

-- Set system behavior
llm.add_system_prompt("Don't ask the user for anything, just do what I say.")


-- Request an action based on the context
llm.add_user_prompt("Make a project overview and save it into OVERVIEW.md")
    -- Generate and display the response
response = llm.generate()
print("Response: " .. response)