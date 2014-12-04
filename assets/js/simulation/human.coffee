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
            @bindKey ['UP', 'W', 'K'], @moveUp.bind @
            @bindKey ['LEFT', 'A', 'H'], @moveLeft.bind @
            @bindKey ['DOWN', 'S', 'J'], @moveDown.bind @
            @bindKey ['RIGHT', 'D', 'L'], @moveRight.bind @

        bindKey: (keys, fn) ->
            keys = [keys] unless Array.isArray keys

            for key in keys
                do (key=key) ->
                    Keyboard.Delegate.down key, fn
                    Keyboard.Delegate.up key, fn
