//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.types.h"
//silver_chain_scope_end


FunctionCallbackArgs *newFunctionCallbackArgs(const char *function_name, LuaCEmbed *lua_virtual_machine);

void FunctionCallbackArgsfree(FunctionCallbackArgs *self);