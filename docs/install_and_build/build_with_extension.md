
# Building VibeScript with Custom Extensions

**Overview:** VibeScript supports custom extensions that allow you to add additional functionality to the core system.

**Audience:** Developers who want to extend VibeScript with custom features.

**Estimated time:** Approximately 10 minutes

---

## Prerequisites

- Linux operating system
- Terminal access
- Basic command line familiarity

No advanced programming experience is required.

---

## Step 1: Create Your Custom Extension

Create a custom extension by implementing a simple function. The following example demonstrates the basic structure.

**Create a file named `extension.c` with the following content:**

```c
int custom_extension(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    printf("Hello from your custom extension!\n");

    LuaCEmbed_set_string_lib_prop(l, "custom_message", "This is your custom message!");

    return LuaCembed_perform(l);
}
```

**Function description:** This creates a basic custom extension that outputs a message and sets a string property accessible from Lua.

---

## Step 2: Download VibeScript Source

Download the VibeScript amalgamation file, which contains all the necessary source code.

**Execute the following command:**

```bash
curl -L https://github.com/OUIsolutions/VibeScript/releases/download/0.35.0/amalgamation.c -o amalgamation.c
```

This downloads the complete VibeScript source code in a single file format.

---

## Step 3: Compile with Extension

Compile VibeScript with your custom extension using the following command:

**Execute the compilation command:**

```bash
gcc amalgamation.c  -DVIBE_EXTENSION_MODULE=\"extension.c\" -DVIBE_EXTENSION_FUNC=custom_extension -DVIBE_EXTENSION_LIB_NAME=\"custom_extension\" -o custom_vibescript
```

This command compiles the VibeScript source with your custom extension integrated.

---

## Step 4: Test the Extension

Verify that your custom extension functions correctly by creating a test script.

**Create a test file named `main.lua` with the following content:**

```lua
print("Testing custom VibeScript extension...")
print(custom_extension.custom_message)
print("Extension test completed successfully.")
```

**Execute the test:**

```bash
./custom_vibescript main.lua 
```

**Expected output:**
```
Testing custom VibeScript extension...
Hello from your custom extension!
This is your custom message!
Extension test completed successfully.
```

---

## Conclusion

You have successfully built VibeScript with a custom extension.

**Summary of completed tasks:**
- Created a custom extension function
- Downloaded the VibeScript source code
- Compiled VibeScript with the extension
- Verified the extension functionality

**Next steps:** You can now modify the `extension.c` file to implement additional custom features as needed.