do (
    Game = platform.module 'game'
    Level = platform.module 'level'
    MapUtil = platform.module 'util.map'
) ->

    class Game.Entity

        defaults: {}

        constructor: ->
            @velocity = { x: 0, y: 0 }
            @[key] = value for own key, value of @defaults
            @initialize?()

        update: ->
            @velocity.x *= .8
            @velocity.y *= .9
            @velocity.y += @gravity

            if @velocity.x > @maxVelocity
                @velocity.x = @maxVelocity

            if @velocity.x < -@maxVelocity
                @velocity.x = -@maxVelocity

            @x += @velocity.x
            @y += @velocity.y

            @checkEastCollision()
            @checkWestCollision()
            @checkNorthCollision()
            @checkSouthCollision()

        onGround: ->
            index = MapUtil.mapPositionToIndex @x, @y
            tile = @map.get index.x, index.y + 1
            not tile.isWalkable() and tile.y is Math.round @y + @height

        moveNorth: (speed) ->
            @velocity.y -= speed

        moveSouth: (speed) ->
            @velocity.y += speed

        moveEast: (speed) ->
            @velocity.x += speed

        moveWest: (speed) ->
            @velocity.x -= speed

        checkNorthCollision: ->
            return unless @velocity.y < 0
            tile = null
            hitbox = @hitbox()
            # Check each point of contact for a collision
            for hitpoint in hitbox.north
                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x
                    y: hitpoint.y + @velocity.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.y > tile.y
                    tile = obstacle
            if tile?
                @y = tile.y + Game.Tile.SIZE
                @velocity.y = 0

        checkEastCollision: ->
            return unless @velocity.x > 0
            tile = null
            hitbox = @hitbox()
            # Check each point of contact for a collision
            for hitpoint in hitbox.east
                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x + @velocity.x
                    y: hitpoint.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.x < tile.x
                    tile = obstacle
            if tile?
                @x = tile.x - @width
                @velocity.x = 0

        checkWestCollision: ->
            return unless @velocity.x < 0
            tile = null
            hitbox = @hitbox()
            # Check each point of contact for a collision
            for hitpoint in hitbox.west
                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x - @velocity.x
                    y: hitpoint.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.x > tile.x
                    tile = obstacle
            if tile?
                @x = tile.x + Game.Tile.SIZE
                @velocity.x = 0

        checkSouthCollision: ->
            return unless @velocity.y > 0
            tile = null
            hitbox = @hitbox()
            # Check each point of contact for a collision
            for hitpoint in hitbox.south
                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x
                    y: hitpoint.y + @velocity.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.y < tile.y
                    tile = obstacle
            if tile?
                @y = tile.y - @height
                @velocity.y = 0

        # TODO compute hitbox based on width/height on initialization, then account for position
        # TODO cache hitbox based on position
        # TODO comments
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

            # Prevent entity from hugging walls
            north[north.length - 1].x -= 1
            south[south.length - 1].x -= 1
            east[east.length - 1].y -= 1
            west[west.length - 1].y -= 1

            { north, south, east, west }

        # Returns the first non-walkable tile between two points.
        # Only tiles along one axis are examined.
        getObstacle: (start, end) ->
            direction = 'x'
            direction = 'y' if start.x is end.x
            start = MapUtil.mapPositionToIndex start.x, start.y
            end = MapUtil.mapPositionToIndex end.x, end.y
            tile = @map.get start.x, start.y
            # Examine tiles between the two points
            for index in [start[direction]..end[direction]]
                if direction is 'x'
                    tile = @map.get index, start.y
                else
                    tile = @map.get start.x, index
                break unless tile.isWalkable()
            return null if tile.isWalkable()
            tile
