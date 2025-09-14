# VibeScript Build Instructions

This guide provides comprehensive instructions for building VibeScript from source. The following steps will walk you through the build process and requirements.

## Prerequisites

Before building VibeScript, you need to install the required build tools:

### 1. Install Darwin (Build Tool)
Darwin is the primary build system used for compiling VibeScript. It manages the build process and handles cross-platform compilation.


### Linux Installation 
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.13.0/darwin_linux_bin.out -o darwin.out && chmod +x darwin.out &&   mv darwin.out /usr/local/bin/darwin 
```
### Mac-Os Instalation
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.13.0/darwin.c -o darwin.c && gcc darwin.c -o darwin.out && sudo mv darwin.out /usr/local/bin/darwin && rm darwin.c 
```

## Build Options

For customizing the build process or creating builds for different platforms:

#### Generate Amalgamation File
```bash
darwin run_blueprint build/ --mode folder amalgamation_build
```
This command creates a fresh `amalgamation.c` file in the `release` folder.
the **amalgamation.c** file contains all the VibeScript source code combined into a single file, making it easier to compile and distribute.


#### Local Linux Build
```bash
darwin run_blueprint build/ --mode folder local_linux_build
```bash
darwin run_blueprint build/ --mode folder local_linux_build
```
This creates a `vibescript` executable optimized for the local Linux environment.

#### Cross-Platform Build
```bash
darwin run_blueprint build/ --mode folder amalgamation_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman
```

This comprehensive build creates the following executables:
- `release/vibescript64.exe` - Windows 64-bit executable
- `release/vibescripti32.exe` - Windows 32-bit executable
- `release/vibescript.out` - Linux executable
- `release/vibescript.deb` - Debian/Ubuntu package
- `release/vibescript.rpm` - RedHat/CentOS package

**Note:** Docker or Podman is required for cross-platform builds.

## Build Verification

After completing the build process, verify the installation:

```bash
# Verify the build was successful
./vibescript --help
```

A successful build will display the help documentation.

## Configuration

Build settings can be customized by modifying `build/config.lua`. Key configuration options include:

```lua
PROJECT_NAME = "vibescript"        -- Project name
VERSION      = "0.0.9"            -- Version number
CONTANIZER   = "podman"            -- Container engine (docker or podman)
```

