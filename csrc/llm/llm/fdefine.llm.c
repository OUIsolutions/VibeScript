//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.fdeclare.h"
//silver_chain_scope_end


LuaCEmbedResponse *add_user_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    char *prompt = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    OpenAiInterface_add_user_prompt(openAi, prompt);
    return NULL;
}


LuaCEmbedResponse *add_system_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    
    char *prompt = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    OpenAiInterface_add_system_prompt(openAi, prompt);
    return NULL;

}

LuaCEmbedResponse *add_assistant_prompt(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    
    char *prompt = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    OpenAiInterface_add_assistent_prompt(openAi, prompt);
    return NULL;
}
LuaCEmbedResponse *make_question(LuaCEmbedTable *self, LuaCEmbed *args){
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
    OpenAiResponse *response = OpenAiInterface_make_question_finish_reason_treated(openAi);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    const char *answer = OpenAiResponse_get_content_str(response,0);
    return LuaCEmbed_send_str(answer);
}

LuaCEmbedResponse *delete_llm(LuaCEmbedTable *self, LuaCEmbed *args){
    UniversalGarbage *garbage = (UniversalGarbage *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"garbage");
    UniversalGarbage_free(garbage);
    return NULL;
}


char *vibe_callback_handler(cJSON *args, void *pointer){
    
    FunctionCallbackArgs *callback_args = (FunctionCallbackArgs *)pointer;
    LuaCEmbedTable *parsed_args = NULL;

    if(cJSON_IsObject(args)){
        parsed_args = private_lua_fluid_parse_object(callback_args->lua_virtual_machine, args);
    }
    else if(cJSON_IsArray(args)){
        parsed_args = private_lua_fluid_parse_array(callback_args->lua_virtual_machine, args);
    }
    LuaCEmbedTable *args_array = LuaCembed_new_anonymous_table(callback_args->lua_virtual_machine);
    LuaCEmbedTable_append_table(args_array,parsed_args);


    LuaCEmbedTable *response  = LuaCEmbed_run_global_lambda(callback_args->lua_virtual_machine,callback_args->function_name,args_array,1);

  
    if(LuaCEmbed_has_errors(callback_args->lua_virtual_machine)){
        return strdup(LuaCEmbed_get_error_message(callback_args->lua_virtual_machine));
    }

    
    if(LuaCEmbedTable_get_full_size(response) == 0){
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
    OpenAiInterface *openAi = (OpenAiInterface *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"openAi");
  
    char *name = LuaCEmbed_get_str_arg(args,0);
    char *description = LuaCEmbed_get_str_arg(args,1);
    LuaCEmbedTable *parameters = LuaCEmbed_get_arg_table(args,2);

    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }

    for(int i = 0; i < LuaCEmbedTable_get_full_size(parameters); i++){
        LuaCEmbedTable *param = LuaCEmbedTable_get_sub_table_by_index(parameters,i);

        if(LuaCEmbed_has_errors(args)){
            return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
        }
    
        char *param_name = LuaCembedTable_get_string_prop(param,"name");
        char *param_description = LuaCembedTable_get_string_prop(param,"description");
        char *param_type = LuaCembedTable_get_string_prop(param,"type");
        bool required = LuaCembedTable_get_bool_prop(param,"required");
        if(LuaCEmbed_has_errors(args)){
            return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
        }
    
    }
    
    DtwStringArray *functionsNames = (DtwStringArray *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"functionsNames");
    if(DtwStringArray_find_position(functionsNames,name) != -1){
        return LuaCEmbed_send_error("Function already exists");
    }
    DtwStringArray_append(functionsNames,name);


    char *public_name = NULL;
    while (true){
        DtwRandonizer *randonizer = newDtwRandonizer();
        char *token = DtwRandonizer_generate_token(randonizer, 20);
        public_name = malloc(40);
        sprintf(public_name,"llm_clojure%s",token);
        free(token);
        if(LuaCEmbed_get_global_type(args, public_name) == LUA_CEMBED_NIL){
            break;
        }
        free(public_name);
        public_name = NULL;
        DtwRandonizer_free(randonizer);
    }

    UniversalGarbage *garbage =  (UniversalGarbage *)(ldtw_ptr_cast)LuaCembedTable_get_long_prop(self,"garbage");
    FunctionCallbackArgs * callback_args = newFunctionCallbackArgs(public_name, args);

    UniversalGarbage_add(garbage,FunctionCallbackArgsfree,callback_args);


    LuaCEmbed_generate_arg_clojure_evalation(args,3,"function(callback)\n %s = callback  end\n",callback_args);
    
    OpenAiCallback *callback = new_OpenAiCallback(vibe_callback_handler,callback_args, name,description, true);

    for(int i = 0; i < LuaCEmbedTable_get_full_size(parameters); i++){
        LuaCEmbedTable *param = LuaCEmbedTable_get_sub_table_by_index(parameters,i);
        char *param_name = LuaCembedTable_get_string_prop(param,"name");
        char *param_description = LuaCembedTable_get_string_prop(param,"description");
        char *param_type = LuaCembedTable_get_string_prop(param,"type");
        bool required = LuaCembedTable_get_bool_prop(param,"required");
        OpenAiInterface_add_parameters_in_callback(callback,param_name,param_description,param_type,required);    
    }

    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
    return NULL;
}

LuaCEmbedResponse *private_new_raw_llm(LuaCEmbed *args){
    
    char *url = LuaCEmbed_get_str_arg(args,0);
    char *api_key = LuaCEmbed_get_str_arg(args,1);
    char *model = LuaCEmbed_get_str_arg(args,2);
    if(LuaCEmbed_has_errors(args)){
        return LuaCEmbed_send_error(LuaCEmbed_get_error_message(args));
    }
    unsigned char *llm_key = (unsigned char *)malloc(llmkey_size+1);
    llm_get_key(llm_key);
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface((char*)llm_key);
    long out_size;
    bool is_binary;
    char *converted_key = (char*)DtwEncriptionInterface_decrypt_buffer_hex(enc,api_key,&out_size,&is_binary);
    free(llm_key);
    OpenAiInterface *openAi = newOpenAiInterface(url,converted_key,model);
    free(converted_key);
    DtwEncriptionInterface_free(enc);
    
    LuaCEmbedTable *self = LuaCembed_new_anonymous_table(args);
    LuaCEmbedTable_set_long_prop(self,"openAi",(ldtw_ptr_cast)openAi);
   
    DtwStringArray *functionsNames = newDtwStringArray();
    LuaCEmbedTable_set_long_prop(self,"functionsNames",(ldtw_ptr_cast)functionsNames);

    UniversalGarbage *garbage = newUniversalGarbage();

    UniversalGarbage_add(garbage,OpenAiInterface_free,openAi);
    UniversalGarbage_add(garbage,DtwStringArray_free,functionsNames);
    LuaCEmbedTable_set_long_prop(self,"garbage",(ldtw_ptr_cast)garbage);
  
   
    LuaCEmbedTable_set_method(self,"add_user_prompt",add_user_prompt);
    LuaCEmbedTable_set_method(self,"add_system_prompt",add_system_prompt);
    LuaCEmbedTable_set_method(self,"add_assistent_prompt",add_assistant_prompt);
    LuaCEmbedTable_set_method(self,"generate",make_question);
    LuaCEmbedTable_set_method(self,"add_function",add_function);
    LuaCEmbedTable_set_method(self,"__gc",delete_llm);
    return LuaCEmbed_send_table(self);
}


