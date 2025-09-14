# Built-in Libraries

VibeScript comes with several native Lua libraries that provide essential functionalities for file operations, JSON handling, argument parsing, and container management. These libraries are automatically available in the VibeScript environment.

## Available Libraries

| Object Name | Library Name | Description |
|-------------|--------------|-------------|
| `dtw` | [LuaDoTheWorld](https://github.com/OUIsolutions/LuaDoTheWorld) | A utility library for file and directory operations, including reading, writing, listing, and more. |
| `json` | [LuaFluidJson](https://github.com/OUIsolutions/LuaFluidJson) | A library for parsing and serializing JSON data, useful for configuration management. |
| `argv` | [LuaArgv](https://github.com/OUIsolutions/LuaArgv) | A library for parsing command-line arguments, enabling script customization via CLI. |
| `ship` | [LuaShip](https://github.com/OUIsolutions/LuaShip) | A Podman/Docker wrapper for container management, useful for advanced deployment scenarios. |
| `serjao` | [SerjaoBerranteiro](https://github.com/SamuelHenriqueDeMoraisVitrio/SerjaoBerranteiroServer) | Full web server implementation for lua|
| `luabear` | [Lua-Bear](https://github.com/OUIsolutions/Lua-Bear) | A Complete Https Client |
| `webdriver` | [LuaWebDriver](https://github.com/OUIsolutions/LuaWebDriver) | A WebDriver lib for control chrome browser (similar to selenium) |
| `luaberrante` | [LuaBerrante](https://github.com/SamuelHenriqueDeMoraisVitrio/LuaBerrante) | A lib to control Telegram over lua |
| `heregitage` | [LuaHeritage](https://github.com/mateusmoutinho/LuaHeritage) | A lib make complex POO in lua |
| `clpr` | [clpr](https://github.com/OUIsolutions/clpr) | A lib for multprocess execution in comand line |

## Usage

These libraries can be directly used within your VibeScript scripts to perform various operations. For example:

- `dtw.load_file()` can read a file's content
- `json.dumps_to_string()` can serialize a Lua table to a JSON string

All libraries are pre-loaded and available globally in the VibeScript environment, so you can use them immediately without any require statements.