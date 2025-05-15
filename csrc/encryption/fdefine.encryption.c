//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
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