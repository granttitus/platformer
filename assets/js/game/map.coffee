do (
    Game = platform.module 'game'
    MapUtil = platform.module 'util.map'
) ->

    class Game.Map

        constructor: (tiles) ->
            @interactiveTiles = []
            @rows = tiles.length
            @columns = tiles[0].length
            @tiles = new Array tiles.length
            for y in [0...tiles.length]
                for x in [0...tiles[y].length]
                    @createTile x, y, tiles[y][x]

        createTile: (x, y, id) ->
            tile = new Game.Tile x, y, id
            @tiles[y * @columns + x] = tile
            return

        get: (x, y) ->
            @tiles[y * @columns + x]

        each: (fn) ->
            for tile in @tiles
                fn tile
            return
