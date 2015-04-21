do (
    Util = platform.module 'util'
    Mixin = platform.module 'mixin'
) ->

    class Mixin.Configurable

        defaults: {}

        configure: (config) ->
            for own key, value of config
                @[key] = value
            return

        @mixin: (obj) ->
            for property in ['configure', 'defaults']
                if typeof obj is 'function'
                    obj::[property] = Mixin.Configurable::[property]
                else
                    obj[property] = Mixin.Configurable::[property]
            return

    class Mixin.Event

        bind: (event, fn) ->
            @_events ?= {}
            @_events[event] ?= []
            @_events[event].push fn
            return

        unbind: (event, fn) ->
            @_events ?= {}
            if event?
                index = @_events[event].indexOf fn
                @_events[event].splice index, 1
            else
                @_events = {}
            return

        trigger: (event, args...) ->
            @_events ?= {}
            return unless @_events[event]
            for e in @_events[event]
                e.apply this, args
            return

        propagate: (obj, event) ->
            obj.bind event, =>
                @trigger event, arguments...
            return

        @mixin: (obj) ->
            for property in ['bind', 'unbind', 'trigger', 'propagate']
                if typeof obj is 'function'
                    obj::[property] = Mixin.Event::[property]
                else
                    obj[property] = Mixin.Event::[property]
            return
