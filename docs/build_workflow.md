# VibeScript Build Workflow Documentation

This document provides a comprehensive and detailed explanation of the build workflow for the VibeScript project. Inspired by the structure and depth of `docs/project_workflow.md`, this guide covers the entire build process as defined in the scripts within the `build/` directory. It includes step-by-step breakdowns, conditions, pseudo-code, and direct code snippets to illustrate how VibeScript is compiled, dependencies are managed, and various build targets are created for different platforms.

## Overview of the Build Workflow

The VibeScript build workflow is managed using [Darwin](https://github.com/OUIsolutions/Darwin), a build tool that executes Lua scripts to orchestrate the build process. The workflow is primarily defined in `build/main.lua` and supported by various scripts in the `build/build/` directory. It handles tasks such as dependency installation, code amalgamation, asset generation, and cross-platform builds using containerization tools like Docker or Podman.

The build process supports multiple targets:
- **Amalgamation Build**: Combines source files into a single C file for easier compilation.
- **Local Linux Build**: Compiles VibeScript for the local Linux environment.
- **Alpine Static Build**: Creates a statically linked binary for Alpine Linux.
- **Debian Static Build**: Packages VibeScript as a `.deb` file for Debian-based systems.
- **RPM Static Build**: Packages VibeScript as an `.rpm` file for RPM-based systems.
- **Windows 32-bit Build**: Cross-compiles VibeScript for 32-bit Windows.
- **Windows 64-bit Build**: Cross-compiles VibeScript for 64-bit Windows.

Each build target can be triggered individually based on command-line arguments passed to the Darwin tool.

## Workflow Steps

Below are the detailed steps of the VibeScript build workflow, derived from the scripts in the `build/` directory. Each step includes descriptions, conditions, pseudo-code, and direct code snippets where applicable.

### Step 1: Initialize the Build Environment

- **Description**: The build process starts by initializing the environment in `build/main.lua`. This involves setting up Darwin, preparing necessary directories, and loading dependencies.
- **Action**: The `main()` function in `build/main.lua` is the entry point, which calls functions to install dependencies and prepare build functions.
- **Pseudo-Code**:
  ```
  function main()
      Install_dependencies()  // Install required external libraries
      local build_funcs = create_build_funcs()  // Create a table of build functions
      // Proceed to clean up old build artifacts and execute builds
  end
  ```
- **Direct Code** (from `build/main.lua`):
  ```lua
  function main()
      Install_dependencies()
      local build_funcs = create_build_funcs()
      // Additional steps follow
  end
  ```

### Step 2: Install Dependencies

- **Description**: External libraries and headers required for VibeScript are downloaded and stored in the `dependencies/` directory. This step ensures all necessary components are available before building.
- **Action**: The `Install_dependencies()` function in `build/install_dependencies.lua` downloads libraries like `DoTheWorld`, `BearHttpsClient`, `LuaCEmbed`, and others using `curl`.
- **Conditions**:
  - If a dependency file already exists, it is not re-downloaded unless the cache verification fails.
  - Uses a caching mechanism to avoid redundant downloads.
- **Pseudo-Code**:
  ```
  function Install_dependencies()
      Create directory "dependencies" if not exists
      For each library in predefined list:
          If not cached or cache invalid:
              Download library from URL to specified path
              Cache the download SHA for future verification
  end
  ```
- **Direct Code** (from `build/install_dependencies.lua`):
  ```lua
  function Install_dependencies()
      os.execute("mkdir -p dependencies")
      local libs = {
          { url = "https://github.com/OUIsolutions/DoTheWorld/releases/download/10.0.1/doTheWorld.h", path = "dependencies/doTheWorld.h" },
          // Other libraries listed
      }
      for _, lib in ipairs(libs) do
          local executor = function()
              os.execute("curl -L " .. lib.url .. " -o " .. lib.path)
          end
          local side_effect_verifier = function()
              return darwin.dtw.generate_sha_from_file(lib.path)
          end
          cache_execution({ "download", lib.url, lib.path }, executor, side_effect_verifier)
      end
  end
  ```

### Step 3: Clean Up Previous Build Artifacts

- **Description**: Before starting new builds, old build artifacts and cache are removed to ensure a clean slate.
- **Action**: The `main()` function removes the `release/` and `.cache/` directories using Darwin's `dtw.remove_any()` function.
- **Pseudo-Code**:
  ```
  Remove directory "release" if exists
  Remove directory ".cache" if exists
  ```
- **Direct Code** (from `build/main.lua`):
  ```lua
  darwin.dtw.remove_any("release")
  darwin.dtw.remove_any(".cache")
  ```

### Step 4: Define Build Functions

- **Description**: A table of build functions is created, each corresponding to a specific build target (e.g., `amalgamation_build`, `local_linux_build`, etc.).
- **Action**: The `create_build_funcs()` function in `build/build_funcs.lua` returns a table mapping build names to their respective functions.
- **Pseudo-Code**:
  ```
  function create_build_funcs()
      return {
          amalgamation_build = amalgamation_build,
          alpine_static_build = alpine_static_build,
          // Other build functions
      }
  end
  ```
- **Direct Code** (from `build/build_funcs.lua`):
  ```lua
  function create_build_funcs()
      return {
          amalgamation_build = amalgamation_build,
          alpine_static_build = alpine_static_build,
          rpm_static_build = rpm_static_build,
          windowsi32_build = windowsi32_build,
          debian_static_build = debian_static_build,
          local_linux_build = local_linux_build,
      }
  end
  ```

### Step 5: Execute Requested Builds

- **Description**: Iterate through the build functions and execute only those specified in the command-line arguments passed to Darwin.
- **Action**: Check for each build function if its name is provided as an argument using `darwin.argv.one_of_args_exist(name)`.
- **Conditions**:
  - If a build name is found in arguments, execute the corresponding build function.
  - Print progress messages before and after each build for user feedback.
- **Pseudo-Code**:
  ```
  Initialize counter i = 1
  For each name, build_lambda in build_funcs:
      If name exists in command-line arguments:
          Print start message with counter
          Execute build_lambda()
          Print finish message with counter
          Increment counter i
  end
  ```
- **Direct Code** (from `build/main.lua`):
  ```lua
  local i = 1
  for name, buld_lambda in pairs(build_funcs) do
      if darwin.argv.one_of_args_exist(name) then
          print("\n=========================================================================================")
          print("\tstarted of build:", i, "\n")
          buld_lambda()
          print("\n\tA build [" .. i .. "] finished")
          print("=========================================================================================\n\n")
          i = i + 1
      end
  end
  ```

### Step 6: Amalgamation Build Process

- **Description**: The `amalgamation_build()` function in `build/build/amalgamation_build.lua` combines all C source files into a single `amalgamation.c` file using `LuaCAmalgamator` and `LuaSilverChain` for dependency ordering.
- **Action**: Organize source files with `darwin.silverchain.generate()`, create a project with Lua and C components, and output the amalgamated file to `release/amalgamation.c`.
- **Conditions**:
  - Ensures the build is only run once using a global flag `alreay_amalamated_done`.
- **Pseudo-Code**:
  ```
  function amalgamation_build()
      If already run, return
      Set flag to prevent re-run
      Organize C source files with silverchain by tags (dep_declare, macros, etc.)
      Create project with Lua and C files
      Add Lua code for environment setup
      Add C files with specific defines
      Generate single C file to "release/amalgamation.c"
  end
  ```
- **Direct Code** (from `build/build/amalgamation_build.lua`):
  ```lua
  local alreay_amalamated_done = false
  function amalgamation_build()
      if alreay_amalamated_done then
          return
      end
      alreay_amalamated_done = true
      darwin.silverchain.generate({
          src = "csrc",
          project_short_cut = PROJECT_NAME,
          tags = { 
              "dep_declare", "macros", "types", "consts", "fdeclare", 'globals', "fdefine",
          }
      })
      local project = darwin.create_project(PROJECT_NAME)
      project.add_lua_code("private_vibescript = {}\n")
      // Additional Lua and C code additions
      project.generate_c_file({output="release/amalgamation.c", include_lua_cembed=false})
  end
  ```

### Step 7: Local Linux Build Process

- **Description**: The `local_linux_build()` function in `build/build/local_linux_build.lua` compiles the amalgamated source for the local Linux environment using `gcc`.
- **Action**: Triggers `amalgamation_build()` first, then compiles `release/amalgamation.c` into an executable named `vibescript`.
- **Pseudo-Code**:
  ```
  function local_linux_build()
      Run amalgamation_build()
      Execute gcc command to compile amalgamation.c with encryption key defines into "vibescript"
  end
  ```
- **Direct Code** (from `build/build/local_linux_build.lua`):
  ```lua
  function local_linux_build()
      amalgamation_build()
      local comand = [[gcc release/amalgamation.c  -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -o vibescript]]
      os.execute(comand)
  end
  ```

### Step 8: Alpine Static Build Process

- **Description**: The `alpine_static_build()` function in `build/build/alpine_static_build.lua` creates a statically linked binary for Alpine Linux using a containerized environment.
- **Action**: Uses `darwin.ship` to create an Alpine container, installs build tools, mounts necessary volumes, and compiles the amalgamated source statically.
- **Conditions**:
  - Ensures the build is only run once using a global flag.
  - Depends on `amalgamation_build()` for the source file.
- **Pseudo-Code**:
  ```
  function alpine_static_build()
      If already run, return
      Set flag to prevent re-run
      Run amalgamation_build()
      Create Alpine container with ship
      Install build tools (gcc, etc.)
      Start container with volumes for release and keys
      Compile amalgamation.c statically into "release/alpine_static_bin.out"
  end
  ```
- **Direct Code** (from `build/build/alpine_static_build.lua`):
  ```lua
  local alpine_static_build_done = false
  function alpine_static_build()
      if alpine_static_build_done then
          return
      end
      alpine_static_build_done = true
      amalgamation_build()
      os.execute("mkdir -p release")
      local image = darwin.ship.create_machine("alpine:latest")
      image.provider = CONTANIZER
      image.add_comptime_command("apk update")
      image.add_comptime_command("apk add --no-cache gcc g++ musl-dev curl")
      local compiler = "gcc"
      // Compiler selection logic
      image.start({
          volumes = {
              { "././release", "/release" },
              { "././keys", "/keys" },
          },
          command = compiler..[[ --static /release/amalgamation.c  -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -DDEFINE_DEPENDENCIES -o /release/alpine_static_bin.out]]
      })
  end
  ```

### Step 9: Debian Static Build Process

- **Description**: The `debian_static_build()` function in `build/build/debian_static_build.lua` packages the Alpine static binary into a Debian `.deb` package.
- **Action**: Depends on `alpine_static_build()`, creates necessary control files, and uses a Debian container to build the package.
- **Conditions**:
  - Ensures the build is only run once.
- **Pseudo-Code**:
  ```
  function debian_static_build()
      If already run, return
      Set flag to prevent re-run
      Run alpine_static_build()
      Create control file for Debian package with project metadata
      Copy Alpine binary to package structure
      Create post-install script for permissions
      Use Debian container to build .deb package
  end
  ```
- **Direct Code** (from `build/build/debian_static_build.lua`):
  ```lua
  local debian_static_build_done = false
  function debian_static_build()
      if debian_static_build_done then
          return
      end
      debian_static_build_done = true
      alpine_static_build()
      local control = [[
  Package: PROJECT_NAME
  Version: VERSION
  // Other metadata
  ]]
      control = string.gsub(control, "PROJECT_NAME", PROJECT_NAME)
      // Other substitutions
      darwin.dtw.write_file(".cache/debian_static_build/project/DEBIAN/control", control)
      // Copy binary and create postinst script
      local image = darwin.ship.create_machine("debian:latest")
      image.provider = CONTANIZER
      image.start({
          flags = { "-it" },
          volumes = {
              { "./.cache/debian_static_build/project", "/project" },
              { "./release", "/release" },
          },
          command = "chmod 755 /project/DEBIAN/postinst && dpkg-deb --build /project /release/debian_static.deb"
      })
  end
  ```

### Step 10: RPM Static Build Process

- **Description**: The `rpm_static_build()` function in `build/build/rpm_static_build.lua` packages the Alpine static binary into an RPM package for Fedora-based systems.
- **Action**: Depends on `alpine_static_build()`, creates an RPM spec file, and uses a Fedora container to build the package.
- **Conditions**:
  - Ensures the build is only run once.
- **Pseudo-Code**:
  ```
  function rpm_static_build()
      If already run, return
      Set flag to prevent re-run
      Run alpine_static_build()
      Copy Alpine binary to RPM source directory
      Create spec file with project metadata
      Use Fedora container to build RPM package
      Copy resulting RPM to release directory
  end
  ```
- **Direct Code** (from `build/build/rpm_static_build.lua`):
  ```lua
  local rpm_static_build_done = false
  function rpm_static_build()
      if rpm_static_build_done then
          return
      end
      rpm_static_build_done = true
      alpine_static_build()
      darwin.dtw.copy_any_overwriting("release/alpine_static_bin.out", ".cache/rpm_static_build/SOURCES/alpine_static_bin.out")
      local formmatted_rpm = [[
  Name:           PROJECT_NAME
  Version:        VERSION
  // Other metadata
  ]]
      // Substitutions for metadata
      darwin.dtw.write_file(".cache/rpm_static_build/SPECS/project.spec", formmatted_rpm)
      os.execute("mkdir -p .cache/rpm_static_build/RPMS")
      local image = darwin.ship.create_machine("fedora:latest")
      image.provider = CONTANIZER
      image.add_comptime_command("dnf install rpm-build rpmdevtools -y")
      // Other setup commands
      image.start({
          flags = { "-it " },
          volumes = {
              { "./.cache/rpm_static_build/SOURCES", "/root/rpmbuild/SOURCES" },
              // Other volumes
          },
          command = "rpmbuild -ba ~/rpmbuild/SPECS/project.spec"
      })
      // Copy resulting RPM to release
  end
  ```

### Step 11: Windows Builds (32-bit and 64-bit)

- **Description**: The `windowsi32_build()` and `windowsi64_build()` functions in their respective files cross-compile VibeScript for Windows using MinGW in a Debian container.
- **Action**: Depends on `amalgamation_build()`, uses MinGW compilers for 32-bit and 64-bit targets, and outputs executables to `release/`.
- **Conditions**:
  - Ensures each build is only run once.
- **Pseudo-Code** (for 64-bit as an example):
  ```
  function windowsi64_build()
      If already run, return
      Set flag to prevent re-run
      Run amalgamation_build()
      Create Debian container with MinGW installed
      Compile amalgamation.c for 64-bit Windows into "release/windows64.exe"
  end
  ```
- **Direct Code** (from `build/build/windows64_build.lua`):
  ```lua
  local windows_build_done = false
  function windowsi64_build()
      if windows_build_done then
          return
      end
      windows_build_done = true
      amalgamation_build()
      os.execute("mkdir -p release")
      local image = darwin.ship.create_machine("debian:latest")
      image.provider = CONTANIZER
      image.add_comptime_command("apt-get update")
      image.add_comptime_command("apt-get -y install mingw-w64")
      local compiler = "x86_64-w64-mingw32-gcc"
      // Compiler selection logic
      image.start({
          volumes = {
              { "././release", "/release" },
              { "././keys", "/keys" },
          },
          command = compiler..[[ --static -DDEFINE_DEPENDENCIES  /release/amalgamation.c  -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\" -o /release/windows64.exe -lws2_32]]
      })
  end
  ```

### Step 12: Rename Output Files

- **Description**: After builds are complete, output files in the `release/` directory are renamed to include the project name for consistency.
- **Action**: Move and rename files using `darwin.dtw.move_any_overwriting()` to match the project name defined in `build/config.lua`.
- **Pseudo-Code**:
  ```
  Rename "release/alpine_static_bin.out" to "release/PROJECT_NAME.out"
  Rename "release/windows64.exe" to "release/PROJECT_NAME64.exe"
  Rename other output files similarly
  ```
- **Direct Code** (from `build/main.lua`):
  ```lua
  darwin.dtw.move_any_overwriting("release/alpine_static_bin.out","release/"..PROJECT_NAME..".out")
  darwin.dtw.move_any_overwriting("release/windows64.exe","release/"..PROJECT_NAME.."64.exe")
  darwin.dtw.move_any_overwriting("release/windowsi32.exe","release/"..PROJECT_NAME.."i32.exe")
  darwin.dtw.move_any_overwriting("release/debian_static.deb","release/"..PROJECT_NAME..".deb")
  darwin.dtw.move_any_overwriting("release/rpm_static_build.rpm","release/"..PROJECT_NAME..".rpm")
  ```

### Step 13: Cache Management

- **Description**: A caching mechanism in `build/cache.lua` prevents redundant operations by checking SHA hashes of inputs and outputs.
- **Action**: The `cache_execution()` function verifies if an operation needs to be re-run based on cached SHA values of inputs and side effects.
- **Pseudo-Code**:
  ```
  function cache_execution(entries, executor, side_effect_verifier)
      Compute SHA of input entries
      Load cached side effect SHA for this input
      If cached SHA exists and matches current side effect SHA:
          Print "cached" message and return
      Else:
          Print "executing" message
          Run executor()
          Save new side effect SHA to cache
  end
  ```
- **Direct Code** (from `build/cache.lua`):
  ```lua
  function cache_execution(entries, executor, side_effect_verifier)
      local ident = false
      local entreis_data = darwin.json.dumps_to_string(entries, ident)
      local entries_sha = darwin.dtw.generate_sha(entreis_data)
      local side_effect_sha = darwin.dtw.load_file(".cacherag/"..entries_sha)
      if side_effect_sha then
          local side_effect_verification = side_effect_verifier()
          if side_effect_sha == side_effect_verification and side_effect_verification then
              print("cached: ", entreis_data)
              return
          end
      end
      print("executing: ", entreis_data)
      executor()
      local side_effect_verification = side_effect_verifier()
      darwin.dtw.write_file(".cacherag/"..entries_sha, side_effect_verification)
  end
  ```

## Configuration and Customization

- **Description**: Build configurations are defined in `build/config.lua`, which sets project metadata and build parameters.
- **Details**:
  - `PROJECT_NAME`: Defines the name of the output binaries (e.g., "vibescript").
  - `CONTANIZER`: Specifies the container tool to use (e.g., "sudo docker").
  - Other fields like `VERSION`, `LICENSE`, and `FULLNAME` are used in package metadata.
- **Direct Code** (from `build/config.lua`):
  ```lua
  PROJECT_NAME = "vibescript"
  CONTANIZER   = "sudo docker"
  VERSION      = "0.0.1"
  LICENSE      = "MIT"
  URL          = "https://github.com/OUIsolutions/Ai-RagTemplate"
  DESCRIPITION = "A Runtime to work with llms"
  FULLNAME     = "VibeScript"
  EMAIL        = "mateusmoutinho01@gmail.com"
  SUMARY       = "A Runtime to work with llms"
  YOUR_CHANGES = "--"
  LAUNGUAGE    = "c"
  ```

## Build Dependencies and Tools

- **Darwin**: The primary build tool used to run Lua scripts and manage the build process.
- **Lua Libraries**: Includes `LuaArgv`, `LuaDoTheWorld`, `LuaShip`, and others for argument parsing, file operations, and container management.
- **Containerization**: Uses Docker or Podman (as defined in `CONTANIZER`) for cross-platform builds.
- **Compilers**: Uses `gcc` for Linux builds, `mingw-w64` for Windows cross-compilation.

## Error Handling

- **Description**: The build system does not explicitly handle errors with try-catch blocks but relies on Darwin's execution model. Failures in container commands or compilation will cause the build to halt with error messages printed to the console.
- **Best Practices**:
  - Ensure Docker or Podman is installed and accessible.
  - Verify internet connectivity for dependency downloads.
  - Check for sufficient permissions when using `sudo` for container operations.

## Conclusion

The VibeScript build workflow is a sophisticated process orchestrated by Darwin and Lua scripts, designed to handle multiple build targets for various platforms. It incorporates dependency management, source amalgamation, containerized builds for cross-platform compatibility, and caching for efficiency. This detailed documentation, with direct code snippets and step-by-step explanations, provides a clear understanding of how VibeScript is built from source to distributable binaries and packages. Each step is meticulously crafted to ensure repeatability and reliability across different environments.