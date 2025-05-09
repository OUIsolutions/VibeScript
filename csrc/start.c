

#include "imports/imports.fdefine.h"

int vibescript_start(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    LuaCEmbed_load_lib_from_c(l,load_luaDoTheWorld,"dtw");
    return LuaCembed_perform(l);
}