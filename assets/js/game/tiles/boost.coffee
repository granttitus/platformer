do (
    Game = platform.module 'game'
    Tile = platform.module 'game.tile'
    Util = platform.module 'util'
) ->

    class Tile.Boost extends Game.Tile

        key: 'boost'
 
        # direction
        #   1: north
        #   2: south
        #   3: east
        #   4: west

        defaults: Util.extend {}, @::defaults,
            direction: 1
            force: 2

        constructor: ->
            super
            @direction = @id - 3

        update: (entities) ->
            for entity in entities
                if @collides(entity)
                    @boost entity
            return

        boost: (entity) ->
            switch @direction
                when 1
                    entity.velocity.y -= @force
                when 2
                    entity.velocity.y += @force
                when 3
                    entity.velocity.x += @force
                when 4
                    entity.velocity.x -= @force
            return

        isWalkable: ->
            true

        collides: (entity) ->
            @x < entity.x + entity.width and
            @x + @width > entity.x and
            @y < entity.y + entity.height and
            @y + @height > entity.y
