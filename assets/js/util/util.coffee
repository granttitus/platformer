do (
    Util = platform.module 'util'
) ->

    Util.extend = (base, others...) ->
        for properties in others
            for key, val of properties
                base[key] = val
        base
