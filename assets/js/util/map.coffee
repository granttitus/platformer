do (
    Game = platform.module 'game'
    Util = platform.module 'util'
    MapUtil = platform.module 'util.map'
) ->

    Util.extend MapUtil,

        mapPositionToIndex: (x, y) ->
            x: Math.floor x / Game.Tile.SIZE
            y: Math.floor y / Game.Tile.SIZE

        extractEntities: (level) ->
            entities = []
            for row, i in level
                for cell, j in row
                    entity = null
                    if cell is 2
                        entity = new Game.Human()
                        entity.x = Game.Tile.SIZE * j + 10
                        entity.y = Game.Tile.SIZE * i + 10
                    if entity?
                        level[i][j] = 0
                        entities.push entity
            entities
