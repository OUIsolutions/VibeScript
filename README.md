# Project Overview

Vibe script its a custom lua runtime ,that allows you to make fast automations,with quick scripts

## Releases 

## Getting Start
- 1 Download one of the releases 
- 2 Configure a model to be used 

~~~bash
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions   --key "your key"
~~~
read [cli_usage.md](/docs/cli_usage.md) to understand the cli usage 
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

read [native_api.md](/docs/native_api.md) to get a better knolage of the bateries of the project


## Docs 
|item                                | description                                          |
|------------------------------------|------------------------------------------------------|
|[native_api.md](/docs/native_api.md)                | LLM creation and usage examples      |
|[cli_usage.md](/docs/cli_usage.md)                  | CLI commands and usage               |
|[assets_embed_vars.md](/docs/assets_embed_vars.md)  | Asset structure and management       |
|[build_instructions.md](/docs/build_instructions.md)| Build requirements and commands      |
|[build_toolchain.md](/docs/build_toolchain.md)      | Build process and dependencies       |
|[build_workflow.md](/docs/build_workflow.md)        | Build workflow and functions         |
|[json_model_config.md](/docs/json_model_config.md)  | JSON config structure and encryption |
|[licenses.md](/docs/licenses.md)                    | List of licenses and copyrights      |
|[project_dependencies.md](/docs/project_dependencies.md)| List of project dependencies     |
|[project_workflow.md](/docs/project_workflow.md)    | Project start and action functions   |