
function local_linux_build()
    amalgamation_build()
    local comand = [[gcc release/amalgamation.c  -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -o vibescript]]
    os.execute(comand)
   
end

darwin.add_recipe({
    name = "local_linux_build",
    description = "builds the project locally on Linux using gcc",
    outs = {"vibescript"},
    inputs = {"release/amalgamation.c", "../keys/content.h", "../keys/llm.h", "../keys/name.h"},
    callback = local_linux_build
})