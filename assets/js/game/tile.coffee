do (
    Game = platform.module 'game'
) ->

    WALKABLE_TILES =
        0: true
        2: true

    class Game.Tile

        @SIZE: 25

        constructor: (x, y, @id) ->
            @width = Game.Tile.SIZE
            @height = Game.Tile.SIZE

            @velocity = { x: 0, y: 0 }
            @position = { x: 0, y: 0 }

            @position.x = x * Game.Tile.SIZE
            @position.y = y * Game.Tile.SIZE

        isWalkable: ->
            WALKABLE_TILES[@id]?
