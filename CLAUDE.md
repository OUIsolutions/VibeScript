# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

VibeScript is a specialized Lua runtime environment designed for LLM-powered automations. It integrates multiple Lua libraries and provides a native API for interacting with Large Language Models, file systems, and various utilities.

## Build System

The project uses [Darwin](https://github.com/OUIsolutions/Darwin) as its primary build tool. All builds are orchestrated through the `build/` directory structure.

### Essential Build Commands

```bash
# Build amalgamation (single C file)
darwin run_blueprint build/ --mode folder amalgamation_build

# Local Linux build (for development/testing)
darwin run_blueprint build/ --mode folder local_linux_build

# Build for all platforms (requires Docker/Podman)
darwin run_blueprint build/ --mode folder amalgamation_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman

# Local install after Linux build
darwin run_blueprint build/ --mode folder local_linux_build --local_linux_install
```

### Quick Amalgamation Build (Alternative)
```bash
# Download and compile amalgamation directly
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.32.0/vibescript.c -o amalgamation.c
gcc amalgamation.c -o vibescript
```

## Architecture

### Core Components

- **`luasrc/`** - Lua source files for the runtime
  - `main.lua` - Entry point and main runtime logic
  - `llm.lua` - LLM integration and API functions
  - `actions/` - CLI command implementations
  - `constants/` - Configuration constants

- **`csrc/`** - C source files for native extensions
  - `start.c` - C runtime initialization
  - `imports/` - C header imports and dependencies
  - `llm/` - Native LLM function implementations
  - `encription/` - Encryption utilities

- **`build/`** - Build system configuration and scripts
  - `config.lua` - Project configuration (name, version, etc.)
  - `main.lua` - Build orchestration logic
  - `build/` - Individual build target implementations

- **`dependencies/`** - External Lua libraries integrated into the runtime

### Build Dependencies and Tools

The build system relies on several specialized tools:

- **LuaArgv** - Command-line argument parsing
- **LuaDoTheWorld** - File system operations and utilities
- **LuaShip** - Docker/Podman container management for cross-platform builds
- **LuaSilverChain** - C code import order organization
- **LuaCAmalgamator** - Single-file C code generation

### Import Order (SilverChain)

C files are organized with specific import precedence:
1. `dep_declare` - Dependency declarations
2. `macros` - Preprocessor macros
3. `types` - Type definitions
4. `consts` - Constants
5. `fdeclare` - Function declarations
6. `globals` - Global variables
7. `fdefine` - Function definitions

## Runtime Usage

### CLI Commands

```bash
# Configure LLM model
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions --key "your_key"

# Run Lua script
vibescript main.lua

# Model management
vibescript list_models
vibescript remove_model --model model_name
vibescript set_model_as_default --model model_name

# Script management
vibescript add_script --file /path/to/script.lua script_name
vibescript remove_script script_name
vibescript list_scripts
vibescript script_name  # Run named script

# Reset configuration
vibescript resset_config
```

### Native API Usage

VibeScript provides built-in libraries accessible in Lua scripts:

- `dtw` - File operations (LuaDoTheWorld)
- `json` - JSON parsing (LuaFluidJson)  
- `argv` - Argument parsing (LuaArgv)
- `ship` - Container management (LuaShip)
- `serjao` - Web server (SerjaoBerranteiro)
- `luabear` - HTTP client (Lua-Bear)
- `webdriver` - Browser automation (LuaWebDriver)
- `luaberrante` - Telegram API (LuaBerrante)
- `heregitage` - Object-oriented programming (LuaHeritage)
- `clpr` - Multi-process execution (clpr)

### LLM Integration

```lua
-- Create LLM instance with permissions
llm = newLLM({
    read = true,
    write = true, 
    execute = true,
    delete = true,
    list = true
})

-- Add user prompt and generate response
llm.add_user_prompt("your prompt here")
response = llm.generate()
```

## Development Notes

- Configuration is managed through `build/config.lua`
- The project uses MIT license
- Cross-platform builds generate multiple binary formats (.out, .exe, .deb, .rpm)
- The runtime embeds Lua with native extensions for LLM and system operations
- All builds output to the `release/` directory with standardized naming