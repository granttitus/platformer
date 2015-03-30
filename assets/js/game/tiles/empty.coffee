do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
) ->

    class Tile.Empty extends Game.Tile

        isWalkable: ->
            true
