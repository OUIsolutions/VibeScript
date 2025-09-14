

# VibeScript Installation Guide

You can install VibeScript using one of the following methods:

## Binary Installation (Recommended)

### Linux
Run the following command to install VibeScript on Linux:

```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.32.0/vibescript.out -o vibescript.out && chmod +x vibescript.out && sudo mv vibescript.out /usr/local/bin/vibescript
```

### Windows
Download the appropriate binary for your system from the [Releases](https://github.com/OUIsolutions/VibeScript/releases) page:
- For 32-bit Windows: Download `vibescripti32.exe`

After downloading, you can:
1. **Add to PATH**: Move the executable to a directory in your PATH (e.g., `C:\Windows\System32` or create a dedicated folder like `C:\VibeScript\bin`)
2. **Direct usage**: Place the executable in your project folder and run it directly


## Source Compilation

### Linux and macOS
You need to have `gcc` or `clang` installed:

```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c -o vibescript.c && gcc vibescript.c -o vibescript.out && sudo mv vibescript.out /usr/local/bin/vibescript
```

### Windows

#### Option 1: Using MinGW64 (Recommended)

1. **Install MinGW64**:
   - Download and install [MSYS2](https://www.msys2.org/)
   - Open MSYS2 terminal and run:
     ```bash
     pacman -S mingw-w64-x86_64-gcc
     ```
   - Add MinGW64 to your PATH: `C:\msys64\mingw64\bin`

2. **Compile VibeScript**:
   ```bash
   # Download the source
   curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c -o vibescript.c
   
   # Compile with MinGW64
   gcc vibescript.c -o vibescript.exe  -lws2_32
   
   # Move to a directory in PATH (optional)
   move vibescript.exe C:\Windows\System32\
   ```

#### Option 2: Using MSVC (Visual Studio)

1. **Install Visual Studio**:
   - Download and install [Visual Studio Community](https://visualstudio.microsoft.com/downloads/) with C++ development tools
   - Or install [Build Tools for Visual Studio](https://visualstudio.microsoft.com/downloads/#build-tools-for-visual-studio-2022)

2. **Compile using Developer Command Prompt**:
   ```cmd
   # Download the source (using PowerShell or download manually)
   curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c -o vibescript.c
   
   # Open "Developer Command Prompt for VS" and compile
   cl vibescript.c /Fe:vibescript.exe
   
   # Move to a directory in PATH (optional)
   move vibescript.exe C:\Windows\System32\
   ```

#### Option 3: Using Clang on Windows

1. **Install Clang**:
   - Download from [LLVM releases](https://github.com/llvm/llvm-project/releases)
   - Or install via [Chocolatey](https://chocolatey.org/): `choco install llvm`

2. **Compile**:
   ```bash
   # Download the source
   curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c -o vibescript.c
   
   # Compile with Clang
   clang vibescript.c -o vibescript.exe
   
   # Move to a directory in PATH (optional)
   move vibescript.exe C:\Windows\System32\
   ```

## Verification

After installation, verify that VibeScript is working correctly:

```bash
# Check version
vibescript --version

# Run a simple test
echo 'print("Hello, VibeScript!")' > test.lua
vibescript test.lua
```

## Troubleshooting

### Windows-specific Issues

1. **"vibescript is not recognized"**: 
   - Ensure the executable is in a directory listed in your PATH environment variable
   - Try running with full path: `C:\path\to\vibescript.exe your_script.lua`

2. **Missing Visual C++ Redistributable**:
   - Download and install [Microsoft Visual C++ Redistributable](https://docs.microsoft.com/en-us/cpp/windows/latest-supported-vc-redist)

3. **Compilation errors with MinGW64**:
   - Ensure you're using the 64-bit version of MinGW64
   - Check that `gcc --version` shows MinGW-W64 version

4. **MSVC compilation issues**:
   - Make sure you're using the "Developer Command Prompt for VS"
   - Verify that `cl` command is available

### General Issues

- **Permission denied**: On Linux/macOS, make sure the binary has execute permissions (`chmod +x vibescript.out`)
- **Network issues**: If `curl` fails, download the files manually from the GitHub releases page

