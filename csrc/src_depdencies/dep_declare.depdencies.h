#include "../../dependencies/BearHttpsClient.h"

#define error LUA_CEMBED_ERROR
#include "../../dependencies/LuaCEmbed.h"
#undef error
#include "../../dependencies/doTheWorld.h"
#include "../../dependencies/SDK_OpenAI.h"
#include "../../dependencies/luaDoTheWorld_no_dep.c"
#include "../../dependencies/luaFluidJson_no_dep.c"
