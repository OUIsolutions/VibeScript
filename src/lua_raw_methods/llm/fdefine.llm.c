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
    UniversalGarbage *garbage = (UniversalGarbage *)lua_n.tables.get_long_prop(self,"garbage");
    UniversalGarbage_free(garbage);
    return NULL;
}


char *vibe_callback_handler(cJSON *args, void *pointer){

    char *public_name = (char *)pointer;
    printf("chamou aqui\n");

    return NULL;
}
LuaCEmbedResponse *add_function(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)lua_n.tables.get_long_prop(self,"openAi");
    char *name = lua_n.args.get_str(args,0);
    char *description = lua_n.args.get_str(args,1);
    LuaCEmbedTable *parameters = lua_n.args.get_table(args,2);

    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    for(int i = 0; i < lua_n.tables.get_size(parameters); i++){
        LuaCEmbedTable *param = lua_n.tables.get_sub_table_by_index(parameters,i);

        if(lua_n.has_errors(args)){
            return lua_n.response.send_error(lua_n.get_error_message(args));
        }
        char *param_name = lua_n.tables.get_string_prop(param,"name");
        char *param_description = lua_n.tables.get_string_prop(param,"description");
        char *param_type = lua_n.tables.get_string_prop(param,"type");
        bool required = lua_n.tables.get_bool_prop(param,"required");
        if(lua_n.has_errors(args)){
            return lua_n.response.send_error(lua_n.get_error_message(args));
        }
    }
    DtwStringArray *functionsNames = (DtwStringArray *)lua_n.tables.get_long_prop(self,"functionsNames");
    if(dtw.string_array.find_position(functionsNames,name) != -1){
        return lua_n.response.send_error("Function already exists");
    }
    dtw.string_array.append(functionsNames,name);


    char *public_name = NULL;
    while (true){
        DtwRandonizer *randonizer = dtw.randonizer.newRandonizer();
        public_name = dtw.randonizer.generate_token(randonizer, 10);
        
        if(lua_n.globals.get_type(public_name) == lua.types.NILL){
            break;
        }
        free(public_name);
        public_name = NULL;
        dtw.randonizer.free(randonizer);
    }

    UniversalGarbage *garbage =  (UniversalGarbage *)lua_n.tables.get_long_prop(self,"garbage");
    UniversalGarbage_add(garbage,dtw.string_array.free,functionsNames);

    lua_n.args.generate_arg_clojure_evalation(args,3,"function(callback)\n llm_clojure%s = callback  end\n");

    OpenAiCallback *callback = new_OpenAiCallback(vibe_callback_handler,public_name, name,description, false);

    for(int i = 0; i < lua_n.tables.get_size(parameters); i++){
        LuaCEmbedTable *param = lua_n.tables.get_sub_table_by_index(parameters,i);
        char *param_name = lua_n.tables.get_string_prop(param,"name");
        char *param_description = lua_n.tables.get_string_prop(param,"description");
        char *param_type = lua_n.tables.get_string_prop(param,"type");
        bool required = lua_n.tables.get_bool_prop(param,"required");
        OpenAiInterface_add_parameters_in_callback(callback,param_name,param_description,param_type,required);
    }
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);




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
   
    DtwStringArray *functionsNames = dtw.string_array.new();
    lua_n.tables.set_long_prop(self,"functionsNames",(PTR_CAST)functionsNames);

    UniversalGarbage *garbage = newUniversalGarbage();

    UniversalGarbage_add(garbage,openai.openai_interface.free,openAi);
    UniversalGarbage_add(garbage,dtw.string_array.free,functionsNames);

    lua_n.tables.set_long_prop(self,"garbage",(PTR_CAST)garbage);
  
   
    lua_n.tables.set_method(self,ADD_USER_PROMPT,add_user_prompt);
    lua_n.tables.set_method(self,ADD_SYSTEM_PROMPT,add_system_prompt);
    lua_n.tables.set_method(self,ADD_ASSISTANT_PROMPT,add_assistant_prompt);
    lua_n.tables.set_method(self,GENERATE,make_question);
    lua_n.tables.set_method(self,ADD_FUNCTION,add_function);
    lua_n.tables.set_method(self,"__gc",delete_llm);
    freeModelProps(props);
    return lua_n.response.send_table(self);

}


