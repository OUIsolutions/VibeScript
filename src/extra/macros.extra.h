//silver_chain_scope_start
//DONT MODIFY THIS COMMENT
//this import is computationally generated
//mannaged by SilverChain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.dep_declare.h"
//silver_chain_scope_end


#define release_if_not_null(ptr, releaser) if(ptr != NULL){releaser(ptr);}


#if defined(__win32__) || defined(_WIN32) || defined(WIN32)
    #define PTR_CAST long long 
#else
    #define PTR_CAST long
#endif