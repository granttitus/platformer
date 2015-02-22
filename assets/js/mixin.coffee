do (
    Util = platform.module 'util'
    Mixin = platform.module 'mixin'
) ->

    class Mixin.Configurable

        defaults: {}

        configure: (config, options={}) ->
            Util.defaults options,
                silent: false
                applyDefaults: false
            if options.applyDefaults
                Util.defaults config, @defaults
            for key, value of config
                continue if @[key] is value
                @[key] = value
                @trigger "change:#{key}"
            return

        @mixin: (obj) ->
            properties = ['configure', 'defaults']
            for index, property of properties
                if typeof obj is 'function'
                    obj::[property] = Mixin.Configurable::[property]
                else
                    obj[property] = Mixin.Configurable::[property]
            return

    Mixin.Event = MicroEvent
