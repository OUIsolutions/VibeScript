function windowsi32_build()
  

    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("debian:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apt-get update")
    image.add_comptime_command("apt-get -y install mingw-w64")
    local compiler = "i686-w64-mingw32-gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "i686-w64-mingw32-g++"
    end

    image.start({
        volumes = {
            { "././release", "/release" },
        },
        command = compiler..[[ --static /release/amalgamation.c  -o /release/vibescripti32.exe -lws2_32]]
    })
end

darwin.add_recipe({
    name = "windowsi32_build",
    requires={"amalgamation"},
    description = "Builds a static Windows 32-bit executable (windowsi32.exe) using MinGW",
    outs = { "release/vibescripti32.exe" },
    inputs = { "release/amalgamation.c", "csrc", "luasrc", "dependencies", "assets" },
    callback = windowsi32_build
})