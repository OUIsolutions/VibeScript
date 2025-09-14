
# Building VibeScript with Custom Extensions 🚀

**What is this?** VibeScript lets you add your own custom features! Think of it like adding new superpowers to the program.

**Who is this for?** Complete beginners who want to customize VibeScript.

**Time needed:** About 10 minutes

---

## 📋 What You'll Need

- A computer with Linux
- A terminal (command line)
- Basic copy-paste skills

**That's it!** No programming experience required.

---

## 🛠️ Step 1: Create Your Custom Feature

First, we'll create a simple custom feature. Don't worry about understanding the code - just copy and paste!

**Create a file called `extension.c` and put this code inside:**

```c
int custom_extension(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    printf("🎉 Hello from your custom extension!\n");

    LuaCEmbed_set_string_lib_prop(l, "custom_message", "This is YOUR custom message!");

    return LuaCembed_perform(l);
}
```

**What does this do?** This creates a simple custom feature that will show a message when you use it.

---

## 📥 Step 2: Download the Main VibeScript Code

We need to download the main VibeScript code to build on top of.

**Copy and paste this command in your terminal:**

```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.10.0/amalgamation.c -o amalgamation.c
```

**What happened?** You just downloaded a big file with all the VibeScript code!

---

## 🔐 Step 3: Install the Security Tool

VibeScript needs a security tool to keep your custom version safe.

**Copy and paste this command:**

```bash
curl -L https://github.com/OUIsolutions/key_obfuscate/releases/download/0.0.1/KeyObfuscate.out -o KeyObfuscate && sudo chmod +x KeyObfuscate && sudo mv KeyObfuscate /bin/KeyObfuscate
```

**What's this?** A security tool that creates special passwords for your VibeScript. Like putting locks on your doors!

---

## � Step 4: Create Security Passwords

Every custom VibeScript needs 3 special passwords. Think of them as 3 different keys for 3 different doors.

**First, create a folder for your passwords:**
```bash
mkdir -p keys
```

**Now create your 3 passwords (you can change the words in quotes to anything you want):**

```bash
KeyObfuscate --entry 'my-super-secret-content-password' --project_name 'content' --output 'keys/content.h'
KeyObfuscate --entry 'my-awesome-llm-password' --project_name 'llm' --output 'keys/llm.h'  
KeyObfuscate --entry 'my-fantastic-name-password' --project_name 'name' --output 'keys/name.h'
```

**💡 Pro Tip:** Make your passwords long and unique! Like "pizza-loving-cat-2025" instead of just "password123"

---

## 🔨 Step 5: Build Your Custom VibeScript

Now we'll combine everything together to create your custom VibeScript!

**Copy and paste this command (it's long, but just copy the whole thing):**

```bash
gcc amalgamation.c -DCONTENT_ENCRYPT_KEY=\"keys/content.h\" -DLLM_ENCRYPT_KEY=\"keys/llm.h\" -DNAME_ENCRYPT_KEY=\"keys/name.h\" -DVIBE_EXTENSION_MODULE=\"extension.c\" -DVIBE_EXTENSION_FUNC=custom_extension -DVIBE_EXTENSION_LIB_NAME=\"custom_extension\" -o custom_vibescript
```

**What's happening?** Your computer is building your custom VibeScript with your new feature inside!

---

## 🧪 Step 6: Test Your Custom VibeScript

Let's make sure your custom feature works!

**Create a test file called `main.lua` with this content:**

```lua
print("Testing my custom VibeScript...")
print(custom_extension.custom_message)
print("It works! 🎉")
```

**Now test it:**

```bash
./custom_vibescript main.lua 
```

**What you should see:**
```
Testing my custom VibeScript...
🎉 Hello from your custom extension!
This is YOUR custom message!
It works! 🎉
```

---

## 🎉 Congratulations!

You just built your first custom VibeScript! 

**What you accomplished:**
- ✅ Created a custom feature
- ✅ Downloaded the VibeScript code
- ✅ Set up security
- ✅ Built your custom version
- ✅ Tested it successfully

**What's next?** You can now modify the `extension.c` file to add your own custom features!