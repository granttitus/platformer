do (
    Game = platform.module 'game'
) ->

    TILE_TEXTURES = [
        PIXI.Texture.fromImage 'blank.png'
        PIXI.Texture.fromImage 'wall.png'
        PIXI.Texture.fromImage 'blank.png'
    ]

    WALKABLE_TILES =
        0: true
        2: true

    class Game.Tile extends PIXI.Sprite

        @SIZE: 25

        constructor: (x, y, @id) ->
            super TILE_TEXTURES[@id]

            @width = Game.Tile.SIZE
            @height = Game.Tile.SIZE

            @position.x = x * Game.Tile.SIZE
            @position.y = y * Game.Tile.SIZE

            @position.indexX = x
            @position.indexY = y

        isWalkable: ->
            WALKABLE_TILES[@id]?
