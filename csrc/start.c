

#include "imports/imports.fdefine.h"

int vibescript_start(lua_State *state){
    LuaCEmbed * l  = newLuaCEmbedLib(state);
    return LuaCembed_perform(l);
}