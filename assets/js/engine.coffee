do (
    Engine = platform.module 'game'
    Render = platform.module 'render'
    Game = platform.module 'game'
) ->

    class Engine.Main

        constructor: ->
            @game = new Game.Engine()
            @render = new Render.Engine()

        load: (n) ->
            { @map, @entities } = @game.load n

        start: ->
            @update()

        update: =>
            @game.update { @map, @entities }
            @render.update { @map, @entities }

            kd.tick()
            requestAnimationFrame @update
