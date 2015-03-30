do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
) ->

    class Tile.Exit extends Game.Tile

        key: 'exit'

        update: (entities) ->
            for entity in entities
                if @collides(entity)
                    entity.interact @
            return

        isWalkable: ->
            true

        collides: (entity) ->
            @x < entity.x + entity.width and
            @x + @width > entity.x and
            @y < entity.y + entity.height and
            @y + @height > entity.y
