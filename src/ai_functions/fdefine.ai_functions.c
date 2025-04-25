//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.globals.h"
//silver_chain_scope_end


char *agent_list_recursively(cJSON *args, void *pointer){
    const char *model = (const char*)pointer;
    cJSON *path = cJSON_GetObjectItem(args, "path");
    if(!cJSON_IsString(path)){
        return NULL;
    }
    DtwStringArray *all_itens = dtw.list_files_recursively(path->valuestring,false);
    cJSON *all_intens_cjson = cJSON_CreateArray();
    for(int i = 0; i < all_itens->size; i++){

        char *current_file = all_itens->strings[i]; 

        bool is_hidden = dtw_starts_with(current_file, ".");
        if(!is_hidden){
            char *joined = dtw_concat_path(path->valuestring, current_file);
            cJSON_AddItemToArray(all_intens_cjson, cJSON_CreateString(joined));
            free(joined);
        }

    }
    dtw.string_array.free(all_itens);
    char *all_intens_string = cJSON_PrintUnformatted(all_intens_cjson);
    cJSON_Delete(all_intens_cjson);
    printf("%s %s LISTED RECURSIVELY: %s%s\n",YELLOW,model, path->valuestring, RESET);
    return all_intens_string;    
}



void configure_list_recursively_callbacks(OpenAiInterface *openAi,const char *model){
    OpenAiCallback *callback = new_OpenAiCallback(agent_list_recursively,(void*)model, "list_recursively", "list all files recursively in a path", false);
    OpenAiInterface_add_parameters_in_callback(callback, "path", "Pass the path you want to list recursively.", "string", true);
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
}

char *agent_read_file(cJSON *args, void *pointer){
    const char *model = (const char*)pointer;
    cJSON *path = cJSON_GetObjectItem(args, "path");
    if(!cJSON_IsString(path)){
        return NULL;
    }
    char *content =dtw.load_string_file_content(path->valuestring);
    printf("%s %s READDED: %s%s\n",YELLOW,model, path->valuestring, RESET);
    return content;
}

void configure_read_file_callbacks(OpenAiInterface *openAi,const char *model){
    OpenAiCallback *callback = new_OpenAiCallback(agent_read_file, (void*)model, "read_file", "read a file content", false);
    OpenAiInterface_add_parameters_in_callback(callback, "path", "Pass the path you want to read.", "string", true);
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
}


char *agent_write_file(cJSON *args, void *pointer){
    const char *model = (const char*)pointer;
    cJSON *path = cJSON_GetObjectItem(args, "path");
    cJSON *content = cJSON_GetObjectItem(args, "content");
    if(!cJSON_IsString(path) || !cJSON_IsString(content)){
        return NULL;
    }
    dtw.write_string_file_content(path->valuestring, content->valuestring);
    printf("%s %s WRITE: %s%s\n",YELLOW,model, path->valuestring, RESET);
    return (char*)"file wrotted";
}

void configure_write_file_callbacks(OpenAiInterface *openAi,const char *model){
    OpenAiCallback *callback = new_OpenAiCallback(agent_write_file, (void*)model, "write_file", "write a file content", false);
    OpenAiInterface_add_parameters_in_callback(callback, "path", "Pass the path you want to write.", "string", true);
    OpenAiInterface_add_parameters_in_callback(callback, "content", "Pass the content you want to write.", "string", true);
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
}

char *agent_execute_command(cJSON *args, void *pointer){
    const char *model = (const char*)pointer;
    cJSON *command = cJSON_GetObjectItem(args, "command");
    if(!cJSON_IsString(command)){
        return NULL;
    }
    int result = system(command->valuestring);
    printf("%s %s EXECUTED COMMAND: %s%s\n",YELLOW,model, command->valuestring, RESET);
    char *result_str = (char*)malloc(20);
    sprintf(result_str, "%d", result);
    return result_str;
}

void configure_execute_command_callbacks(OpenAiInterface *openAi,const char *model){
    OpenAiCallback *callback = new_OpenAiCallback(agent_execute_command, (void*)model, "execute_command", "execute a command", false);
    OpenAiInterface_add_parameters_in_callback(callback, "command", "Pass the command you want to execute.", "string", true);
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
}

char *agent_remove_file(cJSON *args, void *pointer){
    cJSON *path = cJSON_GetObjectItem(args, "path");
    if(!cJSON_IsString(path)){
        return NULL;
    }
    dtw.remove_any(path->valuestring);
    printf("%s AI REMOVED: %s%s\n",YELLOW, path->valuestring, RESET);
    return (char*)"file or directory removed";
}

void configure_remove_file_callbacks(OpenAiInterface *openAi,const char *model){
    OpenAiCallback *callback = new_OpenAiCallback(agent_remove_file, (void*)model, "remove_file", "remove a file or directory", false);
    OpenAiInterface_add_parameters_in_callback(callback, "path", "Pass the path you want to remove.", "string", true);
    OpenAiInterface_add_callback_function_by_tools(openAi, callback);
}





