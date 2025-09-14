
### Configure a model
For Configure a model, you just need to call **vibescript** passing **configure_model** as first argument:

```bash
vibescript configure_model --model grok-2-latest --url https://api.x.ai/v1/chat/completions   --key "your key"
```


### List Models 
to list the models, you just need to call **vibescript** passing **list_models** as first argument:

```bash
vibescript list_models
```

### Remove Model

For remove a model, you just need to call **vibescript** passing **remove_model** as first argument:

```bash
vibescript remove_model --model grok-2-latest
```

### Set model as Default 
For set a model as default, you just need to call **vibescript** passing **set_model_as_default** as first argument:

```bash
vibescript set_model_as_default --model grok-2-latest
```