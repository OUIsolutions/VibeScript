//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../imports/imports.globals.h"
//silver_chain_scope_end

void private_set_uid(){
    if(private_machine_uid_initialized){
        return;
    }
    
    #ifdef __linux__
        // On Linux, use machine-id from /etc/machine-id or /var/lib/dbus/machine-id
        FILE *file = fopen("/etc/machine-id", "r");
        if(!file){
            file = fopen("/var/lib/dbus/machine-id", "r");
        }
        if(file){
            if(fgets(private_machine_uid, sizeof(private_machine_uid) - 1, file)){
                // Remove newline if present
                char *newline = strchr(private_machine_uid, '\n');
                if(newline) *newline = '\0';
                private_machine_uid_initialized = true;
            }
            fclose(file);
        }
    #elif __APPLE__
        // On macOS, use IOPlatformUUID from ioreg
        FILE *pipe = popen("ioreg -rd1 -c IOPlatformExpertDevice | awk '/IOPlatformUUID/ { split($0, line, \"\\\"\"); printf(\"%s\", line[4]); }'", "r");
        if(pipe){
            if(fgets(private_machine_uid, sizeof(private_machine_uid) - 1, pipe)){
                private_machine_uid_initialized = true;
            }
            pclose(pipe);
        }
    #elif _WIN32
        // On Windows, use wmic to get machine UUID
        FILE *pipe = _popen("wmic csproduct get UUID /value | findstr UUID", "r");
        if(pipe){
            char buffer[256];
            if(fgets(buffer, sizeof(buffer), pipe)){
                // Extract UUID value after "UUID="
                char *uuid_start = strstr(buffer, "UUID=");
                if(uuid_start){
                    uuid_start += 5; // Skip "UUID="
                    strncpy(private_machine_uid, uuid_start, sizeof(private_machine_uid) - 1);
                    // Remove newline and carriage return if present
                    char *newline = strchr(private_machine_uid, '\r');
                    if(newline) *newline = '\0';
                    newline = strchr(private_machine_uid, '\n');
                    if(newline) *newline = '\0';
                    private_machine_uid_initialized = true;
                }
            }
            _pclose(pipe);
        }
    #endif
    
    // Fallback: if no UID could be determined, generate one based on hostname and compile time
    if(!private_machine_uid_initialized){
        snprintf(private_machine_uid, sizeof(private_machine_uid), "fallback_%s_%s", __DATE__, __TIME__);
        private_machine_uid_initialized = true;
    }
}