## Cli Usage

### Configure a model
For Configure a model, you just need to call **vibescript** passing **configure_model** as first argument:

```bash
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions   --key "your key"
```

### Interpret a file 
to interpret a file, just call ,and the runtime will interpret **main.lua**
```bash
vibescript main.lua
```


### List Models 
to list the models, you just need to call **vibescript** passing **list_models** as first argument:

```bash
vibescript list_models
```

### Remove Model

For remove a model, you just need to call **vibescript** passing **remove_model** as first argument:

```bash
vibescript remove_model --model grok-2-latest
```

### Set model as Default 
For set a model as default, you just need to call **vibescript** passing **set_model_as_default** as first argument:

```bash
vibescript set_model_as_default --model grok-2-latest
```
### Resset Configuration
For resset the configuration, you just need to call **vibescript** passing **resset** as first argument:

```bash
vibescript resset_config
```

### Get Help
For get help, you just need to call **vibescript** passing **help** as first argument:

```bash
vibescript help
```

### Add Script
To add a script, you just need to call **vibescript** passing **add_script** as the first argument, followed by the script name and the file path:

```bash
vibescript add_script --file /path/to/script.lua script_name
```

### Remove Script
To remove a script, you just need to call **vibescript** passing **remove_script** as the first argument, followed by the script name:

```bash
vibescript remove_script script_name
```

### List Scripts
To list all scripts, you just need to call **vibescript** passing **list_scripts** as the first argument. Optionally, you can provide a prefix to filter the scripts:

```bash
vibescript list_scripts [prefix]
```
### Interpret a Script with a specified name 
To interpret a script with a specified name, you just need to call **vibescript** passing **interpret_script** as the first argument, followed by the script name:

```bash
vibescript add_script --file /path/to/script.lua script_name
vibescript script_name
```