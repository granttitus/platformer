#= require game/entity

do (
    Game = platform.module 'game'
) ->

    class Game.Enemy extends Game.Entity

        defaults:
            width: 30
            height: 30
            image: 'enemy.png'
