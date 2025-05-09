
function local_linux_build()

    amalgamation_build()
    os.execute("gcc release/amalgamation.c -o vibescript")
   
end