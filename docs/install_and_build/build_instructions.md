# 🚀 VibeScript Build Instructions d

Welcome! This guide will help you build VibeScript step by step. Don't worry if you're new to this - we'll explain everything!

## 📋 What You'll Need

Before we start, you need to install two tools on your computer:

### 1. Install Darwin (Build Tool)
Darwin is a tool that helps us build the project. Think of it like a smart assistant that knows how to compile code.

**On Linux, copy and paste this command in your terminal:**
```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out && sudo chmod +x darwin.out && sudo mv darwin.out /usr/bin/darwin
```

If you want to create builds for different operating systems or customize the build process:

#### Create Your Own Amalgamation File
```bash
darwin run_blueprint build/ --mode folder amalgamation_build
```
**What this does:** Creates a fresh `amalgamation.c` file in the `release` folder.

#### Test Build for Linux Only
```bash
darwin run_blueprint build/ --mode folder local_linux_build
```
**What this does:** Creates a `vibescript` program that only works on Linux.

#### Build for All Platforms (Windows, Linux, etc.)
```bash
darwin run_blueprint build/ --mode folder amalgamation_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman
```

**What this creates:**
- `release/vibescript64.exe` - For 64-bit Windows
- `release/vibescripti32.exe` - For 32-bit Windows  
- `release/vibescript.out` - For Linux
- `release/vibescript.deb` - For Debian/Ubuntu Linux
- `release/vibescript.rpm` - For RedHat/CentOS Linux

**Note:** You need Docker or Podman installed for this option.

## ✅ Step 3: Test Your Build

After building, test if everything works:

```bash
# Make sure your program can run
./vibescript --help
```

If you see help text, congratulations! 🎉 You've successfully built VibeScript!

## ⚙️ Advanced Configuration (Optional)

You can customize build settings by editing `build/config.lua`. The most important settings are:

```lua
PROJECT_NAME = "vibescript"        -- Name of your program
VERSION      = "0.0.9"            -- Version number
CONTANIZER   = "podman"            -- Use "docker" or "podman"
```

## 🆘 Need Help?

- **"Command not found" error?** Make sure you installed Darwin and KeyObfuscate correctly
- **Permission denied?** Try adding `sudo` before the command
- **Build fails?** Make sure you created all three security keys in the `keys/` folder

## 📝 Summary

1. ✅ Install Darwin and KeyObfuscate tools
2. ✅ Create security keys with KeyObfuscate  
3. ✅ Choose Option A (Quick) or Option B (Advanced)
4. ✅ Run the build command
5. ✅ Test your new VibeScript program!

That's it! You now have a working VibeScript build. Happy coding! 🚀


