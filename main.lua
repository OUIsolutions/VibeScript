llm = newLLM({})

user_color = GREEN
ai_color = BLUE

local 

llm.add_function("change_ai_color","chamge the ai color",)


while true do 
    io.write(GREEN.."User: ")
    llm.add_user_prompt(io.read("*l"))
    response = llm.generate()
    print(BLUE.."AI: " .. response)
end 
