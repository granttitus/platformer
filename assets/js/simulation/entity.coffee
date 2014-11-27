do (
    Entity = platform.module 'entity'
    Level = platform.module 'level'
) ->

    class Entity.Base extends PIXI.Sprite

        defaults:
            speed: 1
            width: 40
            height: 40
            image: 'human.png'

        constructor: ->
            super @defaults.texture if @defaults.texture
            super PIXI.Texture.fromImage @defaults.image if @defaults.image

            # Apply default properties
            @[key] = value for own key, value of @defaults

            @initialize?()

        update: ->

        moveRight: ->
            hitbox = @hitbox()
            tile = null

            # Check each point of contact for a collision
            for hitpoint in hitbox.right

                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x + @speed
                    y: hitpoint.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.position.x < tile.position.x
                    tile = obstacle

            if tile?
                @position.x = tile.position.x - @width
            else
                @position.x += @speed

        moveLeft: ->
            hitbox = @hitbox()
            tile = null

            # Check each point of contact for a collision
            for hitpoint in hitbox.left

                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x - @speed
                    y: hitpoint.y
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.position.x > tile.position.x
                    tile = obstacle

            if tile?
                @position.x = tile.position.x + Level.Tile.SIZE
            else
                @position.x -= @speed

        moveUp: ->
            hitbox = @hitbox()
            tile = null

            # Check each point of contact for a collision
            for hitpoint in hitbox.top

                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x
                    y: hitpoint.y - @speed
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.position.y > tile.position.y
                    tile = obstacle

            if tile?
                @position.y = tile.position.y + Level.Tile.SIZE
            else
                @position.y -= @speed

        moveDown: ->
            hitbox = @hitbox()
            tile = null

            # Check each point of contact for a collision
            for hitpoint in hitbox.bottom

                # Find the first obstacle within the path of movement
                obstacle = @getObstacle hitpoint,
                    x: hitpoint.x
                    y: hitpoint.y + @speed
                continue unless obstacle?

                tile ?= obstacle
                if obstacle.position.y < tile.position.y
                    tile = obstacle

            if tile?
                @position.y = tile.position.y - @height
            else
                @position.y += @speed

        # TODO _baseHitbox like _standardCurveSegments that is computed on initialization
        # TODO cache hitbox based on position?
        # TODO comments
        hitbox: ->
            top = [x: @position.x, y: @position.y]
            bottom = [x: @position.x, y: @position.y + @height]

            for i in [1..Math.ceil @width / Level.Tile.SIZE] by 1
                x = @position.x + i * Level.Tile.SIZE
                x = Math.min @position.x + @width, x
                top.push
                    x: x
                    y: @position.y
                bottom.push
                    x: x
                    y: @position.y + @height

            right = [x: @position.x + @width, y: @position.y]
            left = [x: @position.x, y: @position.y]

            for i in [1..Math.ceil @height / Level.Tile.SIZE] by 1
                y = @position.y + i * Level.Tile.SIZE
                y = Math.min @position.y + @height, y
                right.push
                    x: @position.x + @width
                    y: y
                left.push
                    x: @position.x
                    y: y

            # Prevent entity from hugging walls
            top[top.length - 1].x -= 1
            bottom[bottom.length - 1].x -= 1
            right[right.length - 1].y -= 1
            left[left.length - 1].y -= 1

            { right, left, top, bottom }

        # TODO comment
        getObstacle: (start, end) ->
            direction = 'x'
            direction = 'y' if start.x is end.x
            start.x = Math.floor start.x / Level.Tile.SIZE
            start.y = Math.floor start.y / Level.Tile.SIZE
            end.x = Math.floor end.x / Level.Tile.SIZE
            end.y = Math.floor end.y / Level.Tile.SIZE
            tile = @map.get start.x, start.y
            for index in [start[direction]..end[direction]]
                if direction is 'x'
                    tile = @map.get index, start.y
                else
                    tile = @map.get start.x, index
                break unless tile.tileID isnt 1
            return null if tile.tileID isnt 1
            tile
