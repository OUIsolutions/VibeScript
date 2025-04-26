# Project Overview

Vibe script its a custom lua runtime ,that allows you to make fast automations,with quick scripts

## Releases 

## Getting Start
- 1 Download one of the releases 
- 2 Configure a model to be used 

~~~bash
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions   --key "your key"
~~~
- 3 create a file called **main.lua** and place the content inside: 

~~~lua
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
~~~

- 4 you can now interpret the script with:
~~~bash
vibescript main.lua
~~~