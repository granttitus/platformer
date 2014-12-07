do (
    Game = platform.module 'game'
) ->

    class Game.Engine

        update: ({ @map, @entities }) ->
            for e in @entities
                e.update()

        constructLevel: (data) ->
            entities = @extractEntities data
            map = new Game.Map data

            # Give each entity a reference to the map
            e.map = map for e in entities

            map: map
            entities: entities

        # TODO simplify, separate
        extractEntities: (levelData) ->

            entities = []
            for row, i in levelData
                for cell, j in row
                    if cell is 2
                        human = new Game.Human()
                        human.position.x = Game.Tile.SIZE * j + 10
                        human.position.y = Game.Tile.SIZE * i + 10
                        entities.push human
            entities
