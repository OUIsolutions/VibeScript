
# Script Management

This section covers the management of Lua scripts within VibeScript, including adding, removing, listing, and executing stored scripts.

## Adding Scripts

### Adding Scripts by File Reference

To register a script from a local file path, use the `add_script` command with the `--file` flag:

```bash
vibescript add_script --file /path/to/script.lua <script_name>
```

To include a description for better organization:

```bash
vibescript add_script --file /path/to/script.lua <script_name> --description "Script description"
```

### Adding Scripts by URL

To register a script from a remote URL, use the `--url` flag:

```bash
vibescript add_script --url https://example.com/script.lua <script_name>
```

Optional description can be added:

```bash
vibescript add_script --url https://example.com/script.lua <script_name> --description "Remote script description"
```

### Creating Script Copies

By default, scripts are added by reference. To create a local copy instead of maintaining a reference, use the `--copy` flag:

```bash
vibescript add_script --file /path/to/script.lua <script_name> --copy
```

This option is useful when you want to ensure the script remains available even if the original file is moved or deleted.

## Removing Scripts

To unregister a script from VibeScript:

```bash
vibescript remove_script <script_name>
```

## Listing Scripts

To view all registered scripts:

```bash
vibescript list_scripts
```

To filter scripts by name prefix:

```bash
vibescript list_scripts <prefix>
```

## Executing Registered Scripts

To execute a previously registered script by name:

```bash
vibescript <script_name>
```

**Example workflow:**
```bash
# Register a script
vibescript add_script --file /path/to/my_script.lua my_script

# Execute the registered script
vibescript my_script
```