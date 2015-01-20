do (
    Render = platform.module 'render'
) ->

    WIDTH = 650
    HEIGHT = 500
    CLEAR_COLOR = 'rgb(235, 235, 235)'

    class Render.Engine

        constructor: ->
            @canvas = document.querySelector 'canvas'
            @canvas.width = WIDTH
            @canvas.height = HEIGHT
            @context = @canvas.getContext '2d'

        update: ({ @map, @entities }) ->
            @context.fillStyle = CLEAR_COLOR
            @context.fillRect 0, 0, WIDTH, HEIGHT

            @map.each (tile) =>
                @context.fillStyle = @getTileColor tile.id
                @context.fillRect tile.x, tile.y, tile.width, tile.height

            for e in @entities
                @context.fillStyle = 'rgb(255, 255, 255)'
                @context.fillRect e.x, e.y, e.width, e.height
            return

        getTileColor: (id) ->
            empty = 'rgba(0, 200, 250, 1)'
            switch id
                when 0 then empty
                when 1 then 'rgba(50, 50, 50, 1)'
                when 2 then empty
