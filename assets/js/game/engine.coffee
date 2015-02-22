do (
    Game = platform.module 'game'
    {Event} = platform.module 'mixin'
) ->

    class Game.Engine
        Event.mixin @::

        initialize: ({ @map, @entities }) ->

        update: ->
            for e in @entities
                e.update()
            return
