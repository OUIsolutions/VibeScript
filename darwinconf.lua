PROJECT_NAME = "vibescript"
CONTANIZER   =  darwin.argv.get_flag_arg_by_index({ "contanizer", }, 1,"podman" ) 
VERSION      = "0.0.1"
LICENSE      = "MIT"
URL          = "https://github.com/OUIsolutions/VibeScript"
DESCRIPITION = "A Runtime to work with llms"
FULLNAME     = "VibeScript"
EMAIL        = "[EMAIL_ADDRESS]"
SUMARY       = "A Runtime to work with llms"
YOUR_CHANGES = "--"
LAUNGUAGE     = "lua"
darwin.load_all("build")