local cachify = load_global_module("cachify")
local shipyard = load_global_module("shipyard")

function main()

    local session = luaberrante.newTelegramSession({
        token = get_prop("devops.validator.token"),
        id_chat = get_prop("devops.validator.chat_id")
    }, luabear.fetch)

    os.execute("git reset --hard origin/main")
    os.execute("git pull")

    cachify.register_first({
        sources = { "darwindeps.json" },
        cache_name = "darwindeps",
        cache_dir = ".cachify"
    })

    cachify.register_first({
        sources = { "csrc", "luasrc", "dependencies", "assets", "darwinconf.lua", "build" },
        cache_name = "release",
        cache_dir = ".cachify"
    })

    os.execute("darwin update darwindeps.json")

    cachify.execute_config({
        sources = { "darwindeps.json" },
        callback = function()
            dtw.remove_any("dependencies")
            os.execute("darwin install darwindeps.json")
            os.execute("git add .")
            os.execute("git commit -m 'deps: update dependencies'")
            os.execute("git push")
            session.sendMessage({ text = "📦 Dependencies updated successfully on VibeScript! ✅" })
        end,
        cache_name = "darwindeps",
        cache_dir = ".cachify",
        ignore_first = true
    })

    cachify.execute_config({
        sources = { "csrc", "luasrc", "dependencies", "assets", "darwinconf.lua", "build" },
        callback = function()
            print("⚙️ Detected source changes — preparing new release...")
            dtw.remove_any("release")

            shipyard.increment_replacer("release.json", "PATCH_VERSION")

            os.execute("git add .")
            os.execute("git commit -m 'release: prepare new VibeScript release'")
            os.execute("git push")

            session.sendMessage({ text = "🚀 Preparing new VibeScript release... ✅" })

            local ok = os.execute("darwin run_blueprint --target all")
            if not ok then
                session.sendMessage({ text = "❌ Error running blueprints for VibeScript!" })
                return
            end

            local ok_gen, err = pcall(shipyard.generate_release_from_json, "release.json")
            if not ok_gen then
                session.sendMessage({ text = "❌ Error generating release:\n" .. err })
                return
            end

            os.execute("gh release view > release.log")
            local log = dtw.load_file("release.log")
            session.sendMessage({
                text = "🎉 New VibeScript release generated successfully! ✅\n\n📋 Release Details:\n" .. log
            })
        end,
        cache_name = "release",
        cache_dir = ".cachify",
        ignore_first = true
    })
end

main()
