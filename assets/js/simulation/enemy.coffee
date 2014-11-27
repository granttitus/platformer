#= require simulation/entity

do (
    Entity = platform.module 'entity'
) ->

    class Entity.Enemy extends Entity.Base

        defaults:
            width: 30
            height: 30
            image: 'enemy.png'
