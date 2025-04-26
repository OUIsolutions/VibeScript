
#include "../../dependencies/BearHttpsClient.h"
#include "../../dependencies/CArgvParse.h"
#include "../../dependencies/doTheWorld.h"
#include "../../dependencies/SDK_OpenAI.h"
#include "../../dependencies/LuaCEmbed.h"

int load_luaDoTheWorld(lua_State *L);
int load_lua_fluid_json(lua_State *state);