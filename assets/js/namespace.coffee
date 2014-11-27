window.platform =
    module: do ->
        modules = {}
        (name) ->
            modules[name] ?= {}
            modules[name]
