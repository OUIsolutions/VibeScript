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

### Argv


## Getting  normal args
```lua
---@type Argv


local size = argv.get_total_args_size()
for i = 1, size do
    print(argv.get_arg_by_index(i))
end
```

## Geting flags
you can get flags by:
```lua
---@type Argv
---@type Argv

local index = 1
local default = "test"
local first_out_flag = argv.get_flag_arg_by_index({ "out", "output", "o" }, index, default)
print(first_out_flag)
```
if you run:
```shell
lua teste.lua -out test
```
it will appear these:
```txt
test
```


## Getting Flags Size
```lua
---@type Argv

local size = argv.get_flag_size({ "out", "o" })
print(size)
```

## Checking if a flag exist
you can check if a flag its present our not, by:
```lua
---@type Argv

---@type boolean
local exist = argv.flags_exist({ "case_sensitive", "cs" })
print(exist)
```

## Getting Flags by index Consider only the first
Considerring only first arg of flag, can make your conde more solid, and
easy to read:
```lua
---@type Argv

local index = 1
local default = "test"
local first_out_flag = argv.get_flag_arg_by_index_consider_only_first({ "out", "output", "o" }, index, default)
print(first_out_flag)
```

### Getting Flags Size Consider only the first
```lua
---@type Argv

local size = argv.get_flag_size_consider_only_first({ "out", "o" })
print(size)
```


## Compact flags
its also possible to get comppact flags (the gcc model), witch increases
readiability of the software:

```lua
---@type Argv

local index = 1
local default = "my default conf"
local first_conf = argv.get_compact_flags({ "conf:", "conf=" }, index, default)
print(first_conf)
```
if you run:
```shell
lua teste.lua conf:test a b
```
if will show:
```txt
test
```
## Compact Flags size
You also can get the compact flags size
```lua

local conf_flags = { "conf:", "conf=" }
local size = argv.get_compact_flags_size(conf_flags)
for i = 1, size do
    local current_conf = argv.get_compact_flags(conf_flags, i)
    print("conf " .. i .. ":" .. current_conf)
end
```
if you run:
```shell
 lua teste.lua conf=a conf:b
```
the output will be:
```txt
conf 1:b
conf 2:a
```
## Unused flags
with unsed and unused flags, you can make complex CLIS, by combining flags and args

```lua

--these its required to mark as used
argv.get_arg_by_index(1)
argv.get_arg_by_index(2)
local output = argv.get_flag_arg_by_index({ "out", "o" }, 1)
if not output then
    print("output its required")
    return
end
local entry = argv.get_next_unused()
if not entry then
    print("entry its required")
    return
end
local error_flag = argv.get_next_unused()
if error_flag then
    print("unused flag", error_flag)
    return
end

print("output:", output)
print("entry:", entry)

```



### Json Operations 

### Dumping JSON

#### To File

Dump a Lua table to a JSON file:

```lua


local user = {
    name = 'Mateus',
    age = 27,
    married = false,
    children = {
        {name = 'Child1', married = 'null'}
    }
}

-- The second parameter is the file path, third parameter enables indentation
local indent = true
json.dumps_to_file(user, "output.json", indent)
```

#### To String

Convert a Lua table to a JSON string:

```lua


local user = {
    name = 'Mateus',
    age = 27,
    married = true,
    children = {
        {name = 'Child1', married = false}
    }
}

local indent = true
local jsonString = json.dumps_to_string(user, indent)
print(jsonString)
```

### Loading JSON

#### From File

Parse a JSON file into a Lua table:

```lua


local parsed = json.load_from_file("data.json")

print("Name: " .. parsed.name)
print("Age: " .. parsed.age)
print("Married: " .. tostring(parsed.married))

for i, child in ipairs(parsed.children) do
    print("Child name: " .. child.name)
end
```

#### From String

Parse a JSON string into a Lua table:

```lua


local jsonString = '{"name":"Mateus","age":27}'
local parsed = json.load_from_string(jsonString)

print("Name: " .. parsed.name)
print("Age: " .. parsed.age)
```

### Handling NULL Values

#### Default NULL Handling

Since Lua's `nil` doesn't work the same way as `null` in other languages, the library treats the string `"null"` as a JSON null value:

```lua


local user = {
    name = 'Mateus',
    age = 27,
    married = false,
    children = 'null'  -- This will be parsed as JSON null
}

local indent = true
json.dumps_to_file(user, "output.json", indent)
```

#### Custom NULL Value

You can set a custom string to represent null values:

```lua


-- Set a custom null identifier
json.set_null_code("custom_null")

local user = {
    name = 'Mateus',
    age = 27,
    married = false,
    children = 'custom_null'  -- This will be parsed as JSON null
}

local indent = true
json.dumps_to_file(user, "output.json", indent)
```

### Type Detection

If you need to ensure that a table is parsed as a JSON object (rather than an array), you can use the `is_table_a_object` function:

```lua


local array = {1, 2, 3}
print(json.is_table_a_object(array))  -- false (it's an array)

local object = {a = 20, b = 30}
print(json.is_table_a_object(object))  -- true (it's an object)
```

## Summary
VibeScript's Native API enables interaction with LLMs through `newLLM()`, permissions, context addition, custom functions, and persistent properties. Use built-in libraries (`dtw`, `json`, etc.) for file and data operations. This simplified guide covers the most critical aspects for effective LLM integration.