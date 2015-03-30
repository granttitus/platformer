do (
    Game = platform.module 'game'
    Item = platform.module 'game.item'
) ->

    class Item.Jetpack extends Game.Item

        key: 'jetpack'

        defaults:
            fuel: 100

        use: (entity) ->
            @fuel--
            if @fuel > 0
                entity.velocity.y -= 1
            else
                @trigger 'remove'
            return
