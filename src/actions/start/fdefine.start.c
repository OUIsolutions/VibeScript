//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.globals.h"
//silver_chain_scope_end

char * collect_user_input(){
  char *buffer = (char*)malloc(100);
  int buffer_size = 100;
  int i = 0;
  char last_char = '\0';
  while(true){

    char c = getchar();
    if(c == '\n' && last_char != '\\'){
      buffer[i] = '\0';
      break;
    }

    if(i >= buffer_size - 1){
      buffer_size *= 2;
      buffer = (char*)realloc(buffer, buffer_size);
    }

    buffer[i] = c;
    last_char = c;
    i++;
  }
  return buffer;
}

int start_action(){
    /*
    ModelProps *props =collect_model_props();
    if(!props){
        return 1;
    }
    OpenAiInterface *openAi = openai.openai_interface.newOpenAiInterface(props->url, props->key, props->model);
    */

    LuaCEmbed * l = lua_n.newLuaEvaluation();
    const char *file_to_interpret = args.get_arg(&args_obj, 1);

    lua_n.evaluete_file(l, file_to_interpret);
    
    if(lua_n.has_errors(l)){
        char *error = lua_n.get_error_message(l);
        printf("%sError: %s\n%s",RED, error,RESET);
        free(error);
        lua_n.free(l);
        return 1;
    }
    lua_n.free(l);

    return 0;
}