//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.fdeclare.h"
//silver_chain_scope_end


LuaCEmbedResponse *get_config_name(LuaCEmbed *args){
    unsigned char *key = (unsigned char *)malloc(name_encrypt_keykey_size+1);
    name_encrypt_key_get_key(key);
    char *key_sha = dtw_generate_sha_from_any(key,name_encrypt_keykey_size);
    LuaCEmbedResponse *response = LuaCEmbed_send_str(key_sha);
    memset(key,0,name_encrypt_keykey_size);
    free(key);
    free(key_sha);

    return response;
}

LuaCEmbedResponse *get_data(LuaCEmbed *args){
    char *content = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        char *msg = LuaCEmbed_get_error_message(args);
        return LuaCEmbed_send_error(msg);
    }
    unsigned char *key = (unsigned char *)malloc(content_encrypt_keykey_size+1);
    content_encrypt_key_get_key(key);
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface((char*)key);
    long out_size;
    bool is_binary;
    unsigned char *output = DtwEncriptionInterface_decrypt_buffer_hex(enc,content,&out_size,&is_binary);
    
    if(output == NULL){
        free(key);
        DtwEncriptionInterface_free(enc);
        return LuaCEmbed_send_error("The content is invalid");
    }
    
    if(is_binary){
        free(key);
        DtwEncriptionInterface_free(enc);
        free(output);
        return LuaCEmbed_send_error("The content is binary");
    }
    LuaCEmbedResponse *response = LuaCEmbed_send_str((char*)output);
    free(key);
    DtwEncriptionInterface_free(enc);
    free(output);
    return response;
}

LuaCEmbedResponse *set_data(LuaCEmbed *args){
    lua_Integer content_size;
    char *content = LuaCEmbed_get_raw_str_arg(args, &content_size,0);
    if(LuaCEmbed_has_errors(args)){
        char *msg = LuaCEmbed_get_error_message(args);
        return LuaCEmbed_send_error(msg);
    }
    unsigned char *key = (unsigned char *)malloc(content_encrypt_keykey_size+1);
    content_encrypt_key_get_key(key);
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface((char*)key);
    char *output = DtwEncriptionInterface_encrypt_buffer_hex(enc,content,(long)content_size);
    LuaCEmbedResponse *response = LuaCEmbed_send_str(output);
    free(key);
    DtwEncriptionInterface_free(enc);
    free(output);
    return response;    
}

LuaCEmbedResponse *get_llm_data(LuaCEmbed *args){
    char *content = LuaCEmbed_get_str_arg(args,0);
    if(LuaCEmbed_has_errors(args)){
        char *msg = LuaCEmbed_get_error_message(args);
        return LuaCEmbed_send_error(msg);
    }
    unsigned char *key = (unsigned char *)malloc(llm_encrypt_keykey_size+1);
    llm_encrypt_key_get_key(key);
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface((char*)key);
    long out_size;
    bool is_binary;
    unsigned char *output = DtwEncriptionInterface_decrypt_buffer_hex(enc,content,&out_size,&is_binary);
    
    if(output == NULL){
        free(key);
        DtwEncriptionInterface_free(enc);
        return LuaCEmbed_send_error("The content is invalid");
    }
    
    if(is_binary){
        free(key);
        DtwEncriptionInterface_free(enc);
        free(output);
        return LuaCEmbed_send_error("The content is binary");
    }
    LuaCEmbedResponse *response = LuaCEmbed_send_str((char*)output);
    free(key);
    DtwEncriptionInterface_free(enc);
    free(output);
    return response;
}

LuaCEmbedResponse *set_llm_data(LuaCEmbed *args){
    lua_Integer content_size;
    char *content = LuaCEmbed_get_raw_str_arg(args, &content_size,0);
    if(LuaCEmbed_has_errors(args)){
        char *msg = LuaCEmbed_get_error_message(args);
        return LuaCEmbed_send_error(msg);
    }
    unsigned char *key = (unsigned char *)malloc(llm_encrypt_keykey_size+1);
    llm_encrypt_key_get_key(key);
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface((char*)key);
    char *output = DtwEncriptionInterface_encrypt_buffer_hex(enc,content,(long)content_size);
    LuaCEmbedResponse *response = LuaCEmbed_send_str(output);
    free(key);
    DtwEncriptionInterface_free(enc);
    free(output);
    return response;    
}




