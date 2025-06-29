
vibescript allows you to create customizible extensions for the module project, allowing you 
to change the behavior of the runtime itself .

## step 1: create a Lib Extension
 create a `luaCEmbed lib` file called **extension.c** following [LuaCEmbed](https://github.com/OUIsolutions/LuaCEmbed.git) especification.

 ```c
 int custom_extension(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    printf("hello from extension\n");

    LuaCEmbed_set_string_lib_prop(l, "custom_message", "This is a custom message from custom_extension");

    return LuaCembed_perform(l);
}
 ```

## Step 2: Download the **amalgamation.c** 
download the [amalgamation.c](https://github.com/OUIsolutions/VibeScript/releases/download/0.9.0/amalgamation.c) with:

```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.9.0/amalgamation.c -o amalgamation.c
```


### Step 3: Install [Key Obfuscate](https://github.com/OUIsolutions/key_obfuscate) (Security Tool)
This tool creates security keys to protect your application. It's like creating passwords for your app.

**On Linux, copy and paste this command in your terminal:**
```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate && sudo chmod +x KeyObfuscate && sudo mv KeyObfuscate /bin/KeyObfuscate
```


## 🔐 Step 4: Create Your Security Keys

Every VibeScript build needs security keys. These are like passwords that protect different parts of your app.

**Run these commands one by one:**

```bash
# Create a folder for your keys
mkdir -p keys

# Create three different security keys (replace the text in quotes with your own passwords)
KeyObfuscate --entry 'my-secret-content-password' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'my-secret-llm-password' --project_name 'llm' --output 'keys/llm.h'  
KeyObfuscate --entry 'my-secret-name-password' --project_name 'name' --output 'keys/name.h'
```

**💡 Tip:** Replace the text in quotes with your own secret passwords. Make them hard to guess!


## Step 5: Compile your custom vibescript version:
now you can compile your custom vibescript version with:

```bash
 gcc amalgamation.c -DCONTENT_ENCRYPT_KEY=\"keys/content.h\" -DLLM_ENCRYPT_KEY=\"keys/llm.h\"
 -DNAME_ENCRYPT_KEY=\"keys/name.h\"  -DVIBE_EXTENSION_MODULE=\"extension.c\" -DVIBE_EXTENSION_FUNC=custom_extension -DVIBE_EXTENSION_LIB_NA
ME=\"custom_extension\" -o custom_vibescript
```
## step 6: test if your extension its working