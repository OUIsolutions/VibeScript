llm = newLLM({})
llm.add_user_prompt("você ta funcionandos  ?")
response = llm.generate()
print("Response: " .. response)