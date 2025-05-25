# VIBESCRIPT NATIVE API REFERENCE

## OVERVIEW

VibeScript is a Lua runtime environment that integrates LLM capabilities into Lua scripts, enabling AI-driven automation workflows.

## FUNCTION REFERENCE

### LLM Core Functions

#### `newLLM(permissions_table) -> llm_object`
Creates a new LLM instance with specified permissions.
- **permissions_table**: (table) Contains boolean values:
  - `read`: (boolean) Allow file reading
  - `write`: (boolean) Allow file writing
  - `execute`: (boolean) Allow command execution
  - `delete`: (boolean) Allow file/directory deletion
  - `list`: (boolean) Allow directory listing
- **Returns**: LLM object with the following methods:

#### `llm:add_system_prompt(text) -> nil`
Sets system instructions for the LLM.
- **text**: (string) System instructions

#### `llm:add_user_prompt(text) -> nil`
Adds user message to conversation.
- **text**: (string) User message

#### `llm:add_assistant_prompt(text) -> nil`
Adds assistant response to conversation history.
- **text**: (string) Assistant response

#### `llm:add_file(path) -> nil`
Adds file content to LLM context.
- **path**: (string) Path to file

#### `llm:add_dir(path) -> nil`
Adds directory content to LLM context.
- **path**: (string) Path to directory

#### `llm:generate() -> string`
Generates LLM response based on conversation history.
- **Returns**: (string) LLM response text

#### `llm:add_function(name, description, parameters, callback) -> nil`
Registers a function that LLM can call.
- **name**: (string) Function name
- **description**: (string) Function description
- **parameters**: (table) Array of parameter objects:
  ```lua
  {
    name = "param_name", -- (string) Parameter name
    description = "param_description", -- (string) Parameter description
    type = "string|number|boolean|array|object", -- (string) Parameter type
    required = true|false -- (boolean) Whether parameter is required
  }
  ```
- **callback**: (function) Function called when LLM invokes this function
  - Receives: (table) Arguments passed by LLM
  - Returns: (any) Value returned to LLM

### Property Storage Functions

#### `get_prop(prop_name) -> value`
Retrieves a stored property value.
- **prop_name**: (string) Property name
- **Returns**: (any) Stored value or nil if not found

#### `set_prop(prop_name, prop_value) -> nil`
Stores a property value persistently.
- **prop_name**: (string) Property name
- **prop_value**: (any) Value to store

### Module Loading

#### `relative_load(path_to_script) -> nil`
Loads a Lua script relative to current script path.
- **path_to_script**: (string) Relative path to Lua script

## CODE EXAMPLES

### Example 1: Basic LLM Usage
```lua
-- Create LLM with read and write permissions
local llm = newLLM({
    read = true,
    write = true,
    execute = false,
    delete = false,
    list = true
})

-- Set instructions and context
llm:add_system_prompt("You are a helpful assistant.")
llm:add_file("data.txt")
llm:add_user_prompt("Summarize the data from the file.")

-- Generate response
local response = llm:generate()
print(response)
```

### Example 2: Custom Functions
```lua
-- Create LLM with no permissions
local llm = newLLM({})

-- Define parameters for function
local parameters = {
    {
        name = "operation",
        description = "Math operation to perform",
        type = "string",
        required = true
    },
    {
        name = "numbers",
        description = "Numbers to operate on",
        type = "array",
        required = true
    }
}

-- Define callback function
local function math_callback(args)
    local operation = args.operation
    local numbers = args.numbers
    local result = 0
    
    if operation == "add" then
        for _, num in ipairs(numbers) do
            result = result + num
        end
        return {result = result}
    elseif operation == "multiply" then
        result = 1
        for _, num in ipairs(numbers) do
            result = result * num
        end
        return {result = result}
    else
        return {error = "Unsupported operation"}
    end
end

-- Register function with LLM
llm:add_function(
    "calculate", 
    "Perform math operations", 
    parameters, 
    math_callback
)

-- Test the function
llm:add_user_prompt("Calculate 5 + 10 + 15")
local response = llm:generate()
print(response)
```

### Example 3: Persistent Properties
```lua
-- Get existing property or set default
local counter = get_prop("usage_counter")
if type(counter) ~= "number" then
    counter = 0
end

-- Update property
counter = counter + 1
set_prop("usage_counter", counter)
print("This script has been run " .. counter .. " times.")
```

## BUILT-IN LIBRARIES

### DTW Library (File Operations)
File and directory operations library.

#### Common Functions:
- `dtw.read_file(path) -> string`: Read file contents
- `dtw.write_file(path, content)`: Write content to file
- `dtw.list_dir(path) -> table`: List directory contents
- `dtw.exists(path) -> boolean`: Check if file/directory exists
- `dtw.delete(path)`: Delete file/directory

### JSON Library
JSON serialization and parsing.

#### Functions:
- `json.dumps_to_string(table, pretty) -> string`: Convert table to JSON string
- `json.dumps_to_file(table, filepath, pretty)`: Write table as JSON to file
- `json.load_from_string(jsonstring) -> table`: Parse JSON string to table
- `json.load_from_file(filepath) -> table`: Parse JSON file to table
- `json.set_null_code(nullcode)`: Set custom null representation
- `json.is_table_a_object(table) -> boolean`: Check if table is a JSON object

### ARGV Library (Command-line Parsing)
Parse command line arguments.

#### Functions:
- `argv.get_total_args_size() -> number`: Get number of arguments
- `argv.get_arg_by_index(index) -> string`: Get argument by position
- `argv.get_flag_arg_by_index(flags, index, default) -> string`: Get flag value
- `argv.get_flag_size(flags) -> number`: Count flag occurrences
- `argv.flags_exist(flags) -> boolean`: Check if flag exists
- `argv.get_next_unused() -> string`: Get next unused argument

### SHIP Library (Container Management)
Manage Docker/Podman containers.

#### Functions:
- `ship.create_machine(image) -> machine`: Create container machine object
- `machine.provider = "docker"|"podman"`: Set container provider
- `machine.add_comptime_command(command)`: Add build command
- `machine.copy(source, destination)`: Copy files to container
- `machine.start(options)`: Start container with configuration

## PERMISSION SECURITY MODEL

LLM instances require explicit permissions:

| Permission | Description                            |
|------------|----------------------------------------|
| read       | Access file contents                   |
| write      | Create or modify files                 |
| execute    | Run system commands                    |
| delete     | Delete files or directories            |
| list       | List directory contents                |

## ERROR HANDLING PATTERN

```lua
-- Safe LLM creation with error handling
local status, llm = pcall(function()
    return newLLM({read = true, write = true})
end)

if not status then
    print("ERROR: " .. llm) -- Error message in llm variable
    os.exit(1)
end

-- Continue with LLM operations
local response = llm:generate()
```