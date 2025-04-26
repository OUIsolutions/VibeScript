
llm = neRawLLM()
llm.add_user_prompt("Qual é o seu nome?")

result = llm.generate()
print(result)