

#include "imports/imports.fdefine.h"
#ifdef VIBE_EXTENSION_MODULE 
#include VIBE_EXTENSION_MODULE
#endif

int vibescript_start(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);

    #if defined(VIBE_EXTENSION_FUNC) && defined(VIBE_EXTENSION_LIB_NAME)
        LuaCEmbed_load_lib_from_c(l,VIBE_EXTENSION_FUNC,VIBE_EXTENSION_LIB_NAME);
    #endif  

    #ifdef _WIN32
        LuaCEmbed_set_global_string(l,"os_name","windows");
    #elif __APPLE__
        LuaCEmbed_set_global_string(l,"os_name","mac");
    #elif __linux__
        LuaCEmbed_set_global_string(l,"os_name","linux"); 
    #endif

    LuaCEmbed_load_lib_from_c(l,load_luaDoTheWorld,"dtw");
    LuaCEmbed_load_lib_from_c(l,load_lua_fluid_json,"json");
    LuaCEmbed_load_lib_from_c(l,serjao_berranteiro_start_point,"serjao");
    LuaCEmbed_load_lib_from_c(l,load_lua_bear,"luabear");
    LuaCEmbed_add_callback(l,"newRawLLM",private_new_raw_llm);
    LuaCEmbed_add_callback(l,"save_encrypted_prop",private_save_encrypted_data);
    LuaCEmbed_add_callback(l,"get_encrypted_prop",private_get_encrypted_data);
 


    return LuaCembed_perform(l);
}