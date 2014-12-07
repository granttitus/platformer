do (
    Engine = platform.module 'game'
    Render = platform.module 'render'
    Level = platform.module 'level'
    Game = platform.module 'game'
) ->

    class Engine.Main

        constructor: ->
            @levelEngine = new Level.Engine()
            @renderEngine = new Render.Engine()
            @gameEngine = new Game.Engine()

        load: (n) ->
            data = @levelEngine.get n
            { @map, @entities } = @gameEngine.constructLevel data

        start: ->
            @update()

        update: =>
            @gameEngine.update { @map, @entities }
            @renderEngine.update { @map, @entities }

            kd.tick()
            requestAnimFrame @update
