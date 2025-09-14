# Managing Persistent Properties

VibeScript provides a mechanism to store and retrieve persistent properties across script executions using the configuration file. This feature is implemented in `luasrc/props.lua` and allows scripts to maintain state or settings over time.

## Functions for Property Management

- `get_prop(prop_name)`: Retrieves the value of a specified property from the configuration. Returns an empty table `{}` if the property does not exist.
- `set_prop(prop_name, prop_value)`: Sets a property value in the configuration and saves it. Overwrites the existing value if the property already exists.

## Example: Storing and Retrieving User Preferences

Here's an example of using persistent properties to store a user's preferred AI response color:

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

## How It Works

- **Storage**: Properties are stored in the `props` field of the configuration JSON, which is encrypted and saved to disk.
- **Persistence**: Changes made with `set_prop()` persist across different VibeScript invocations, allowing scripts to remember settings or state.
- **Use Cases**: This feature is ideal for saving user preferences, script-specific settings, or counters for tracking usage.

**Note**: Since the configuration is encrypted, properties are secure and cannot be easily accessed outside of VibeScript.

## Relative Loading of Scripts

VibeScript provides a `relative_load()` function to load and execute Lua scripts relative to the directory of the currently running script. This mechanism is useful for modularizing code by allowing scripts to include other scripts located in the same or a relative directory.

### Using `relative_load()`

The `relative_load()` function takes a single parameter, `path`, which specifies the relative path to the script to be loaded. The function constructs the full path by concatenating the current script's directory (`script_dir_name`) with the provided relative path.

Here's an example of using `relative_load()` to include a utility script:

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