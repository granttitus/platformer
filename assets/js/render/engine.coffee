# TODO

do (
    Game = platform.module 'game'
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

        update: ({ map, entities, camera }) ->
            mapWidth = Game.Tile.SIZE * map.columns
            mapHeight = Game.Tile.SIZE * map.rows
            camera.bound mapWidth, mapHeight

            @context.fillStyle = CLEAR_COLOR
            @context.fillRect 0, 0, WIDTH, HEIGHT

            map.each (tile) =>
                @context.fillStyle = getTileColor tile.id
                {x, y} = camera.transform tile.x, tile.y
                x = Math.ceil x
                y = Math.ceil y
                width = Math.ceil tile.width * camera.zoom
                height = Math.ceil tile.height * camera.zoom
                if isOnScreen(x, y, width, height)
                    @context.fillRect x, y, width, height

            for e in entities
                @context.fillStyle = 'rgb(255, 255, 255)'
                {x, y} = camera.transform e.x, e.y
                width = e.width * camera.zoom
                height = e.height * camera.zoom
                @context.fillRect x, y, width, height
            return

        getTileColor = (id) ->
            empty = 'rgba(0, 200, 250, 1)'
            switch id
                when 0 then empty
                when 1 then 'rgba(50, 50, 50, 1)'
                when 2 then empty
                when 3 then 'rgba(147, 112, 219, 1)'

        isOnScreen = (x, y, width, height) ->
            x + width >= 0 and
            x - width <= WIDTH and
            y + height >= 0 and
            y - height <= HEIGHT
