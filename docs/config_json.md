# VibeScript Configuration JSON

The VibeScript application uses a configuration JSON file to store various settings, including model configurations and script aliases. This document explains the structure and usage of this configuration file.

## Location

The configuration file is stored in a platform-specific location:

- **Windows**: `%APPDATA%\<config_hash>`
- **Linux/Mac**: `~/.config/<config_hash>`

Where `<config_hash>` is a unique identifier generated based on an encryption key.

You can also specify a custom configuration file location using the `--config` flag when running VibeScript commands.

## Structure

The configuration JSON has the following structure:

```json
{
  "models": [
    {
      "name": "model-name",
      "url": "https://api.example.com/v1/chat/completions",
      "key": "your-api-key"
    }
  ],
  "scripts": [
    {
      "name": "script-alias",
      "file": "/absolute/path/to/script.lua",
      "description": "Optional description of the script"
    }
  ],
  "default_model": "model-name"
}
```

### Models

The `models` array contains configurations for different AI models that can be used with VibeScript.

Each model object has the following properties:

- `name`: A unique identifier for the model (e.g., "gpt-4o", "grok-2-latest").
- `url`: The API endpoint URL for the model.
- `key`: The API authentication key for accessing the model.

### Scripts

The `scripts` array contains aliases for script files, allowing you to reference them by name when running VibeScript.

Each script object has the following properties:

- `name`: The alias or shortname for the script.
- `file`: The absolute path to the Lua script file.
- `description`: (Optional) A text description of what the script does.

### Default Model

The `default_model` property specifies which model should be used by default when no model is explicitly specified. This should match the name of one of the models defined in the `models` array.

## Security

The configuration file is encrypted to protect sensitive information like API keys. The encryption uses:

1. A name encryption key for the file name
2. A content encryption key for the file content
3. An LLM-specific encryption key

## Management

You don't need to manually edit this JSON file. VibeScript provides several commands to manage the configuration:

- **Add a model**: `vibescript configure_model --model <name> --url <url> --key <key>`
- **Remove a model**: `vibescript remove_model --model <name>`
- **List models**: `vibescript list_models`
- **Set default model**: `vibescript set_model_as_default --model <name>`
- **Reset configuration**: `vibescript reset_config`
- **Add a script alias**: `vibescript add_script --file /path/to/script.lua script_name [description]`
- **Remove a script alias**: `vibescript remove_script script_name`
- **List scripts**: `vibescript list_scripts [prefix]`

## Example Usage

After configuring your models and scripts, you can use them as follows:

```bash
# Use the default model
vibescript your_script.lua

# Use a specific model
vibescript your_script.lua --model grok-2-latest

# Use a script alias
vibescript script_name
```