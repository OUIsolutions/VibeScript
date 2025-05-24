# VibeScript Native API Documentation

This document provides a comprehensive guide to the native API of VibeScript, a powerful tool for interacting with Large Language Models (LLMs) and managing scripts and configurations. It covers the built-in libraries, internal functions, and features like persistent properties, with detailed explanations and code examples.

## Table of Contents
- [Built-in Libraries](#built-in-libraries)
- [Creating an LLM Instance](#creating-an-llm-instance)
- [Adding Context to LLM](#adding-context-to-llm)
- [Building a Basic Chatbot](#building-a-basic-chatbot)
- [Defining Custom Functions for LLM](#defining-custom-functions-for-llm)
- [Managing Persistent Properties](#managing-persistent-properties)
- [Relative Loading of Scripts](#relative-loading-of-scripts)
- [Error Handling and Permissions](#error-handling-and-permissions)

## Built-in Libraries

VibeScript comes with several native Lua libraries that provide essential functionalities for file operations, JSON handling, argument parsing, and container management. These libraries are automatically available in the VibeScript environment.

| Object Name | Library Name | Description |
|-------------|--------------|-------------|
| `dtw` | [LuaDoTheWorld](https://github.com/OUIsolutions/LuaDoTheWorld) | A utility library for file and directory operations, including reading, writing, listing, and more. |
| `json` | [LuaFluidJson](https://github.com/OUIsolutions/LuaFluidJson) | A library for parsing and serializing JSON data, useful for configuration management. |
| `argv` | [LuaArgv](https://github.com/OUIsolutions/LuaArgv) | A library for parsing command-line arguments, enabling script customization via CLI. |
| `ship` | [LuaShip](https://github.com/OUIsolutions/LuaShip) | A Podman/Docker wrapper for container management, useful for advanced deployment scenarios. |

These libraries can be directly used within your VibeScript scripts to perform various operations. For example, `dtw.load_file()` can read a file's content, and `json.dumps_to_string()` can serialize a Lua table to a JSON string.

## Creating an LLM Instance

VibeScript allows you to create instances of Large Language Models (LLMs) to interact with AI services. The `newLLM()` function initializes an LLM with specific permissions, which control the operations the model can perform on your system.

### Basic LLM Initialization

Here’s how to create a basic LLM instance with full permissions:

```lua
-- Initialize an LLM instance with all permissions enabled
llm = newLLM({
    read = true,    -- Allows the LLM to read files
    write = true,   -- Allows the LLM to write files
    execute = true, -- Allows the LLM to execute system commands
    delete = true,  -- Allows the LLM to delete files or directories
    list = true     -- Allows the LLM to list directory contents
})

-- Add a system prompt to define the AI's behavior
llm.add_system_prompt("You are a helpful assistant.")

-- Add a user prompt to request information
llm.add_user_prompt("List the contents of the src directory and explain what's inside.")

-- Generate a response from the LLM
response = llm.generate()
print("Response: " .. response)
```

### Explanation of Permissions

Permissions are passed as a table to `newLLM()` and determine the system access level of the LLM. Each permission corresponds to a specific function that the LLM can call:

- `read`: Enables the `read` function to access file contents.
- `write`: Enables the `write` function to create or modify files.
- `execute`: Enables the `execute` function to run system commands.
- `delete`: Enables the `delete` function to remove files or directories.
- `list`: Enables the `list` function to enumerate directory contents.

**Important**: Permissions must be boolean values (`true` or `false`). Passing invalid permissions will result in an error.

### Prompt Types

You can add different types of prompts to guide the LLM's responses:

- `add_system_prompt(prompt)`: Sets the overall behavior or role of the AI (e.g., "You are a coding expert.").
- `add_user_prompt(prompt)`: Represents user input or queries to the AI.
- `add_assistant_prompt(prompt)`: Adds a response or context from the AI itself, useful for maintaining conversation history.

## Adding Context to LLM

To provide additional context to the LLM, you can include files or directories in the conversation. This is particularly useful for tasks involving code review, documentation, or analysis of existing content.

### Adding Files and Directories

Use `add_file()` to include a specific file and `add_dir()` to include all files in a directory recursively. The content is automatically appended to the user prompt during the next `generate()` call.

```lua
llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})

-- Set system behavior
llm.add_system_prompt("Don't ask the user for anything, just do what I say.")

-- Add a directory and its contents to the context
llm.add_dir("docs/")

-- Add a specific file to the context
llm.add_file("src/main.c")

-- Request an action based on the context
llm.add_user_prompt("Make a project overview and save it into README.md")

-- Generate and display the response
response = llm.generate()
print("Response: " .. response)
```

**Note**: Files and directories are only added once to avoid redundancy in subsequent `generate()` calls. If a file is not found, an error will be thrown.

## Building a Basic Chatbot

VibeScript can be used to create a simple interactive chatbot. The following example demonstrates a continuous loop where the user inputs prompts, and the AI responds.

```lua
if os_name == "windows" then 
    os.execute("chcp 65001")
    os.execute("cls")
end

-- Define color variables
local COLOR_GREEN = "\27[32m"
local COLOR_BLUE = "\27[34m"
local COLOR_RESET = "\27[0m"

-- Initialize an LLM with no system permissions (safe for chat-only use)
llm = newLLM({})

-- Set a system prompt for the chatbot's behavior
llm.add_system_prompt("You are a friendly and helpful assistant.")

-- Start an infinite loop for user interaction
while true do
    -- Prompt user for input with a green color
    io.write(COLOR_GREEN .. "User: " .. COLOR_RESET)

    -- Read user input
    local user_input = io.read("*l")
    -- Add user input as a prompt
    llm.add_user_prompt(user_input)

    -- Generate AI response
    response = llm.generate()
    llm.add_assistent_prompt(response) -- tell the llm to remember what it said

    -- Display AI response in blue
    print(COLOR_BLUE .. "AI: " .. response .. COLOR_RESET)
end

```

This script creates a basic chatbot interface where user input is colored green, and AI responses are colored blue, using VibeScript's built-in color constants.

## Defining Custom Functions for LLM

VibeScript allows you to define custom functions that the LLM can call during interactions. This feature enables the AI to perform specific tasks or interact with the environment beyond the default permissions.

### Example: Changing AI Response Color

Here’s an example of defining a custom function to change the color of AI responses:

```lua
-- Initialize an LLM with no permissions
llm = newLLM({})

-- Initialize color variables for user and AI responses
user_color = private_vibescript.GREEN
ai_color = private_vibescript.BLUE

-- Define parameters for the custom function
local parameters = {
    {
        name = "color",
        description = "The color of the AI response, format in ('red', 'green', 'blue', 'yellow')",
        type = "string",
        required = true
    }
}

-- Define the callback function to handle color change
local callback = function(args)
    if args.color == "red" then
        ai_color = private_vibescript.RED
    elseif args.color == "green" then
        ai_color = private_vibescript.GREEN
    elseif args.color == "blue" then
        ai_color = private_vibescript.BLUE
    elseif args.color == "yellow" then
        ai_color = private_vibescript.YELLOW
    else
        return "Invalid color"
    end
    return "AI color changed to " .. args.color
end

-- Add the custom function to the LLM
llm.add_function("change_ai_color", "Change the AI response color", parameters, callback)

-- Add a user prompt to trigger the function
llm.add_user_prompt("Change the AI color to yellow")

-- Generate and display the response with the updated color
local response = llm.generate()
print(ai_color .. "AI: " .. response .. private_vibescript.RESET)
```

### Explanation of `add_function`

- **Parameters**: A table of parameter definitions, each with `name`, `description`, `type`, and `required` fields. These define the expected input for the function.
- **Callback**: A Lua function that processes the arguments and returns a result. The LLM will call this function when the user invokes it through a prompt.
- **Usage**: Custom functions allow the LLM to interact with the script environment dynamically, enabling complex workflows or UI changes as shown above.

**Note**: Function names must be unique. Attempting to add a function with an existing name will result in an error.

## Managing Persistent Properties

VibeScript provides a mechanism to store and retrieve persistent properties across script executions using the configuration file. This feature is implemented in `luasrc/props.lua` and allows scripts to maintain state or settings over time.

### Functions for Property Management

- `get_prop(prop_name)`: Retrieves the value of a specified property from the configuration. Returns an empty table `{}` if the property does not exist.
- `set_prop(prop_name, prop_value)`: Sets a property value in the configuration and saves it. Overwrites the existing value if the property already exists.

### Example: Storing and Retrieving User Preferences

Here’s an example of using persistent properties to store a user’s preferred AI response color:

```lua
-- Retrieve the saved AI color or default to blue if not set
local saved_color = get_prop("ai_response_color")
if type(saved_color) == "string" then
    if saved_color == "red" then
        ai_color = private_vibescript.RED
    elseif saved_color == "green" then
        ai_color = private_vibescript.GREEN
    elseif saved_color == "blue" then
        ai_color = private_vibescript.BLUE
    elseif saved_color == "yellow" then
        ai_color = private_vibescript.YELLOW
    end
else
    ai_color = private_vibescript.BLUE  -- Default color
    set_prop("ai_response_color", "blue")  -- Save default
end

print(ai_color .. "AI color loaded from preferences." .. private_vibescript.RESET)

-- Change and save a new color preference
new_color = "yellow"
set_prop("ai_response_color", new_color)
ai_color = private_vibescript.YELLOW
print(ai_color .. "AI color updated to yellow and saved." .. private_vibescript.RESET)
```

### How It Works

- **Storage**: Properties are stored in the `props` field of the configuration JSON, which is encrypted and saved to disk.
- **Persistence**: Changes made with `set_prop()` persist across different VibeScript invocations, allowing scripts to remember settings or state.
- **Use Cases**: This feature is ideal for saving user preferences, script-specific settings, or counters for tracking usage.

**Note**: Since the configuration is encrypted, properties are secure and cannot be easily accessed outside of VibeScript.

## Relative Loading of Scripts

VibeScript provides a `relative_load()` function to load and execute Lua scripts relative to the directory of the currently running script. This mechanism is useful for modularizing code by allowing scripts to include other scripts located in the same or a relative directory.

### Using `relative_load()`

The `relative_load()` function takes a single parameter, `path`, which specifies the relative path to the script to be loaded. The function constructs the full path by concatenating the current script's directory (`script_dir_name`) with the provided relative path.

Here’s an example of using `relative_load()` to include a utility script:

```lua
-- Load a utility script located in a subdirectory 'utils' relative to the current script
relative_load("utils/helpers.lua")

-- Now you can use functions or variables defined in helpers.lua
print("Helper functions loaded and ready to use.")
```

### How It Works

- **Path Resolution**: The function temporarily changes the global `filename` variable to the resolved path of the target script using `dtw.concat_path(script_dir_name, path)`.
- **File Existence Check**: It checks if the target file exists using `dtw.isfile()`. If the file does not exist, it throws an error with the path of the missing file.
- **Execution**: If the file exists, it is executed using `dofile()`, which runs the Lua code in the current environment.
- **State Restoration**: After execution, the original values of `script_dir_name` and `filename` are restored to ensure that the loading process does not affect the state of the calling script.

**Note**: If the specified file does not exist, an error is thrown with a message indicating the missing file's path. Ensure the path is correct and the file exists before calling `relative_load()`.

## Error Handling and Permissions

VibeScript includes robust error handling to prevent crashes and provide meaningful feedback. Errors are typically thrown as Lua exceptions and can be caught using `pcall()` if needed.

### Common Error Scenarios

- **Invalid Permissions**: If permissions passed to `newLLM()` are not a table or contain non-boolean values, an error is thrown.
- **File Not Found**: Attempting to add a non-existent file with `add_file()` or execute a missing script will result in an error.
- **Missing Model**: If no model is configured or the default model is not set, creating an LLM instance may fail with an error like "no model configured".

### Example: Handling Errors

```lua
-- Safely initialize an LLM with error handling
local status, llm = pcall(function()
    return newLLM({
        read = true,
        write = true
    })
end)

if not status then
    print(private_vibescript.RED .. "Error creating LLM: " .. llm .. private_vibescript.RESET)
    os.exit(1)
end

-- Use the LLM safely
llm.add_user_prompt("Hello, how are you?")
local response = llm.generate()
print("Response: " .. response)
```

### Best Practices

- Always validate inputs before passing them to LLM functions or file operations.
- Use `pcall()` for critical operations to gracefully handle failures.
- Ensure at least one model is configured in VibeScript before attempting to create an LLM instance (see `vibescript configure_model` command).

## Conclusion

The VibeScript Native API provides a rich set of tools for interacting with LLMs, managing files, and maintaining state through persistent properties. By leveraging built-in libraries, custom functions, relative script loading, and secure configuration management, developers can create powerful AI-driven scripts and chatbots. This documentation, with its detailed examples, should serve as a comprehensive guide to harnessing the full potential of VibeScript.