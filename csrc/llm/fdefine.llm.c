//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.fdeclare.h"
//silver_chain_scope_end


LuaCEmbedResponse *add_user_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    char *prompt = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    OpenAi(openAi, prompt);
    return NULL;
}


LuaCEmbedResponse *add_system_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    
    char *prompt = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    OpenAiINte(openAi, prompt);
    return NULL;

}

LuaCEmbedResponse *add_assistant_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(PTR_CAST)lua_n.tables.get_long_prop(self,"openAi");
    
    char *prompt = lua_n.args.get_str(args,0);
    if(lua_n.has_errors(args)){
        return lua_n.response.send_error(lua_n.get_error_message(args));
    }
    openai.openai_interface.add_assistent_prompt(openAi, prompt);
    return NULL;
}
LuaCEmbedResponse *make_question(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(PTR_CAST)lua_n.tables.get_long_prop(self,"openAi");
    
    OpenAiResponse *response = OpenAiInterface_make_question_finish_reason_treated(openAi);
    if(openai.response.error(response)){
        return lua_n.response.send_error(openai.response.get_error_message(response));
    }
    const char *answer = openai.response.get_content_str(response,0);
    return lua_n.response.send_str(answer);
}

LuaCEmbedResponse *delete_llm(LuaCEmbedTable *self, LuaCEmbed *args){
    UniversalGarbage *garbage = (UniversalGarbage *)(PTR_CAST)lua_n.tables.get_long_prop(self,"garbage");
    UniversalGarbage_free(garbage);
    return NULL;
}


char *vibe_callback_handler(cJSON *args, void *pointer){

    char *public_name = (char *)pointer;
    LuaCEmbedTable *parsed_args = NULL;
    if(cJSON_IsObject(args)){
        parsed_args = private_lua_fluid_parse_object(lua_virtual_machine, args);
    }
    else if(cJSON_IsArray(args)){
        parsed_args = private_lua_fluid_parse_array(lua_virtual_machine, args);
    }
    LuaCEmbedTable *args_array = lua_n.tables.new_anonymous_table(lua_virtual_machine);
    lua_n.tables.append_table(args_array,parsed_args);

    LuaCEmbedTable *response = lua_n.globals.run_global_lambda(lua_virtual_machine,public_name,args_array,1);
    
    if(lua_n.has_errors(lua_virtual_machine)){
        return strdup(lua_n.get_error_message(lua_virtual_machine));
    }


    if(lua_n.tables.get_size(response) == 0){
        return strdup("Nil");
    }
    
    cJSON *json_response = lua_fluid_json_dump_to_cJSON_array(response);
    if(json_response == NULL){
        return strdup("Nil");
    }
    char *json_response_str = cJSON_Print(json_response);
    cJSON_Delete(json_response);
    return json_response_str;
}
LuaCEmbedResponse *add_function(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(PTR_CAST)lua_n.tables.get_long_prop(self,"openAi");
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
    DtwStringArray *functionsNames = (DtwStringArray *)(PTR_CAST)lua_n.tables.get_long_prop(self,"functionsNames");
    if(dtw.string_array.find_position(functionsNames,name) != -1){
        return lua_n.response.send_error("Function already exists");
    }
    dtw.string_array.append(functionsNames,name);


    char *public_name = NULL;
    while (true){
        DtwRandonizer *randonizer = dtw.randonizer.newRandonizer();
        char *token = dtw.randonizer.generate_token(randonizer, 20);
        public_name = malloc(40);
        sprintf(public_name,"llm_clojure%s",token);
        free(token);
        if(lua_n.globals.get_type(args, public_name) == lua_n.types.NILL){
            break;
        }
        free(public_name);
        public_name = NULL;
        dtw.randonizer.free(randonizer);
    }

    UniversalGarbage *garbage =  (UniversalGarbage *)(PTR_CAST)lua_n.tables.get_long_prop(self,"garbage");
    UniversalGarbage_add(garbage,dtw.string_array.free,functionsNames);

    lua_n.args.generate_arg_clojure_evalation(args,3,"function(callback)\n %s = callback  end\n",public_name);
    
    OpenAiCallback *callback = new_OpenAiCallback(vibe_callback_handler,public_name, name,description, true);

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

LuaCEmbedResponse *private_new_raw_llm(LuaCEmbed *args){

    ModelProps *props =collect_model_props();
        return lua_n.response.send_error("Failed to collect model props");
    }
    

    lua_n.tables.set_long_prop(self,"openAi",(PTR_CAST)openAi);
   
    DtwStringArray *functionsNames = dtw.string_array.newStringArray();
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


