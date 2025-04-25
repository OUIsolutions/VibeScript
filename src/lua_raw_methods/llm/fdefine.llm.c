//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.globals.h"
//silver_chain_scope_end




LuaCEmbedResponse *new_rawLLM(LuaCEmbed *args){


    LuaCEmbedTable *self = lua_n.tables.new_anonymous_table(args);
    OpenAiInterface *openAi = openai.openai_interface.newOpenAiInterface(props->url, props->key, props->model);

    lua_n.tables.set_long_prop(self,"openAi",(PTR_CAST)openAi);

    return lua_n.response.send_table(self);

}


