do (
    Level = platform.module 'level'
) ->

    class Level.Map extends PIXI.DisplayObjectContainer

        constructor: (@tiles) ->
            super

            for y in [0...@tiles.length]
                row = @tiles[y]
                for x in [0...row.length]
                    @createTile x, y, @tiles[y][x]

        createTile: (x, y, tileID) ->
            tile = new Level.Tile x, y, tileID
            @addChild tile
            @tiles[y][x] = tile

        isWalkable: (x, y) ->
            indexX = Math.floor x / Level.Tile.SIZE
            indexY = Math.floor y / Level.Tile.SIZE
            tile = @get indexX, indexY
            tile.tileID is 1

        get: (x, y) ->
            @tiles[y][x]
