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
    openai.openai_interface.add_user_prompt(openAi, prompt);
    return NULL;
}

LuaCEmbedResponse *add_system_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    openai.openai_interface.add_system_prompt(openAi, prompt);
    return NULL;

}

LuaCEmbedResponse *add_assistant_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    openai.openai_interface.add_assistent_prompt(openAi, prompt);
    return NULL;
}
LuaCEmbedResponse *make_question(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    
    OpenAiResponse *response = openai.openai_interface.make_question(openAi);
    if(openai.response.error(response)){
        return lua_n.response.send_error(openai.response.get_error_message(response));
    }
    const char *answer = openai.response.get_content_str(response,0);
    return lua_n.response.send_str(answer);
}

LuaCEmbedResponse *delete_llm(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    openai.openai_interface.free(openAi);
    dtw.string_array.free((DtwStringArray *)lua_n.tables.get_long_prop(self,"functionsNames"));
    return NULL;
}


char *vibe_callback_handler(cJSON *args, void *pointer){

    return NULL;
}
LuaCEmbedResponse *add_function(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    char *name = lua_n.args.get_str(args,0);
    char *description = lua_n.args.get_str(args,1);
    char *parameters = lua_n.args.get_str(args,2);

    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }


    lua_n.args.generate_arg_clojure_evalation(args,3,"function(callback)\n curent_clojure_callback = callback  end\n");
    LuaCEmbedTable *functions = (LuaCEmbedTable *)lua_n.tables.get_long_prop(self,"functions");
    lua_n.tables.set_evaluation_prop(functions,name_ptr,"curent_clojure_callback");

    
    OpenAiCallback *callback = new_OpenAiCallback(vibe_callback_handler,name_ptr, name,description, false);






    return NULL;
}

LuaCEmbedResponse *new_rawLLM(LuaCEmbed *args){

    ModelProps *props =collect_model_props();
    if(!props){
        return lua_n.response.send_error("Failed to collect model props");
    }
    
    LuaCEmbedTable *self = lua_n.tables.new_anonymous_table(args);
    OpenAiInterface *openAi = openai.openai_interface.newOpenAiInterface(props->url, props->key, props->model);

    lua_n.tables.set_long_prop(self,"openAi",(PTR_CAST)openAi);
   
    LuaCEmbedTable *functions = lua_n.tables.new_anonymous_table(args);
    lua_n.tables.set_long_prop(self,"functions",(PTR_CAST)functions);

   
    lua_n.tables.set_method(self,ADD_USER_PROMPT,add_user_prompt);
    lua_n.tables.set_method(self,ADD_SYSTEM_PROMPT,add_system_prompt);
    lua_n.tables.set_method(self,ADD_ASSISTANT_PROMPT,add_assistant_prompt);
    lua_n.tables.set_method(self,GENERATE,make_question);
    lua_n.tables.set_method(self,"__gc",delete_llm);
    freeModelProps(props);
    return lua_n.response.send_table(self);

}


