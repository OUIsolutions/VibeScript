
//these its just for the intelisense
//they are not used in the code
#ifndef  VIBE_AMALGAMATION
#define content_encrypt_keykey_size
#define content_encrypt_key_get_key(key) 

#define llm_encrypt_key_get_key_size(key)
#define llm_encrypt_key_get_key(key)

#define name_encrypt_keykey_size
#define name_encrypt_key_get_key(key) 

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