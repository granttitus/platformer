#= require util/util

do (
    Level = platform.module 'level'
    Util = platform.module 'util'
    MapUtil = platform.module 'util.map'
) ->

    Util.extend MapUtil,

        # TODO add converse
        mapPositionToIndex: (x, y) ->
            x: Math.floor x / Level.Tile.SIZE
            y: Math.floor y / Level.Tile.SIZE
