//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.types.h"
//silver_chain_scope_end
DtwEncriptionInterface *newDtwAES_Custom_CBC_v1_interface(const char *key);
LuaCEmbedResponse *get_config_name(LuaCEmbed *args);

//decrypt data with content_encrypt_key_get_key at /csrc/encrypt_keys/content_encrypt_key.h
LuaCEmbedResponse *get_data(LuaCEmbed *args);


LuaCEmbedResponse *set_data(LuaCEmbed *args);