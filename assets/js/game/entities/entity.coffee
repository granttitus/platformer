do (
    Game = platform.module 'game'
    MapUtil = platform.module 'util.map'
    {Configurable} = platform.module 'mixin'
) ->

    class Game.Entity

        Configurable.mixin @::

        key: 'entity'

        defaults:
            width: 26
            height: 26
            acceleration: 0.4
            maxVelocity: 10

        constructor: ->
            @velocity = {x: 0, y: 0}
            @configure @defaults
            @initialize? arguments...

        update: ->
            if @velocity.x < 0.1 and @velocity.x > -0.1
                @velocity.x = 0

            if @velocity.y < 0.1 and @velocity.y > -0.1
                @velocity.y = 0

            if @velocity.x > @maxVelocity
                @velocity.x = @maxVelocity

            if @velocity.x < -@maxVelocity
                @velocity.x = -@maxVelocity

            if @velocity.y > @maxVelocity
                @velocity.y = @maxVelocity

            if @velocity.y < -@maxVelocity
                @velocity.y = -@maxVelocity

            @y += @velocity.y
            @checkNorthCollision()
            @checkSouthCollision()

            @x += @velocity.x
            @checkEastCollision()
            @checkWestCollision()
            return

        moveNorth: (speed) ->
            @velocity.y -= speed
            return

        moveSouth: (speed) ->
            @velocity.y += speed
            return

        moveEast: (speed) ->
            @velocity.x += speed
            return

        moveWest: (speed) ->
            @velocity.x -= speed
            return

        collideNorth: (tile) ->
            @y = tile.y + Game.Tile.SIZE
            @velocity.y = 0
            return

        collideSouth: (tile) ->
            @y = tile.y - @height - 0.1
            @velocity.y = 0
            return

        collideEast: (tile) ->
            @x = tile.x - @width - 0.1
            @velocity.x = 0
            return

        collideWest: (tile) ->
            @x = tile.x + Game.Tile.SIZE
            @velocity.x = 0
            return

        checkNorthCollision: ->
            return unless @velocity.y < 0
            for hitpoint in @hitbox().north
                pos = MapUtil.mapPositionToIndex hitpoint.x, hitpoint.y + @velocity.y
                tile = @map.get pos.x, pos.y
                if @isObstacle tile
                    @collideNorth tile
                    break
            return

        checkSouthCollision: ->
            return unless @velocity.y > 0
            for hitpoint in @hitbox().south
                pos = MapUtil.mapPositionToIndex hitpoint.x, hitpoint.y + @velocity.y
                tile = @map.get pos.x, pos.y
                if @isObstacle tile
                    @collideSouth tile
            return

        checkEastCollision: ->
            return unless @velocity.x > 0
            for hitpoint in @hitbox().east
                pos = MapUtil.mapPositionToIndex hitpoint.x + @velocity.x, hitpoint.y
                tile = @map.get pos.x, pos.y
                if @isObstacle tile
                    @collideEast tile
                    break
            return

        checkWestCollision: ->
            return unless @velocity.x < 0
            for hitpoint in @hitbox().west
                pos = MapUtil.mapPositionToIndex hitpoint.x + @velocity.x, hitpoint.y
                tile = @map.get pos.x, pos.y
                if @isObstacle tile
                    @collideWest tile
                    break
            return

        # TODO remove
        hitbox: ->
            north = [x: @x, y: @y]
            south = [x: @x, y: @y + @height]
            for i in [1..Math.ceil @width / Game.Tile.SIZE] by 1
                x = @x + i * Game.Tile.SIZE
                x = Math.min @x + @width, x
                north.push
                    x: x
                    y: @y
                south.push
                    x: x
                    y: @y + @height

            east = [x: @x + @width, y: @y]
            west = [x: @x, y: @y]
            for i in [1..Math.ceil @height / Game.Tile.SIZE] by 1
                y = @y + i * Game.Tile.SIZE
                y = Math.min @y + @height, y
                east.push
                    x: @x + @width
                    y: y
                west.push
                    x: @x
                    y: y

            { north, south, east, west }

        isObstacle: (tile) ->
            not tile.isWalkable()
