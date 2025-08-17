clpr = clpr_module.newOrchestrator({
    args = arg,
    database_path = ".clpr",
    write_file = dtw.write_file,
    remove_dir = dtw.remove_any,
    load_file = dtw.load_file,
    dumper = dtw.serialize_var,
    loader = dtw.interpret_serialized_var,
    get_pid = dtw.get_pid,
    is_pid_alive = dtw.is_pid_alive,
    kill_process_by_pid = dtw.kill_process,
})