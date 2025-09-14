//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.globals.h"
//silver_chain_scope_end



LuaCEmbedResponse *private_save_encrypted_data(LuaCEmbed *args){
    const char *props_path = LuaCEmbed_get_str_arg(args,0);
    long name_size;
    unsigned char *name = LuaCEmbed_get_raw_str_arg(args,&name_size,1);
    LuaCEmbedTable *data = LuaCembed_new_anonymous_table(args);
    LuaCEmbedTable_append_arg(data,2);

    // Serialize the data
    privateLuaDtwStringAppender *appender = newprivateLuaDtwStringAppender();
    ldtw_serialize_first_value_of_table(appender, data);

    // Create encryption interface using machine UID as key
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface(private_machine_uid);
    if(!enc){
        privateLuaDtwStringAppender_free(appender);
        return LuaCEmbed_send_error(args, "Failed to create encryption interface");
    }

    // Encrypt the serialized data
    long encrypted_size = 0;
    unsigned char *encrypted_data = DtwEncriptionInterface_encrypt_buffer(enc, (unsigned char*)appender->buffer, appender->length, &encrypted_size);
    if(!encrypted_data){
        privateLuaDtwStringAppender_free(appender);
        DtwEncriptionInterface_free(enc);
        return LuaCEmbed_send_error(args, "Failed to encrypt data");
    }

    // Generate filename from name hash
    char *name_sha = dtw_generate_sha_from_any(name,name_size);
    char *full_path = dtw_concat_path(props_path,name_sha);
    free(name_sha);
    printf("%s\n",full_path);
    // Write encrypted data to file
    dtw_write_any_content(full_path, encrypted_data, encrypted_size);
    
    // Cleanup
    free(full_path);
    free(encrypted_data);
    privateLuaDtwStringAppender_free(appender);
    DtwEncriptionInterface_free(enc);
    return NULL;
}


LuaCEmbedResponse *private_get_encrypted_data(LuaCEmbed *args){
    const char *props_path = LuaCEmbed_get_str_arg(args,0);
    long name_size;
    unsigned char *name = LuaCEmbed_get_raw_str_arg(args,&name_size,1);
    
    // Generate filename from name hash
    char *name_sha = dtw_generate_sha_from_any(name,name_size);
    char *full_path = dtw_concat_path(props_path,name_sha);
    free(name_sha);
    
    // Load encrypted content from file
    long size;
    bool is_binary;
    unsigned char *encrypted_content = dtw_load_any_content(full_path,&size,&is_binary);
    free(full_path);

    if(!encrypted_content){
        return NULL;
    }

    // Create encryption interface using machine UID as key
    DtwEncriptionInterface *enc = newDtwAES_Custom_CBC_v1_interface(private_machine_uid);
    if(!enc){
        free(encrypted_content);
        return LuaCEmbed_send_error(args, "Failed to create encryption interface");
    }

    // Decrypt the content
    long decrypted_size = 0;
    bool decrypted_is_binary = false;
    unsigned char *decrypted_content = DtwEncriptionInterface_decrypt_buffer(enc, encrypted_content, size, &decrypted_size, &decrypted_is_binary);
    
    // Cleanup encryption resources
    free(encrypted_content);
    DtwEncriptionInterface_free(enc);
    
    if(!decrypted_content){
        return LuaCEmbed_send_error(args, "Failed to decrypt data");
    }

    // Send the decrypted content as evaluation
    LuaCEmbedResponse *response = LuaCEmbed_send_evaluation((char*)decrypted_content);
    free(decrypted_content);
    return response;    
}