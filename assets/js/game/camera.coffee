# TODO

do (
    Game = platform.module 'game'
) ->

    class Game.Camera

        constructor: ->
            @x = 0
            @y = 0
            @width = 540
            @height = 415
            # TODO remove (dev use)
            window.addEventListener 'keydown', @handleKeyDown

        bound: (width, height) ->
            @zoom = Math.min width / @width, height / @height
            @x = Math.max @x, 0
            @y = Math.max @y, 0
            @x = Math.min @x, width - @width
            @y = Math.min @y, height - @height

        target: (e) ->
            @x = e.x + e.width / 2 - @width / 2
            @y = e.y + e.height / 2 - @height / 2

        transform: (x, y) ->
            x: (x - @x) * @zoom
            y: (y - @y) * @zoom

        # TODO remove (dev use)
        handleKeyDown: (e) =>
            if e.keyCode is 81
                @width /= 1.2
                @height /= 1.2
            if e.keyCode is 69
                @width *= 1.2
                @height *= 1.2
