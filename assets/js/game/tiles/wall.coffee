do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
) ->

    class Tile.Wall extends Game.Tile

        key: 'wall'

        isWalkable: ->
            false
