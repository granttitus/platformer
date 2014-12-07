#= require util/util

do (
    Game = platform.module 'game'
    Util = platform.module 'util'
    MapUtil = platform.module 'util.map'
) ->

    Util.extend MapUtil,

        # TODO add converse
        mapPositionToIndex: (x, y) ->
            x: Math.floor x / Game.Tile.SIZE
            y: Math.floor y / Game.Tile.SIZE
