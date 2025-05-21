llm = newLLM({write=true})
print("VibeScript LLM test")
while true do

    io.write('mensagem:')
    io.flush()

    conteudo = io.read()
    llm.add_user_prompt(conteudo)
    response = llm.generate()
    llm.add_assistent_prompt(response)
    print("Response:"..response)
end