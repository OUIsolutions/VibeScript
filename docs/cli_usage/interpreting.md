
### Interpreting by file 
for interpreting a file, you can just create a "hello.lua" file with the following content:
```lua
print("Hello, World!")
```
and then run:
```bash
vibescript  hello.lua
```
### Interpreting by url 
you can also interpret a script directly from a url, for example:
```bash
vibescript  https://raw.githubusercontent.com/OUIsolutions/VibeScript/refs/heads/new_version/extra/hello_world.lua
```

### Interpreting by memory
you can memorize a script in memory, then interpret it by its name:
```bash
vibescript add_script --file hello.lua  hello
``` 
then, you can interpret it by:
```bash
vibescript  hello
```
### Interpreting by number 
you can also interpret a script by its number in the list of memorized scripts:
```bash
vibescript list
```
you will see something like:
```
1: teste
2: hello_world
3: hello
```
then, you can interpret it by:
```bash
vibescript  3
```
