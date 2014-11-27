do (
    Entity = platform.module 'entity'
    Level = platform.module 'level'
) ->

    class Level.Engine

        get: (n) ->
            entities = @extractEntities Level.data[n]
            map = new Level.Map Level.data[n]

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
                        human = new Entity.Human()
                        human.position.x = Level.Tile.SIZE * j + 10
                        human.position.y = Level.Tile.SIZE * i + 10
                        entities.push human
            entities
