<div align="center">

# VibeScript
![Lua Logo](https://img.shields.io/badge/VibeScript-0.35.0-blue?style=for-the-badge&logo=lua)
[![GitHub Release](https://img.shields.io/github/release/OUIsolutions/VibeScript.svg?style=for-the-badge)](https://github.com/OUIsolutions/VibeScript/releases)
[![License](https://img.shields.io/badge/License-Unlicense-green.svg?style=for-the-badge)](https://github.com/OUIsolutions/VibeScript/blob/main/LICENSE)
![Status](https://img.shields.io/badge/Status-Stable-brightgreen?style=for-the-badge)
![Platforms](https://img.shields.io/badge/Platforms-Windows%20|%20Linux%20|%20macOS-lightgrey?style=for-the-badge)

</div>

---

### Overview

VibeScript is a specialized Lua runtime environment designed for LLM-powered automations. It transforms Lua scripts into powerful AI-driven workflows with seamless integration of Large Language Model capabilities:

1. **Configure your LLM model** 
2. **Write Lua automation scripts**
3. **Execute AI-powered workflows**

This runtime is designed for developers who need to:
- Create intelligent automation scripts with LLM integration
- Perform file system operations with AI assistance
- Build rapid prototypes for AI-driven applications
- Deploy cross-platform automation tools

### Key Features

- **LLM Integration** - Direct access to LLM models from Lua scripts
- **Multi-platform support** - Run on Windows, Linux, and macOS
- **File system operations** - Secure read/write capabilities for automation
- **Zero dependencies** - Standalone executables with embedded runtime
- **Simple API** - Intuitive Lua interface for complex LLM operations
- **Configurable models** - Support for various LLM providers


### Linux Installation 
```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.32.0/vibescript.out -o vibescript.out && chmod +x vibescript.out && sudo mv vibescript.out /usr/local/bin/vibescript
```

### macOS Installation
```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.32.0/vibescript.c -o vibescript.c && gcc vibescript.c -o vibescript && sudo mv vibescript /usr/local/bin/vibescript && rm vibescript.c
```

### Windows Installation
Download the appropriate executable from the releases section below.

### AI/LLM Integration

Want to learn how to use VibeScript with AI assistance? The built-in help system provides interactive examples for LLM integration and automation scripting.

---

## Releases


|  **File**                                                                                                           | **What is**                                |
|---------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
|[amalgamation.c](https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c) | Amalgamated source code containing all libraries  |
|[vibescript.out](https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/vibescript.out)   | Ready-to-use Linux binary           |
|[vibescripti32.exe](https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/vibescripti32.exe)       | Ready-to-use Windows 32-bit executable                         |
|[vibescript.deb](https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/vibescript.deb)       | Debian package for easy installation                             |
|[vibescript.rpm](https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/vibescript.rpm)       | RPM package for easy installation            |



## Documentation

### CLI Usage
| **Document**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [Extras](docs/cli_usage/extras.md)              | Additional CLI features and utilities                       |
| [Interpreting](docs/cli_usage/interpreting.md)                           | Script interpretation and execution                               |
| [LLM Operations](docs/cli_usage/llm_operations.md)                   | LLM model management and configuration                     |
| [Script Memorizing](docs/cli_usage/script_memorizing.md)      | Script storage and management system                          |

### Installation and Build
| **Document**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [Build Instructions](docs/install_and_build/build_instructions.md)              | Build requirements and commands                       |
| [Build with Extension](docs/install_and_build/build_with_extension.md)                           | How to add extensions inside VibeScript runtime                               |
| [Install](docs/install_and_build/install.md)                   | Installation guide for all platforms                     |

### Native API
| **Document**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [Built-in Libraries](docs/native_api/buildin_librarys.md)              | Available libraries and their usage                       |
| [LLM Operations](docs/native_api/llm_operations.md)                           | LLM integration and API functions                               |
| [Props Handling](docs/native_api/props_handling.md)                   | Property and configuration management                     |

### Other
| **Document**                                                    | **Description**                                         |
|-----------------------------------------------------------------|---------------------------------------------------------|
| [Licenses](docs/licenses.md)      | List of licenses and copyrights                          |

## 📄 License

This project is licensed under the Unlicense - see the [LICENSE](LICENSE) file for details.

---
