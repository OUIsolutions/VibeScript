//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "imports/imports.dep_declare.h"
//silver_chain_scope_end

//these its just for the intelisense
//they are not used in the code
#ifndef  VIBE_AMALGAMATION
#define contentkey_size 1
#define content_get_key(key) 

#define llmkey_size 1
#define llm_get_key(key)

#define namekey_size 1
#define name_get_key(key) 

#else 
    //these must be passed for the user 
    #ifndef CONTENT_ENCRYPT_KEY 
    #error "CONTENT_ENCRYPT_KEY must be defined"
    #include content_encrypt_key
    #endif

    #ifndef LLM_ENCRYPT_KEY
    #error "LLM_ENCRYPT_KEY must be defined"
    #include LLM_ENCRYPT_KEY
    #endif
    #ifndef NAME_ENCRYPT_KEY
    #error "NAME_ENCRYPT_KEY must be defined"
    #include NAME_ENCRYPT_KEY
    #endif

#endif