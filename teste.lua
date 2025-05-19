
llm = newLLM({})
llm.add_system_prompt("ola , voce ta funcionando ?")
response = llm.generate()
print("Response: " .. response)
