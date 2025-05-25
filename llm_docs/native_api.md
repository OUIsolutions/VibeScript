# VibeScript Native API - Simplified for LLM

This document is a concise guide to the core features of VibeScript's Native API, tailored for easy interpretation by Large Language Models (LLMs). It focuses on the essential components for interacting with LLMs, managing scripts, and permissions.

## Core Concepts

### 1. Built-in Libraries
VibeScript provides native Lua libraries for essential tasks. These are automatically available:
- **dtw**: File and directory operations (read, write, list).
- **json**: JSON parsing and serialization.
- **argv**: Command-line argument parsing.
- **ship**: Container management (Podman/Docker wrapper).

### 2. Creating an LLM Instance
Use `newLLM()` to initialize an LLM with specific permissions to control system access.

#### Basic Initialization
```lua
llm = newLLM({
    read = true,    -- Allow reading files
    write = true,   -- Allow writing files
    execute = true, -- Allow executing commands
    delete = true,  -- Allow deleting files/directories
    list = true     -- Allow listing directories
})
llm.add_system_prompt("You are a helpful assistant.")
llm.add_user_prompt("List contents of src directory.")
response = llm.generate()
print("Response: " .. response)
```

#### Permissions
Permissions are boolean values in a table passed to `newLLM()`. They define what the LLM can do:
- `read`: Access file contents.
- `write`: Modify/create files.
- `execute`: Run system commands.
- `delete`: Remove files/directories.
- `list`: List directory contents.

### 3. Adding Context to LLM
Provide context by adding files or directories to the LLM's knowledge.
```lua
llm = newLLM({read = true, write = true, execute = true, delete = true, list = true})
llm.add_system_prompt("Don't ask, just do what I say.")
llm.add_dir("docs/")  -- Add directory contents
llm.add_file("src/main.c")  -- Add specific file
llm.add_user_prompt("Make a project overview and save it to README.md")
response = llm.generate()
print("Response: " .. response)
```

### 4. Building a Chatbot
Create a simple interactive chatbot with a loop for user input and AI responses.
```lua
llm = newLLM({})  -- No permissions for safety
llm.add_system_prompt("You are a friendly assistant.")
while true do
    io.write("User: ")
    local user_input = io.read("*l")
    llm.add_user_prompt(user_input)
    response = llm.generate()
    llm.add_assistant_prompt(response)  -- Remember AI response
    print("AI: " .. response)
end
```

### 5. Custom Functions for LLM
Define custom functions for the LLM to call during interactions.
```lua
llm = newLLM({})
local parameters = {
    {name = "color", description = "Color of AI response (red, green, blue, yellow)", type = "string", required = true}
}
local callback = function(args)
    if args.color == "red" then return "AI color changed to red" end
    if args.color == "green" then return "AI color changed to green" end
    if args.color == "blue" then return "AI color changed to blue" end
    if args.color == "yellow" then return "AI color changed to yellow" end
    return "Invalid color"
end
llm.add_function("change_ai_color", "Change AI response color", parameters, callback)
llm.add_user_prompt("Change AI color to yellow")
response = llm.generate()
print("AI: " .. response)
```

### 6. Persistent Properties
Store and retrieve data across script runs.
- `get_prop(prop_name)`: Get a property value.
- `set_prop(prop_name, prop_value)`: Set and save a property value.

```lua
local saved_color = get_prop("ai_response_color")
if type(saved_color) ~= "string" then
    set_prop("ai_response_color", "blue")
end
print("AI color loaded.")
set_prop("ai_response_color", "yellow")
print("AI color updated to yellow and saved.")
```

### 7. Error Handling
Handle errors using `pcall()` for safe execution.
```lua
local status, llm = pcall(function()
    return newLLM({read = true, write = true})
end)
if not status then
    print("Error creating LLM: " .. llm)
    os.exit(1)
end
llm.add_user_prompt("Hello!")
response = llm.generate()
print("Response: " .. response)
```

## Summary
VibeScript's Native API enables interaction with LLMs through `newLLM()`, permissions, context addition, custom functions, and persistent properties. Use built-in libraries (`dtw`, `json`, etc.) for file and data operations. This simplified guide covers the most critical aspects for effective LLM integration.