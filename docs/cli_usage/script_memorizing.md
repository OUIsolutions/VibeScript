
### Add Script By Reference
To add a script, you just need to call **vibescript** passing **add_script** as the first argument, followed by the script name and the file path. Optionally, you can add a description:

```bash
vibescript add_script --file /path/to/script.lua script_name
```

Or with a description:

```bash
vibescript add_script --file /path/to/script.lua script_name --description "Your script description"
```
### Add Script By Url 
To add a script by URL, you just need to call **vibescript** passing **add_script** as the first argument, followed by the script name and the URL. Optionally, you can add a description:

```bash
vibescript add_script --url https://example.com/script.lua script_name
```

### Making it a  copy instead of reference
if you pass the --copy flag, it will make a copy of the script instead of just referencing it:

```bash
vibescript add_script --file /path/to/script.lua script_name --copy
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