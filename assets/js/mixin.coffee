do (
    Util = platform.module 'util'
    Mixin = platform.module 'mixin'
) ->

    class Mixin.Configurable

        defaults: {}

        configure: (config, options={}) ->
            if options.applyDefaults
                Util.defaults config, @defaults
            for key, value of config
                continue if @[key] is value
                @[key] = value
            return

        @mixin: (obj) ->
            for property in ['configure', 'defaults']
                if typeof obj is 'function'
                    obj::[property] = Mixin.Configurable::[property]
                else
                    obj[property] = Mixin.Configurable::[property]
            return

    Mixin.Event = MicroEvent
