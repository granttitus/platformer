do (
    Game = platform.module 'game'
) ->

    SIZE = 25
    WALKABLE_TILES =
        0: true
        2: true

    class Game.Tile

        @SIZE: SIZE

        defaults:
            width: SIZE
            height: SIZE
            velocity: { x: 0, y: 0 }

        constructor: (x, y, @id) ->
            @[key] = value for own key, value of @defaults
            @x = x * SIZE
            @y = y * SIZE

        isWalkable: ->
            WALKABLE_TILES[@id]?
