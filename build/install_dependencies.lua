

function Install_dependencies()
    os.execute("mkdir -p dependencies")

    local libs = {
        { url = "https://github.com/OUIsolutions/DoTheWorld/releases/download/10.0.1/doTheWorld.h", path = "dependencies/doTheWorld.h" },
        { url = "https://github.com/OUIsolutions/DoTheWorld/releases/download/10.0.1/doTheWorld.c", path = "dependencies/doTheWorld.c" },
        { url = "https://github.com/OUIsolutions/BearHttpsClient/releases/download/0.4.0/BearHttpsClient.h", path = "dependencies/BearHttpsClient.h" },
        { url = "https://github.com/OUIsolutions/BearHttpsClient/releases/download/0.4.0/BearHttpsClient.c", path = "dependencies/BearHttpsClient.c" },
        { url = "https://github.com/SamuelHenriqueDeMoraisVitrio/ClientSDKOpenAI/releases/download/0.0.10/SDK_OpenAI.c", path = "dependencies/SDK_OpenAI.c" },
        { url = "https://github.com/SamuelHenriqueDeMoraisVitrio/ClientSDKOpenAI/releases/download/0.0.10/SDK_OpenAI.h", path = "dependencies/SDK_OpenAI.h" },
        {url = "https://github.com/OUIsolutions/LuaCEmbed/releases/download/0.8.3/LuaCEmbed.c", path = "dependencies/LuaCEmbed.c"},
        {url = "https://github.com/OUIsolutions/LuaCEmbed/releases/download/0.8.3/LuaCEmbed.h", path = "dependencies/LuaCEmbed.h"},
        {url = "https://github.com/OUIsolutions/LuaDoTheWorld/releases/download/0.7.1/luaDoTheWorld_no_dep.c", path = "dependencies/luaDoTheWorld_no_dep.c"},
        {url = "https://github.com/OUIsolutions/LuaFluidJson/releases/download/0.6.1/luaFluidJson_no_dep.c", path = "dependencies/luaFluidJson_no_dep.c"},
        {url="https://github.com/OUIsolutions/Lua-Bear/releases/download/0.2.0/luaBear_no_dep.c", path = "dependencies/luaBear_no_dep.c"},
        {url="https://github.com/OUIsolutions/CWebStudio/releases/download/4.0.0/CWebStudio.h", path = "dependencies/CWebStudio.h"},
        {url="https://github.com/OUIsolutions/CWebStudio/releases/download/4.0.0/CWebStudio.c", path = "dependencies/CWebStudio.c"},
        {url="https://github.com/SamuelHenriqueDeMoraisVitrio/SerjaoBerranteiroServer/releases/download/V6/serjao_no_dep.c", path = "dependencies/serjao_no_dep.c"},
        {url = "https://github.com/OUIsolutions/LuaArgv/releases/download/0.07/luargv.lua", path = "dependencies/luargv.lua"},
        {url="https://github.com/OUIsolutions/LuaShip/releases/download/0.2.0/LuaShip.lua", path = "dependencies/LuaShip.lua"}
    }
    for _, lib in ipairs(libs) do
        local executor = function()
            os.execute("curl -L " .. lib.url .. " -o " .. lib.path)
        end
        local side_effect_verifier = function()
            return darwin.dtw.generate_sha_from_file(lib.path)
        end
        cache_execution({ "download", lib.url, lib.path }, executor, side_effect_verifier)

    end
end
