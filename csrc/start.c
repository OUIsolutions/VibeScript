

#include "imports/imports.fdefine.h"

int vibescript_start(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    LuaCEmbed_load_lib_from_c(l,load_luaDoTheWorld,"dtw");
    LuaCEmbed_load_lib_from_c(l,load_lua_fluid_json,"json");

    #ifdef _WIN32
    LuaCEmbed_set_global_string(l,"os_name","windows");
    #elif __APPLE__
    LuaCEmbed_set_global_string(l,"os_name","mac");
    #elif __linux__
    LuaCEmbed_set_global_string(l,"os_name","linux"); 
    #endif

    
    return LuaCembed_perform(l);
}