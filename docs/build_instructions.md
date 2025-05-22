## Build Instructions

### Build Requirements 
#### [Darwin](https://github.com/OUIsolutions/Darwin)  
For Build the project you must have [Darwin](https://github.com/OUIsolutions/Darwin) installed on version 0.2.0
if you are on linux you can install darwin with:

```bash
curl -L https://github.com/OUIsolutions/Darwin/releases/download/0.3.0/darwin.out -o darwin.out && sudo chmod +x darwin.out &&  sudo  mv darwin.out /usr/bin/darwin

```
#### [Key Obfuscate](https://github.com/OUIsolutions/key_obfuscate)  
you must have [Key Obfuscate](https://github.com/OUIsolutions/key_obfuscate) installed on version 0.1.0  to generate the encription keys required to build the project
if you are on linux you can install key obfuscate with:

```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate  && sudo chmod +x  KeyObfuscate  && sudo mv KeyObfuscate  /bin/KeyObfuscate 
```


### Creating your keys
for making the build, you need to setup  the encryption keys , required for the project to work, you can generate them with the following command:
```bash
mkdir -p keys
KeyObfuscate --entry 'your content encryption  key' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'your llm encryption  key' --project_name 'llm' --output 'keys/llm.h'
KeyObfuscate --entry 'your name encryption  key' --project_name 'name' --output 'keys/name.h'
```
### Copiling from the amalgamation
you can now compile, direct from the [release/amalgamation](/release/amalgamation) directly, with the following command:
```bash
gcc amalgamation.c -DCONTENT_ENCRYPT_KEY=\"keys/content.h\" -DLLM_ENCRYPT_KEY=\"keys/llm.h\" -DNAME_ENCRYPT_KEY=\"keys/name.h\" -o vibescript
```

### Building your own version
if you want just to create the **amalgamation.c** file you can use the following command:
```bash
darwin run_blueprint build/ --mode folder amalgamation_build
```
it will create the **amalgamation.c** file in the **release** folder

### Local Build from Linux
make a local build to test with the following command it will create the **vibescript** file
```bash
darwin run_blueprint build/ --mode folder local_linux_build  

```

### Full Build from Docker or Podman
You must have podman or docker installed on your machine to build in these way, you can set what you want to use on the [build/config.lua](/build/config.lua) file.

if you want to make a full build to all platforms you can use the following command, it will create the following files:
```bash
 darwin run_blueprint build/ --mode folder amalgamation_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build  
```

Output files:
- release/vibescript64.exe
- release/vibescript.c
- release/vibescript.deb
- release/vibescripti32.exe
- release/vibescript.out
- release/vibescript.rpm

### Build Configurations
All build configurations are in the **build/config.lua** file.
the default its: 
```lua
PROJECT_NAME = "vibescript"
CONTANIZER   = "podman"
VERSION      = "0.0.9"
LICENSE      = "MIT"
URL          = "https://github.com/OUIsolutions/Ai-RagTemplate"
DESCRIPITION = "A Rag Based Template for C"
FULLNAME     = "Ai-RagTemplate"
EMAIL        = "mateusmoutinho01@gmail.com"
SUMARY       = "A Rag Based Template for C"
YOUR_CHANGES = "--"
```


