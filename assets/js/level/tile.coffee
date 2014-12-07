do (
    Level = platform.module 'level'
) ->

    TILE_TEXTURES = [
        PIXI.Texture.fromImage 'blank.png'
        PIXI.Texture.fromImage 'wall.png'
        PIXI.Texture.fromImage 'blank.png'
    ]

    WALKABLE_TILES =
        0: true
        2: true

    class Level.Tile extends PIXI.Sprite

        @SIZE: 25

        constructor: (x, y, @id) ->
            super TILE_TEXTURES[@id]

            @width = Level.Tile.SIZE
            @height = Level.Tile.SIZE

            @position.x = x * Level.Tile.SIZE
            @position.y = y * Level.Tile.SIZE

            @position.indexX = x
            @position.indexY = y

        isWalkable: ->
            WALKABLE_TILES[@id]?
