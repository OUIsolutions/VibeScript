# VibeScript

<div align="center">

[![License: MIT](https://img.shields.io/badge/License-Unlicense-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub release](https://img.shields.io/github/release/OUIsolutions/VibeScript.svg)](https://github.com/OUIsolutions/VibeScript/releases/)
[![Build Status](https://img.shields.io/badge/build-passing-brightgreen.svg)]() 
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://github.com/OUIsolutions/VibeScript/pulls)

**A custom Lua runtime for rapid LLM-powered automations**

[Features](#features) • [Installation](#installation) • [Quick Start](#quick-start) • [Documentation](#documentation) • [Releases](#releases) • [License](#license)

</div>

## 📋 Overview

VibeScript is a specialized Lua runtime environment designed to facilitate fast automations through quick scripts. It seamlessly integrates LLM capabilities into Lua, enabling powerful AI-driven workflows with minimal setup.

## ✨ Features

- **LLM Integration** - Direct access to LLM models from Lua scripts
- **File System Operations** - Secure read/write capabilities for automation
- **Multi-platform Support** - Works on Linux, Windows, and macOS
- **Simple API** - Intuitive Lua interface for complex LLM operations
- **Configurable Models** - Support for various LLM providers

## 🚀 Installation

### Option 1: Download Pre-built Binaries

Download the latest release from our [releases page](https://github.com/OUIsolutions/VibeScript/releases/tag/0.19.1).

### Option 2: Install via Package Manager

**Debian/Ubuntu:**
```bash
# Download the .deb package from releases page
sudo dpkg -i vibescript.deb
```

**Fedora/RHEL:**
```bash
# Download the .rpm package from releases page
sudo rpm -i vibescript.rpm
```

## 🏁 Quick Start

### 1. Configure an LLM Model

```bash
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions --key "your key"
```

See [CLI usage documentation](/docs/cli_usage.md) for more options.

### 2. Create Your First Script

Create a file named `main.lua` with the following content:

```lua
llm = newLLM({
    read = true,
    write = true,
    execute = true,
    delete = true,
    list = true
})
llm.add_user_prompt("list the src dir, and explain what's inside")
response = llm.generate()
print("Response: " .. response)
```

### 3. Run Your Script

```bash
vibescript main.lua
```

Explore the [Native API documentation](/docs/native_api.md) to learn more about VibeScript's capabilities.

## 📦 Releases

| File | Description |
| --- | --- |
| [vibescript.c](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScript.c) | Amalgamated source code |
| [vibescript.deb](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScript.deb) | Debian Package |
| [vibescript.rpm](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScript.rpm) | RPM Package |
| [vibescript.out](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScript.out) | Linux Executable |
| [vibescript64.exe](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScript64.exe) | Windows 64-bit Executable |
| [vibescripti32.exe](https://github.com/OUIsolutions/VibeScript/releases/download/0.19.1/VibeScripti32.exe) | Windows 32-bit Executable |

## 📚 Documentation

| Document | Description |
| --- | --- |
| [Native API](/docs/native_api.md) | LLM creation and usage examples |
| [CLI Usage](/docs/cli_usage.md) | Command line interface reference |
| [Build Instructions](/docs/build_instructions.md) | Build requirements and commands |
| [Build with Extensions](/docs/build_with_extension.md) | How to add extension inside vibescript runtime|
| [Build Toolchain](/docs/build_toolchain.md) | Build process and dependencies |
| [Project Workflow](/docs/project_workflow.md) | Project Workflow Explanation |
| [Build Workflow](/docs/build_workflow.md) | Build Workflow Explanation |
| [Licenses](/docs/licenses.md) | List of licenses and copyrights |

## 🤝 Contributing

Contributions are welcome! Feel free to submit a pull request or open an issue.

## 📄 License

This project is licensed under the MIT License - see the [licenses.md](/docs/licenses.md) file for details.
