do (
    Util = platform.module 'util'
) ->

    Util.defaults = (base, others...) ->
        for properties in others
            for key, val of properties when not base[key]?
                base[key] = val
        base

    Util.extend = (base, others...) ->
        for properties in others
            for key, val of properties
                base[key] = val
        base
