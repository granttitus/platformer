#= require simulation/entity

do (
    Entity = platform.module 'entity'
    Keyboard = platform.module 'keyboard'
) ->

    class Entity.Human extends Entity.Base

        defaults:
            speed: 5
            width: 40
            height: 40
            image: 'human.png'

        initialize: ->
            @_bindExclusiveKey ['UP', 'W', 'K'], @moveUp.bind @
            @_bindExclusiveKey ['LEFT', 'A', 'H'], @moveLeft.bind @
            @_bindExclusiveKey ['DOWN', 'S', 'J'], @moveDown.bind @
            @_bindExclusiveKey ['RIGHT', 'D', 'L'], @moveRight.bind @

        # Bind key(s) to a function. One key, out
        # of all keys bound, activate at a time
        _bindExclusiveKey: (keys, fn) ->

            keys = [keys] unless _.isArray keys

            _.each keys, (key) ->
                Keyboard.Delegate.down key, =>
                    if @_activeKey is key or not @_activeKey
                        fn()
                        @_activeKey = key

                Keyboard.Delegate.up key, =>
                    if @_activeKey is key
                        @_activeKey = null
