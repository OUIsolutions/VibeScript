
llm = newRawLLM()
llm.add_user_prompt("Qual é o seu nome?")

result = llm.make_question()