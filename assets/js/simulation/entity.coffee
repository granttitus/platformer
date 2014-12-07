do (
    Entity = platform.module 'entity'
    Level = platform.module 'level'
    MapUtil = platform.module 'util.map'
) ->

    # TODO remove PIXI
    class Entity.Base extends PIXI.Sprite

        constructor: ->
            # PIXI needs texture before width / height are set
            super @defaults.texture if @defaults.texture
            super PIXI.Texture.fromImage @defaults.image if @defaults.image

            # Apply default properties
            @[key] = value for own key, value of @defaults

            # TODO find a better place for this
            @velocity =
                x: 0
                y: 0

            @initialize?()

        update: ->
            @velocity.x *= .8
            @velocity.y *= .9
            @velocity.y += @gravity

            if @velocity.x > @maxVelocity
                @velocity.x = @maxVelocity

            if @velocity.x < -@maxVelocity
                @velocity.x = -@maxVelocity

            @position.x += @velocity.x
            @position.y += @velocity.y

            @checkEastCollision()
            @checkWestCollision()
            @checkNorthCollision()
            @checkSouthCollision()

        onGround: ->
            index = MapUtil.mapPositionToIndex @position.x, @position.y
            tile = @map.get index.x, index.y + 1
            not tile.isWalkable() and tile.position.y is Math.round @position.y + @height

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
                if obstacle.position.y > tile.position.y
                    tile = obstacle
            if tile?
                @position.y = tile.position.y + Level.Tile.SIZE
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
                if obstacle.position.x < tile.position.x
                    tile = obstacle
            if tile?
                @position.x = tile.position.x - @width
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
                if obstacle.position.x > tile.position.x
                    tile = obstacle
            if tile?
                @position.x = tile.position.x + Level.Tile.SIZE
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
                if obstacle.position.y < tile.position.y
                    tile = obstacle
            if tile?
                @position.y = tile.position.y - @height
                @velocity.y = 0

        # TODO compute hitbox based on width/height on initialization, then account for position
        # TODO cache hitbox based on position
        # TODO comments
        hitbox: ->
            north = [x: @position.x, y: @position.y]
            south = [x: @position.x, y: @position.y + @height]

            for i in [1..Math.ceil @width / Level.Tile.SIZE] by 1
                x = @position.x + i * Level.Tile.SIZE
                x = Math.min @position.x + @width, x
                north.push
                    x: x
                    y: @position.y
                south.push
                    x: x
                    y: @position.y + @height

            east = [x: @position.x + @width, y: @position.y]
            west = [x: @position.x, y: @position.y]

            for i in [1..Math.ceil @height / Level.Tile.SIZE] by 1
                y = @position.y + i * Level.Tile.SIZE
                y = Math.min @position.y + @height, y
                east.push
                    x: @position.x + @width
                    y: y
                west.push
                    x: @position.x
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
