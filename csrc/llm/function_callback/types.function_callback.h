//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.macros.h"
//silver_chain_scope_end


typedef struct FunctionCallbackArgs{
    char function_name[100];
    LuaCEmbed *lua_virtual_machine;
}FunctionCallbackArgs;