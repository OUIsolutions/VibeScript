//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.fdeclare.h"
//silver_chain_scope_end



LuaCEmbedResponse *private_save_encrypted_data(LuaCEmbed *args){
    const char *props_path = LuaCEmbed_get_str_arg(args,0);
    long name_size;
    unsigned char *name = LuaCEmbed_get_raw_str_arg(args,&name_size,1);
    LuaCEmbedTable *data = LuaCembed_new_anonymous_table(args);
    LuaCEmbedTable_append_arg(data,2);
    printf("saving prop %s\n",name);
    printf("props path %s\n",props_path);

    privateLuaDtwStringAppender *appender = newprivateLuaDtwStringAppender();
    ldtw_serialize_first_value_of_table(appender, data);


    char *name_sha = dtw_generate_sha_from_any(name,name_size);
    char *full_path = dtw_concat_path(props_path,name_sha);
    free(name_sha);
    dtw_write_any_content(full_path,appender->buffer,appender->length);
    free(full_path);
    privateLuaDtwStringAppender_free(appender);
    return NULL;
}


LuaCEmbedResponse *private_get_encrypted_data(LuaCEmbed *args){
    const char *props_path = LuaCEmbed_get_str_arg(args,0);
    long name_size;
    unsigned char *name = LuaCEmbed_get_raw_str_arg(args,&name_size,1);
    char *name_sha = dtw_generate_sha_from_any(name,name_size);
    char *full_path = dtw_concat_path(props_path,name_sha);
    long size;
    bool is_binary;
    unsigned char *content = dtw_load_any_content(full_path,&size,&is_binary);
    free(name_sha);
    free(full_path);

    if(!content){
        return NULL;
    }
    LuaCEmbedResponse *response =  LuaCEmbed_send_evaluation(content);
    free(content);
    return response;    
}