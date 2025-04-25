llm = newLLM()

llm.add_folder_context("src/actions",valid_extensions={"h"})
llm.add_file_context("actions.md")
llm.add_user_prompt()