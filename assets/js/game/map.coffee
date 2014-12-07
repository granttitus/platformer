do (
    Game = platform.module 'game'
    MapUtil = platform.module 'util.map'
) ->

    class Game.Map extends PIXI.DisplayObjectContainer

        constructor: (@tiles) ->
            super

            for y in [0...@tiles.length]
                row = @tiles[y]
                for x in [0...row.length]
                    @createTile x, y, @tiles[y][x]

        createTile: (x, y, id) ->
            tile = new Game.Tile x, y, id
            @addChild tile
            @tiles[y][x] = tile

        get: (x, y) ->
            @tiles[y][x]
