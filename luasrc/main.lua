

private_vibescript.main = function()
    local config_path = private_vibescript.get_config_path()
    
     local encrypted = cvibescript.set_data("aaaaaaa")
     dtw.write_file("teste",encrypted)

     local decrypted = cvibescript.get_data(dtw.load_file("teste"))
        print(decrypted)
end 