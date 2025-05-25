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

## DTW LIBRARY REFERENCE

DoTheWorld (DTW) is a comprehensive library for file system operations, path manipulation, hashing, resource management, and more. It provides powerful abstractions for handling files, directories, and data structures.

### Basic File Operations

#### `dtw.load_file(path) -> string|nil`
Reads content from a file.
- **path**: (string) Path to the file
- **Returns**: (string|nil) File content or nil if file doesn't exist

#### `dtw.write_file(path, content) -> nil`
Writes content to a file, creating it if it doesn't exist.
- **path**: (string) Path to the file
- **content**: (string) Content to write

### Directory Operations

#### `dtw.copy_any_overwriting(source, destination) -> nil`
Copies a file or directory, overwriting the destination if it exists.
- **source**: (string) Source path
- **destination**: (string) Destination path

#### `dtw.copy_any_merging(source, destination) -> nil`
Copies a file or directory, merging with destination if it exists.
- **source**: (string) Source path
- **destination**: (string) Destination path

#### `dtw.move_any_overwriting(source, destination) -> nil`
Moves a file or directory, overwriting the destination if it exists.
- **source**: (string) Source path
- **destination**: (string) Destination path

#### `dtw.move_any_merging(source, destination) -> nil`
Moves a file or directory, merging with destination if it exists.
- **source**: (string) Source path
- **destination**: (string) Destination path

#### `dtw.remove_any(path) -> nil`
Removes a file or directory.
- **path**: (string) Path to remove

### Directory Listing

#### `dtw.list_files(path, concat_path) -> table, number`
Lists files in a directory.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of file names and count

#### `dtw.list_dirs(path, concat_path) -> table, number`
Lists subdirectories in a directory.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of directory names and count

#### `dtw.list_all(path, concat_path) -> table, number`
Lists all files and directories in a directory.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of file and directory names and count

#### `dtw.list_files_recursively(path, concat_path) -> table, number`
Lists all files in a directory and its subdirectories.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of file names and count

#### `dtw.list_dirs_recursively(path, concat_path) -> table, number`
Lists all subdirectories in a directory and its subdirectories.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of directory names and count

#### `dtw.list_all_recursively(path, concat_path) -> table, number`
Lists all files and directories in a directory and its subdirectories.
- **path**: (string) Directory path
- **concat_path**: (boolean, optional) Whether to include full path in results
- **Returns**: (table, number) Array of file and directory names and count

### Base64 Encoding/Decoding

#### `dtw.base64_encode(content) -> string`
Encodes a string to base64.
- **content**: (string) Content to encode
- **Returns**: (string) Base64-encoded string

#### `dtw.base64_decode(base64_string) -> string`
Decodes a base64 string.
- **base64_string**: (string) Base64-encoded string
- **Returns**: (string) Decoded content

#### `dtw.base64_encode_file(path) -> string`
Reads a file and encodes its content to base64.
- **path**: (string) Path to the file
- **Returns**: (string) Base64-encoded content

### File Metadata

#### `dtw.get_entity_last_modification(path) -> string`
Gets the last modification date of a file or directory.
- **path**: (string) Path to the file or directory
- **Returns**: (string) Last modification date as formatted string

#### `dtw.get_entity_last_modification_in_unix(path) -> number`
Gets the last modification date of a file or directory as Unix timestamp.
- **path**: (string) Path to the file or directory
- **Returns**: (number) Last modification date as Unix timestamp

### Hashing Functions

#### `dtw.generate_sha(content) -> string`
Generates SHA-256 hash of a string.
- **content**: (string) Content to hash
- **Returns**: (string) SHA-256 hash

#### `dtw.generate_sha_from_file(path) -> string`
Generates SHA-256 hash of a file's content.
- **path**: (string) Path to the file
- **Returns**: (string) SHA-256 hash

#### `dtw.generate_sha_from_folder_by_content(path) -> string`
Generates SHA-256 hash based on folder's content.
- **path**: (string) Path to the folder
- **Returns**: (string) SHA-256 hash

#### `dtw.generate_sha_from_folder_by_last_modification(path) -> string`
Generates SHA-256 hash based on folder's last modification times.
- **path**: (string) Path to the folder
- **Returns**: (string) SHA-256 hash

#### `dtw.newHasher() -> hasher_object`
Creates a new hasher object for combining multiple hashes.
- **Returns**: Hasher object with methods:
  - `hasher:digest(content) -> nil`: Add content to hash
  - `hasher:digest_file(path) -> nil`: Add file content to hash
  - `hasher:digest_folder_by_content(path) -> nil`: Add folder content to hash
  - `hasher:get_value() -> string`: Get combined SHA-256 hash

### Path Manipulation

#### `dtw.newPath(path_string) -> path_object`
Creates a path object for manipulating paths.
- **path_string**: (string) Path string
- **Returns**: Path object with methods:
  - `path:get_name() -> string`: Get filename
  - `path:get_dir() -> string`: Get directory part
  - `path:get_extension() -> string`: Get file extension
  - `path:get_full_path() -> string`: Get full path string
  - `path:get_sub_dirs_from_index(start, end) -> string`: Extract subdirectories
  - `path:set_dir(dir) -> nil`: Set directory part
  - `path:set_name(name) -> nil`: Set filename
  - `path:set_extension(extension) -> nil`: Set extension
  - `path:insert_dir_after(ref_dir, new_dir) -> nil`: Insert directory after reference
  - `path:insert_dir_before(ref_dir, new_dir) -> nil`: Insert directory before reference
  - `path:insert_dir_at_index(index, new_dir) -> nil`: Insert directory at specific position
  - `path:replace_dirs(old_dir, new_dir) -> nil`: Replace directory in path

### Transactions

#### `dtw.newTransaction() -> transaction_object`
Creates a transaction for atomic file operations.
- **Returns**: Transaction object with methods:
  - `transaction:write(path, content) -> nil`: Add write operation
  - `transaction:remove_any(path) -> nil`: Add remove operation
  - `transaction:copy_any(source, dest) -> nil`: Add copy operation
  - `transaction:commit() -> nil`: Execute all operations
  - `transaction:dump_to_json_string() -> string`: Serialize transaction to JSON
  - `transaction:each(callback) -> nil`: Iterate through operations

#### `dtw.new_transaction_from_file(path) -> transaction_object`
Loads a transaction from a JSON file.
- **path**: (string) Path to JSON transaction file
- **Returns**: Transaction object

### Resource Management

#### `dtw.newResource(path) -> resource_object`
Creates a resource object for managing files and folders.
- **path**: (string) Path to resource
- **Returns**: Resource object with methods:
  - `resource:get_value() -> string`: Get file content
  - `resource:set_value(content) -> nil`: Set file content
  - `resource:sub_resource(name) -> resource_object`: Get child resource
  - `resource:get_value_from_sub_resource(name) -> string`: Get child resource content
  - `resource:set_value_in_sub_resource(name, content) -> nil`: Set child resource content
  - `resource:commit() -> nil`: Apply all changes
  - `resource:destroy() -> nil`: Delete the resource
  - `resource:list() -> table, number`: List child resources
  - `resource:each(callback) -> nil`: Iterate through child resources
  - `resource:map(callback) -> table, number`: Transform child resources
  - `resource:find(predicate) -> resource_object`: Find child resource
  - `resource:filter(predicate) -> table, number`: Filter child resources
  - `resource:sub_resource_now(extension) -> resource_object`: Create timestamped resource
  - `resource:sub_resource_now_in_unix(extension) -> resource_object`: Create Unix timestamped resource
  - `resource:sub_resource_random(extension) -> resource_object`: Create random named resource
  - `resource:sub_resource_next(extension) -> resource_object`: Create sequentially named resource

### Database Schema

#### `resource:newDatabaseSchema() -> schema_object`
Creates a database schema for resource.
- **Returns**: Schema object with methods:
  - `schema:sub_schema(name) -> schema_object`: Create subschema
  - `schema:add_primary_keys(keys) -> nil`: Define primary keys
  - `schema:schema_new_insertion() -> resource_object`: Create new record
  - `schema:get_resource_matching_primary_key(key, value) -> resource_object`: Find by primary key
  - `schema:schema_list() -> table, number`: List all records
  - `schema:schema_each(callback) -> nil`: Iterate through records
  - `schema:schema_map(callback) -> table, number`: Transform records
  - `schema:schema_filter(predicate) -> table, number`: Filter records

### Tree Management

#### `dtw.newTree() -> tree_object`
Creates an empty tree for managing a set of files.
- **Returns**: Tree object with methods:
  - `tree:newTreePart_empty(path) -> tree_part`: Create empty tree part
  - `tree:commit() -> nil`: Apply all changes
  - `tree:each(callback) -> nil`: Iterate through tree parts
  - `tree:map(callback) -> table, number`: Transform tree parts
  - `tree:count(predicate) -> number`: Count matching tree parts
  - `tree:find(predicate) -> tree_part`: Find matching tree part

#### `dtw.newTree_from_hardware(path) -> tree_object`
Creates a tree from existing directory.
- **path**: (string) Path to directory
- **Returns**: Tree object

#### Tree Part Operations
Tree parts have the following methods:
- `tree_part:get_value() -> string`: Get file content
- `tree_part:set_value(content) -> nil`: Set file content
- `tree_part:hardware_write() -> nil`: Write changes (create new if path changed)
- `tree_part:hardware_modify() -> nil`: Apply changes (rename if path changed)
- `tree_part:hardware_remove() -> nil`: Remove file

### Process Management

#### `dtw.newFork(callback) -> fork_object`
Creates a forked process.
- **callback**: (function) Function to run in forked process
- **Returns**: Fork object with methods:
  - `fork:wait(timeout_ms) -> nil`: Wait for process to complete
  - `fork:is_alive() -> boolean`: Check if process is running
  - `fork:kill() -> nil`: Terminate the process

### Concurrency Control

#### `dtw.newLocker() -> locker_object`
Creates a file-based locking mechanism.
- **Returns**: Locker object with methods:
  - `locker:lock(resource_name) -> nil`: Acquire lock
  - `locker:unlock(resource_name) -> nil`: Release lock

## BUILT-IN LIBRARIES

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

### Example 3: File Operations with DTW
```lua
-- Read and write files
local content = dtw.load_file("input.txt")
dtw.write_file("output.txt", content .. "\nAppended text")

-- List directory contents
local files, count = dtw.list_files(".", true)
for i = 1, count do
    print("File: " .. files[i])
end

-- Create a resource
local res = dtw.newResource("data")
res:set_value_in_sub_resource("config.json", '{"enabled":true}')
res:commit()

-- Create a tree from directory
local tree = dtw.newTree_from_hardware("src")
tree:each(function(part)
    if part.path:get_extension() == "lua" then
        print("Lua file: " .. part.path:get_full_path())
    end
end)
```

### Example 4: Persistent Properties
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