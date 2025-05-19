//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../imports/imports.types.h"
//silver_chain_scope_end


LuaCEmbedResponse *add_user_prompt(LuaCEmbedTable *self, LuaCEmbed *args);


LuaCEmbedResponse *add_system_prompt(LuaCEmbedTable *self, LuaCEmbed *args);

LuaCEmbedResponse *add_assistant_prompt(LuaCEmbedTable *self, LuaCEmbed *args);

LuaCEmbedResponse *make_question(LuaCEmbedTable *self, LuaCEmbed *args);

char *vibe_callback_handler(cJSON *args, void *pointer);


LuaCEmbedResponse *add_function(LuaCEmbedTable *self, LuaCEmbed *args);

LuaCEmbedResponse *private_new_raw_llm(LuaCEmbed *args);