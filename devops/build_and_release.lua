
load_global_module("shipyard")
dtw.remove_any("dependencies")
dtw.remove_any("release")
os.execute("darwin install")
os.execute("darwin run_blueprint build/ --mode folder amalgamation_build alpine_static_build windowsi32_build windows64_build rpm_static_build debian_static_build --contanizer podman ")
SHIPYARD_API.generate_release_from_json("devops/release.json")
