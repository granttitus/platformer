do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
    {Configurable} = platform.module 'mixin'
) ->

    SIZE = 25

    class Game.Tile

        Configurable.mixin @::

        @SIZE: SIZE

        defaults:
            width: SIZE
            height: SIZE

        constructor: (x, y, @id) ->
            @configure @defaults
            @x = x * SIZE
            @y = y * SIZE
