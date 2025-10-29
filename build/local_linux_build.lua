
function local_linux_build()

    local comand = [[gcc release/amalgamation.c  -DCONTENT_ENCRYPT_KEY=\"../keys/content.h\" -DLLM_ENCRYPT_KEY=\"../keys/llm.h\" -DNAME_ENCRYPT_KEY=\"../keys/name.h\"  -o vibescript]]
    os.execute(comand)
   
end

darwin.add_recipe({
    name = "local_linux_build",
    requires={"amalgamation"},
    description = "builds the project locally on Linux using gcc",
    outs = {"vibescript"},
    inputs = {"csrc", "luasrc", "dependencies", "assets"},

    callback = local_linux_build
})