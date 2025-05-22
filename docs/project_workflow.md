# VibeScript Project Workflow Documentation

This document provides a detailed explanation of the workflow and operational logic of the VibeScript project, based on the main entry point defined in `luasrc/main.lua`. The workflow is broken down into steps, conditions, and pseudo-code to illustrate how VibeScript processes commands, manages configurations, and executes scripts or actions.


## Workflow Steps

Below are the detailed steps of the VibeScript workflow, as derived from `luasrc/main.lua`. Each step includes conditions and pseudo-code to clarify the decision-making process and actions taken by the system.

### Step 1: Initialize the Environment

- **Description**: The workflow begins by initializing the environment and setting up necessary components for execution. This includes loading the configuration JSON and preparing the argument parser.
- **Action**: Call `private_vibescript.internal_main()` wrapped in a protected call (`pcall`) to handle errors gracefully.
- **Pseudo-Code**:
  ```
  function main()
      argv.get_next_unused()  // Start processing command-line arguments
      ok, error = pcall(private_vibescript.internal_main)
      if not ok then
          print(RED .. error .. RESET)  // Display error in red color
          exit(1)  // Exit with failure status
      end
      exit(0)  // Exit with success status
  end
  ```

### Step 2: Load Configuration JSON

- **Description**: Retrieve the configuration data from the encrypted file. This file contains models, scripts, and other settings necessary for VibeScript operations.
- **Action**: Use `private_vibescript.get_config_json()` to load and decrypt the configuration.
- **Conditions**:
  - If the config file exists, decrypt and parse it into a JSON object.
  - If the file does not exist, initialize an empty configuration with default structure.
- **Pseudo-Code**:
  ```
  config_json = private_vibescript.get_config_json()
  if config_file_not_found then
      config_json = {
          scripts = {},
          models = {},
          props = {}
      }
  end
  ```

### Step 3: Parse Command-Line Arguments for Actions

- **Description**: Identify the primary action or script to execute based on the first unused command-line argument.
- **Action**: Extract the action using `argv.get_next_unused()`.
- **Conditions**:
  - If an action is provided, proceed to match it against known commands.
  - If no action is provided, it may default to script execution logic later.
- **Pseudo-Code**:
  ```
  action = argv.get_next_unused()
  if action is empty then
      // Proceed to script execution logic in later steps
  else
      // Proceed to action matching
  end
  ```

### Step 4: Configure LLM and Props Functions

- **Description**: Set up the LLM (Large Language Model) interface and properties management functions based on the loaded configuration.
- **Action**: Call `private_vibescript.configure_newRawLLMFunction(config_json)` and `private_vibescript.configure_props_functions(config_json)`.
- **Purpose**: This prepares the system to interact with LLMs for AI operations and manage persistent properties.
- **Pseudo-Code**:
  ```
  private_vibescript.configure_newRawLLMFunction(config_json)  // Setup LLM based on default or first model
  private_vibescript.configure_props_functions(config_json)  // Setup get_prop and set_prop functions
  ```

### Step 5: Check for Version Request

- **Description**: Check if the user is requesting the version of VibeScript.
- **Conditions**:
  - If arguments include "version" or flags like `--version` or `-v`, display the version and exit.
- **Action**: Print the version string and terminate execution.
- **Pseudo-Code**:
  ```
  if argv.one_of_args_exist({"version"}) or argv.flags_exist({"version", "v"}) then
      print("vibescript " .. private_vibescript.VERSION)
      return  // Exit workflow
  end
  ```

### Step 6: Match and Execute Specific Actions

- **Description**: Route the execution to specific functions based on the action provided. VibeScript supports several built-in actions for managing models, scripts, and configurations.
- **Conditions and Actions**:
  - **Reset Configuration**: If action is `RESET_CONFIG`, call `private_vibescript.reset()`.
  - **Add Script**: If action is `ADD_SCRIPT`, call `private_vibescript.add_script(config_json)`.
  - **Remove Script**: If action is `REMOVE_SCRIPT`, call `private_vibescript.remove_script(config_json)`.
  - **List Scripts**: If action is `LIST_SCRIPTS`, call `private_vibescript.list_scripts(config_json)`.
  - **Configure Model**: If action is `CONFIGURE_MODEL`, call `private_vibescript.add_model(config_json)`.
  - **List Models**: If action is `LIST_MODELS`, call `private_vibescript.list_models(config_json)`.
  - **Remove Model**: If action is `REMOVE_MODEL`, call `private_vibescript.remove_model(config_json)`.
  - **Set Default Model**: If action is `SET_MODEL_AS_DEFAULT`, call `private_vibescript.set_model_as_default(config_json)`.
- **Pseudo-Code**:
  ```
  if action == private_vibescript.RESET_CONFIG then
      private_vibescript.reset()
      return
  else if action == private_vibescript.ADD_SCRIPT then
      private_vibescript.add_script(config_json)
      return
  else if action == private_vibescript.REMOVE_SCRIPT then
      private_vibescript.remove_script(config_json)
      return
  else if action == private_vibescript.LIST_SCRIPTS then
      private_vibescript.list_scripts(config_json)
      return
  else if action == private_vibescript.CONFIGURE_MODEL then
      private_vibescript.add_model(config_json)
      return
  else if action == private_vibescript.LIST_MODELS then
      private_vibescript.list_models(config_json)
      return
  else if action == private_vibescript.REMOVE_MODEL then
      private_vibescript.remove_model(config_json)
      return
  else if action == private_vibescript.SET_MODEL_AS_DEFAULT then
      private_vibescript.set_model_as_default(config_json)
      return
  end
  ```

### Step 7: Default to Script Execution

- **Description**: If no specific action is matched, VibeScript assumes the first argument is a script name or file path to execute.
- **Action**: Attempt to resolve the script name to a file path, either from configured scripts or as a direct path.
- **Conditions**:
  - Check if the provided name matches a script in `config_json.scripts`. If found, use the associated file path.
  - If not found in scripts, attempt to resolve it as an absolute path.
  - If the file cannot be resolved, throw an error.
- **Pseudo-Code**:
  ```
  script_name = action
  filename = script_name
  found_filename = false

  for each script in config_json.scripts do
      if script.name == script_name then
          filename = script.file
          found_filename = true
          break
      end
  end

  if not found_filename then
      filename = dtw.get_absolute_path(script_name)
  end

  if not filename then
      error("File (" .. script_name .. ") does not exist")
      return
  end
  ```

### Step 8: Execute the Script

- **Description**: Execute the resolved script file within the VibeScript environment.
- **Action**: Set the script directory and execute the script using `dofile(filename)`.
- **Purpose**: This allows the script to access VibeScript's environment, including LLM functions and configuration data.
- **Pseudo-Code**:
  ```
  script_dir_name = dtw.newPath(filename).get_dir()
  dofile(filename)  // Execute the Lua script
  ```

### Step 9: Handle Errors and Exit

- **Description**: Ensure any errors during execution are caught and displayed to the user with appropriate formatting.
- **Action**: If an error occurs in `internal_main`, it is caught by the `pcall` in `main()` and displayed in red.
- **Pseudo-Code**:
  ```
  if not ok then
      print(private_vibescript.RED .. error .. private_vibescript.RESET)
      os.exit(1)
  end
  os.exit(0)
  ```

## Detailed Action Breakdown

Below is a deeper dive into the specific actions supported by VibeScript, as referenced in Step 6. Each action modifies or interacts with the configuration JSON or performs specific operations.

### Action: Reset Configuration (`reset_config`)

- **Purpose**: Deletes the configuration file to reset VibeScript to a default state.
- **Operation**: Removes the configuration file at the path returned by `get_config_path()`.
- **Pseudo-Code**:
  ```
  path = private_vibescript.get_config_path()
  dtw.remove_any(path)  // Delete the config file
  ```

### Action: Add Script (`add_script`)

- **Purpose**: Registers a new script alias in the configuration for easy reference.
- **Operation**: Validates the provided file path and name, ensures no duplicate exists, and adds the script to `config_json.scripts`.
- **Conditions**:
  - File must exist.
  - Name must not already be in use.
- **Pseudo-Code**:
  ```
  file = argv.get_flag_arg_by_index({private_vibescript.FILE}, 1)
  name = argv.get_next_unused()
  if not file or not name then error("Missing file or name")
  if not dtw.isfile(file) then error("File does not exist")
  absolute_path = dtw.get_absolute_path(file)
  for each script in config_json.scripts do
      if script.name == name then error("Script name already exists")
  end
  config_json.scripts.append({name = name, file = absolute_path})
  private_vibescript.save_config_json(config_json)
  ```

### Action: Remove Script (`remove_script`)

- **Purpose**: Removes a script alias from the configuration.
- **Operation**: Finds and removes the script by name from `config_json.scripts`.
- **Conditions**:
  - Script name must exist in configuration.
- **Pseudo-Code**:
  ```
  name = argv.get_next_unused()
  if not name then error("No script name provided")
  for i = 1 to #config_json.scripts do
      if config_json.scripts[i].name == name then
          table.remove(config_json.scripts, i)
          script_found = true
          break
      end
  end
  if not script_found then error("Script does not exist")
  private_vibescript.save_config_json(config_json)
  ```

### Action: List Scripts (`list_scripts`)

- **Purpose**: Displays a list of registered script aliases, optionally filtered by a prefix.
- **Operation**: Iterates through `config_json.scripts` and prints names, applying a prefix filter if provided.
- **Pseudo-Code**:
  ```
  start_filtrage = argv.get_next_unused()
  for each script in config_json.scripts do
      if start_filtrage and dtw.starts_with(script.name, start_filtrage) then
          print(script.name)
      else if not start_filtrage then
          print(script.name)
      end
  end
  ```

### Action: Configure Model (`configure_model`)

- **Purpose**: Adds a new model configuration to the system for use with LLMs.
- **Operation**: Validates input flags for model name, URL, and key, encrypts the key, and adds the model to `config_json.models`.
- **Conditions**:
  - All required flags (`--model`, `--url`, `--key`) must be provided.
- **Pseudo-Code**:
  ```
  model_name = argv.get_flag_arg_by_index({private_vibescript.MODEL}, 1)
  model_url = argv.get_flag_arg_by_index({private_vibescript.URL}, 1)
  model_key = argv.get_flag_arg_by_index({private_vibescript.KEY}, 1)
  if not model_name or not model_url or not model_key then error("Missing required flag")
  encrypted_key = cvibescript.set_llm_data(model_key)
  model = {name = model_name, url = model_url, key = encrypted_key}
  config_json.models.append(model)  // Note: Bug in original code with duplicate append logic
  private_vibescript.save_config_json(config_json)
  ```

### Action: List Models (`list_models`)

- **Purpose**: Displays all configured models with their names and URLs.
- **Operation**: Iterates through `config_json.models` and prints details.
- **Pseudo-Code**:
  ```
  for each model in config_json.models do
      print("Model Name: " .. model.name)
      print("URL: " .. model.url)
      print("-------------------------")
  end
  ```

### Action: Remove Model (`remove_model`)

- **Purpose**: Removes a model configuration from the system.
- **Operation**: Finds and removes the model by name from `config_json.models`.
- **Conditions**:
  - Model name must exist in configuration.
- **Pseudo-Code**:
  ```
  model_name = argv.get_flag_arg_by_index({private_vibescript.MODEL}, 1)
  if not model_name then error("No model name provided")
  for i = 1 to #config_json.models do
      if config_json.models[i].name == model_name then
          table.remove(config_json.models, i)
          model_found = true
          break
      end
  end
  if not model_found then error("Model does not exist")
  private_vibescript.save_config_json(config_json)
  ```

### Action: Set Model as Default (`set_model_as_default`)

- **Purpose**: Sets a specified model as the default for LLM operations.
- **Operation**: Updates `config_json.default_model` to the specified model name.
- **Conditions**:
  - Model name must exist in configuration.
- **Pseudo-Code**:
  ```
  model_name = argv.get_flag_arg_by_index({private_vibescript.MODEL}, 1)
  if not model_name then error("No model name provided")
  for each model in config_json.models do
      if model.name == model_name then
          config_json.default_model = model_name
          model_found = true
          break
      end
  end
  if not model_found then error("Model does not exist")
  private_vibescript.save_config_json(config_json)
  ```

## Configuration Management

- **Description**: VibeScript uses an encrypted JSON file for persistent storage of models, scripts, and properties. The file path is determined based on the operating system or a custom `--config` flag.
- **Operations**:
  - `get_config_path()`: Determines the path based on OS or custom flag.
  - `get_config_json()`: Loads and decrypts the file, or initializes a default structure.
  - `save_config_json(json_props)`: Serializes, encrypts, and writes the JSON back to the file.
- **Pseudo-Code**:
  ```
  function get_config_path()
      if custom_path = argv.get_flag_arg_by_index({CONFIG}, 1) then
          return custom_path
      else if os_name == "windows" then
          return os.getenv("APPDATA") .. "/" .. cvibescript.get_config_name()
      else
          return os.getenv("HOME") .. "/.config/" .. cvibescript.get_config_name()
      end
  end

  function save_config_json(json_props)
      config_path = get_config_path()
      data = json.dumps_to_string(json_props)
      if not data then error("Serialization failed")
      encrypted = cvibescript.set_data(data)
      if not encrypted then error("Encryption failed")
      dtw.write_file(config_path, encrypted)
  end
  ```

## LLM Integration

- **Description**: VibeScript supports interaction with LLMs through a configured model. It sets up a default model based on `default_model` in the configuration or the first available model.
- **Operations**:
  - Selects a model for interaction.
  - Provides a `newLLM(permissions)` function to create an LLM instance with specified permissions (read, write, execute, delete, list).
  - Allows adding prompts and generating responses.
- **Pseudo-Code**:
  ```
  function configure_newRawLLMFunction(config_json)
      chosed_model = nil
      if config_json.default_model then
          for each model in config_json.models do
              if model.name == config_json.default_model then
                  chosed_model = model
                  break
              end
          end
      end
      if chosed_model == nil then
          chosed_model = config_json.models[1]
      end
      if chosed_model then
          newRawLLM = function()
              return cvibescript.newRawLLM(chosed_model.url, chosed_model.key, chosed_model.name)
          end
      end
  end
  ```

## Error Handling

- **Description**: VibeScript uses a protected call (`pcall`) to catch runtime errors during execution and displays them in a user-friendly format with color coding.
- **Purpose**: Ensures the application does not crash unexpectedly and provides feedback to the user.
- **Pseudo-Code**:
  ```
  ok, error = pcall(private_vibescript.internal_main)
  if not ok then
      print(private_vibescript.RED .. error .. private_vibescript.RESET)
      os.exit(1)
  end
  ```

## Conclusion

The VibeScript workflow is a robust system for managing AI model interactions and script executions through a CLI interface. It prioritizes configuration management with encryption for security, supports multiple actions for model and script handling, and defaults to script execution for custom operations. This detailed step-by-step breakdown, along with pseudo-code, provides a clear understanding of how VibeScript processes user input and manages its internal state.
