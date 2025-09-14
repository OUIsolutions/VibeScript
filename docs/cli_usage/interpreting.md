
# Script Interpretation

VibeScript supports multiple methods for executing Lua scripts. This document outlines the available interpretation modes.

## File-Based Interpretation

To interpret a local Lua file, create the script and execute it directly:

```lua
print("Hello, World!")
```

Execute the script using:
```bash
vibescript hello.lua
```

## URL-Based Interpretation

Scripts can be executed directly from remote URLs without downloading:

```bash
vibescript https://raw.githubusercontent.com/OUIsolutions/VibeScript/refs/heads/new_version/extra/hello_world.lua
```

## Memory-Based Interpretation

Scripts can be stored in memory for convenient reuse. First, add a script to memory:

```bash
vibescript add_script --file hello.lua hello
```

Then execute the stored script by name:
```bash
vibescript hello
```

## Index-Based Interpretation

Memorized scripts can be executed using their list index. View available scripts:

```bash
vibescript list
```

Output example:
```
1: teste
2: hello_world
3: hello
```

Execute a script by its index number:
```bash
vibescript 3
```
