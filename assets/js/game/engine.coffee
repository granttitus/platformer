do (
    Game = platform.module 'game'
    {Event} = platform.module 'mixin'
) ->

    class Game.Engine
        Event.mixin @::

        initialize: ({ @map, @entities }) ->
            @camera = new Game.Camera

        update: ->
            for e in @entities
                e.update()
            @camera.target @entities[0]
            return
