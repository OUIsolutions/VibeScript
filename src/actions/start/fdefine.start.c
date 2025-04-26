


int start_action(int argc, char **argv){
    
  

    LuaCEmbed * l = lua_n.newLuaEvaluation();
    const char *file_to_interpret = args.get_arg(&args_obj, 1);


    LuaCEmbedTable *table = lua_n.globals.new_table(l,"arg");
    for(int i = 0; i < argc; i++){
        lua_n.tables.append_string(table, argv[i]);
    }


    lua_n.load_native_libs(l);
    
    lua_n.add_global_callback(l,NEW_RAW_LLM, new_rawLLM);
    lua_n.load_lib_from_c(l,load_luaDoTheWorld,"dtw");
    lua_n.evaluate(l,get_asset("lua_src.lua")->data);
    lua_n.evaluete_file(l, file_to_interpret);
    
    if(lua_n.has_errors(l)){
        char *error = lua_n.get_error_message(l);
        printf("%sError: %s\n%s",RED, error,RESET);
        lua_n.free(l);
        return 1;
    }
    lua_n.free(l);

    return 0;
}