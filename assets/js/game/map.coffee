do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
    MapUtil = platform.module 'util.map'
    {Event} = platform.module 'mixin'
) ->

    TILES =
        0: Tile.Empty
        1: Tile.Wall
        3: Tile.Exit

    class Game.Map

        Event.mixin @::

        constructor: (tiles) ->
            @interactiveTiles = []
            @rows = tiles.length
            @columns = tiles[0].length
            @tiles = new Array tiles.length
            for y in [0...tiles.length]
                for x in [0...tiles[y].length]
                    @createTile x, y, tiles[y][x]
            return

        createTile: (x, y, id) ->
            tile = new TILES[id] x, y, id
            @tiles[y * @columns + x] = tile
            return

        update: (entities) ->
            for tile in @tiles when tile.update?
                tile.update entities
            return

        get: (x, y) ->
            @tiles[y * @columns + x]

        each: (fn) ->
            for tile in @tiles
                fn tile
            return
