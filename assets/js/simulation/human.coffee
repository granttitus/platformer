#= require simulation/entity

do (
    Entity = platform.module 'entity'
    Keyboard = platform.module 'keyboard'
) ->

    class Entity.Human extends Entity.Base

        defaults:
            image: 'human.png'
            width: 7
            height: 10
            gravity: 0.5
            acceleration: .4
            jumpPower: 10
            maxVelocity: 5

        initialize: ->
            @bindKey ['UP', 'W', 'K'], @jump.bind @
            @bindKey ['DOWN', 'S', 'J'], => @moveSouth @acceleration
            @bindKey ['RIGHT', 'D', 'L'], => @moveEast @acceleration
            @bindKey ['LEFT', 'A', 'H'], => @moveWest @acceleration

        # TODO remove
        jump: ->
            if @canJump
                @canJump = false
                @moveNorth @jumpPower

        bindKey: (keys, fn) ->
            keys = [keys] unless Array.isArray keys

            for key in keys
                do (key=key) ->
                    Keyboard.Delegate.down key, fn
                    Keyboard.Delegate.up key, fn
