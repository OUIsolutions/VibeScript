llm = newLLM({
  
})
llm.add_dir("docs/")
llm.add_file("prompt.md")
response = llm.generate()
print("Response: " .. response)