
local size = argv.get_total_args_size()
for i = 1, size do
    print(argv.get_arg_by_index(i))
end