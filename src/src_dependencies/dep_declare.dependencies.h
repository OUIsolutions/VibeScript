
#include "../../dependencies/BearHttpsClient.h"
#include "../../dependencies/CArgvParse.h"
#include "../../dependencies/doTheWorld.h"
#include "../../dependencies/SDK_OpenAI.h"
#include "../../dependencies/LuaCEmbed.h"

int load_luaDoTheWorld(lua_State *L);
int load_lua_fluid_json(lua_State *state);

LuaCEmbedTable * private_lua_fluid_parse_object(LuaCEmbed *args, cJSON *json_object);
LuaCEmbedTable * private_lua_fluid_parse_array(LuaCEmbed *args, cJSON *json_array);
cJSON  * lua_fluid_json_dump_to_cJSON_array(LuaCEmbedTable *table);