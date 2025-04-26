//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.globals.h"
//silver_chain_scope_end


LuaCEmbedResponse *add_user_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    OpenAiInterface_add_user_prompt(openAi, prompt);
    return NULL;
}

LuaCEmbedResponse *add_system_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    OpenAiInterface_add_system_prompt(openAi, prompt);
    return NULL;

}

LuaCEmbedResponse *add_assistant_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    OpenAiInterface_add_assistant_prompt(openAi, prompt);
    return NULL;
}
LuaCEmbedResponse *make_question(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    OpenAiResponse *response = openai.openai_interface.make_question(openAi);
    if(openai.response.error(response)){
        return lua_n.response.send_error(openai.response.get_error_message(response));
    }
    char *answer = openai.response.get_content_str(response,0);
    return lua_n.response.send_str(answer);
}

LuaCEmbedResponse *delete_llm(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    openai.openai_interface.free(openAi);
    return NULL;
}



LuaCEmbedResponse *new_rawLLM(LuaCEmbed *args){


    LuaCEmbedTable *self = lua_n.tables.new_anonymous_table(args);
    OpenAiInterface *openAi = openai.openai_interface.newOpenAiInterface(props->url, props->key, props->model);

    lua_n.tables.set_long_prop(self,"openAi",(PTR_CAST)openAi);

    return lua_n.response.send_table(self);

}


