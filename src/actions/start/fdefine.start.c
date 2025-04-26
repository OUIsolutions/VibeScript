//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.globals.h"
//silver_chain_scope_end



int start_action(int argc, char **argv){
    
  

    lua_virtual_machine = lua_n.newLuaEvaluation();
    const char *file_to_interpret = args.get_arg(&args_obj, 1);


    LuaCEmbedTable *table = lua_n.globals.new_table(lua_virtual_machine,"arg");
    for(int i = 0; i < argc; i++){
        lua_n.tables.append_string(table, argv[i]);
    }


    lua_n.load_native_libs(lua_virtual_machine);
    
    lua_n.add_global_callback(lua_virtual_machine,NEW_RAW_LLM, new_rawLLM);
    lua_n.load_lib_from_c(lua_virtual_machine,load_luaDoTheWorld,"dtw");
    lua_n.load_lib_from_c(lua_virtual_machine,load_lua_fluid_json,"json");
    lua_n.evaluate(lua_virtual_machine,get_asset("lua_src.lua")->data);
    lua_n.evaluete_file(lua_virtual_machine, file_to_interpret);
    
    if(lua_n.has_errors(lua_virtual_machine)){
        char *error = lua_n.get_error_message(lua_virtual_machine);
        printf("%sError: %s\n%s",RED, error,RESET);
        lua_n.free(lua_virtual_machine);
        return 1;
    }
    lua_n.free(lua_virtual_machine);

    return 0;
}