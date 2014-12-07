#= require game/entity

do (
    Game = platform.module 'game'
    Keyboard = platform.module 'keyboard'
) ->

    class Game.Human extends Game.Entity

        defaults:
            image: 'human.png'
            width: 7
            height: 10
            gravity: 0.5
            acceleration: .4
            jumpPower: 10
            maxVelocity: 5

        initialize: ->
            @bindKey ['DOWN', 'S'], => @moveSouth @acceleration
            @bindKey ['RIGHT', 'D'], => @moveEast @acceleration
            @bindKey ['LEFT', 'A'], => @moveWest @acceleration
            @bindKey ['UP', 'W'], @jump.bind @
            @bindKey ['SPACE'], @shootConfetti.bind @

        update: ->
            super
            @canJump or= @onGround()

        jump: ->
            return unless @canJump
            @canJump = false
            @moveNorth @jumpPower

        # TODO remove
        shootConfetti: ->
            for i in [0...10]
                r = 20 + Math.random() * 80
                theta = Math.random() * Math.PI + Math.PI
                pos =
                    x: @position.x + @width / 2
                    y: @position.y + @height / 2
                fx = pos.x + r * Math.cos theta
                fy = pos.y + r * Math.sin theta

                entity = new Game.Entity
                    image: 'confetti.png'
                    gravity: 0.15
                    acceleration: .4
                    jumpPower: 10
                    maxVelocity: 999
                    velocity:
                        x: (fx - pos.x) / 10
                        y: (fy - pos.y) / 10
                entity.position.x = pos.x
                entity.position.y = pos.y
                @addChild entity

        bindKey: (keys, fn) ->
            keys = [keys] unless Array.isArray keys

            for key in keys
                do (key=key) ->
                    Keyboard.Delegate.down key, fn
                    Keyboard.Delegate.up key, fn
