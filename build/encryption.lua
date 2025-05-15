
function create_encrypt_key(encrypt_key,name)

   local array_props ={
      {key =encrypt_key},
      {name = name},
      {seed = 232954},
      {debug = false},
      {fake_byte_set = 0}, 
      {create_a_integer = 0.33},
      {max_operations_per_line = 6}, 
      {min_operations_per_line = 3}, 
      {create_a_for =0.33},
      { create_a_if = 0.33},
      {max_scopes = 4},  
      {close_scopes = 0.66}, 
      {integer_set = 0}, 
      {fake_byte_set = 0.33},
      {real_byte_set = 0.5} 
    }
    local props = {}
    for i, v in ipairs(array_props) do
        for key, value in pairs(v) do
            props[key] = value
        end
    end
    local executor = function()
        code = key_obfuscate.create_procedural_generation (props)
        darwin.dtw.write_file("csrc/encrypt_keys/"..name..".h", code)        
    end
    local side_effect_verifier = function()
        return darwin.dtw.generate_sha_from_file("csrc/encrypt_keys/"..name..".h")
    end
    cache_execution({"encrypt",array_props}, executor, side_effect_verifier)
end 

function create_encrypt_keys()
      
    local name_encrypt_key = darwin.argv.get_flag_arg_by_index({ "json_name_encrypt_key"}, 1)
    if not name_encrypt_key then
        print("Please provide a --json_name_encrypt_key")
        return false
    end
    create_encrypt_key(name_encrypt_key,"name_encrypt_key")
    

    local content_encrypt_key = darwin.argv.get_flag_arg_by_index({ "json_content_encrypt_key"}, 1)
    if not content_encrypt_key then
        print("Please provide a key  for the --json_content_encrypt_key")
        return false
    end
    create_encrypt_key(content_encrypt_key,"content_encrypt_key")


    local llm_encrypt_key = darwin.argv.get_flag_arg_by_index({ "json_llm_encrypt_key"}, 1)
    if not llm_encrypt_key then
        print("Please provide a key  for the --json_llm_encrypt_key")
        return false
    end
    create_encrypt_key(llm_encrypt_key,"llm_encrypt_key")

    return true
end 