//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.globals.h"
//silver_chain_scope_end


FunctionCallbackArgs *newFunctionCallbackArgs(const char *function_name, LuaCEmbed *lua_virtual_machine){
    FunctionCallbackArgs *self = (FunctionCallbackArgs *)malloc(sizeof(FunctionCallbackArgs));
    *self = (FunctionCallbackArgs){0};
    char *name_sha = dtw_generate_sha_from_string(function_name);
    sprintf(self->function_name,"llm_func_%s",name_sha);
    free(name_sha);
    self->lua_virtual_machine = lua_virtual_machine;
    return self;

}
void FunctionCallbackArgsfree(FunctionCallbackArgs *self){
    free(self);
}
