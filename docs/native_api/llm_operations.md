# LLM Operations

VibeScript allows you to create instances of Large Language Models (LLMs) to interact with AI services. The `newLLM()` function initializes an LLM with specific permissions, which control the operations the model can perform on your system.

## Creating an LLM Instance

### Basic LLM Initialization

Here's how to create a basic LLM instance with full permissions:

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

Here's an example of defining a custom function to change the color of AI responses:

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