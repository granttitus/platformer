do (
    Game = platform.module 'game'
    Render = platform.module 'render'
    Level = platform.module 'level'
    Simulation = platform.module 'simulation'
) ->

    class Game.Engine

        constructor: ->
            @levelEngine = new Level.Engine()
            @renderEngine = new Render.Engine()
            @simulationEngine = new Simulation.Engine()

        load: (n) ->
            { @map, @entities } = @levelEngine.get 1

        start: ->
            @update()

        update: =>
            @simulationEngine.update { @map, @entities }
            @renderEngine.update { @map, @entities }

            kd.tick()
            requestAnimFrame @update
