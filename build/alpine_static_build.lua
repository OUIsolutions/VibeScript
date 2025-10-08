
function alpine_static_build()
  

    os.execute("mkdir -p release")

    local image = darwin.ship.create_machine("alpine:latest")
    image.provider = CONTANIZER
    image.add_comptime_command("apk update")
    image.add_comptime_command("apk add --no-cache gcc g++ musl-dev curl")
    local compiler = "gcc"
    if LAUNGUAGE == "cpp" then
        compiler = "g++"
    end

    image.start({
        volumes = {
            { "././release", "/release" },

        },
        command = compiler..[[ --static /release/amalgamation.c   -o /release/vibescript.out]]

    })
end

darwin.add_recipe({
    name = "alpine_static_build",
    requires={"amalgamation"},
    description = "builds a static binary inside an Alpine container",
    outs = {"release/vibescript.out"},
    inputs = {"release/amalgamation.c"}, 
    callback = alpine_static_build
})