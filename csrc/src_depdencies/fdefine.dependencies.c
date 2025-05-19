//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.fdeclare.h"
//silver_chain_scope_end

#define error LUA_CEMBED_ERROR
#include "../../dependencies/LuaCEmbed.c"
#undef error
#include "../../dependencies/doTheWorld.c"
#include "../../dependencies/luaFluidJson_no_dep.c"
#include "../../dependencies/BearHttpsClient.c"
#include "../../dependencies/SDK_OpenAI.c"