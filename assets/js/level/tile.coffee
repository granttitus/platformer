do (
    Level = platform.module 'level'
) ->

    tileTextures = [
        PIXI.Texture.fromImage 'blank.png'
        PIXI.Texture.fromImage 'wall.png'
        PIXI.Texture.fromImage 'blank.png'
    ]

    class Level.Tile extends PIXI.Sprite

        @SIZE: 25

        constructor: (x, y, @id) ->
            super tileTextures[@id]

            @width = Level.Tile.SIZE
            @height = Level.Tile.SIZE

            @position.x = x * Level.Tile.SIZE
            @position.y = y * Level.Tile.SIZE

            @position.indexX = x
            @position.indexY = y
