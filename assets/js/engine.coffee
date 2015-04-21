do (
    Engine = platform.module 'engine'
    Render = platform.module 'render'
    Game = platform.module 'game'
) ->

    class Engine.Main

        constructor: ->
            @render = new Render.Engine()
            @game = new Game.Engine()

        load: (@level) ->
            @game.load @level
            @game.bind 'win', @handleWin
            @game.bind 'lose', @handleLoss
            return

        start: ->
            unless @running
                @running = true
                @update()
            return

        stop: ->
            @running = false
            return

        update: =>
            return unless @running
            @game.update()
            # TODO
            { map, entities, camera } = @game.level
            @render.update { map, entities, camera }

            kd.tick()
            requestAnimationFrame @update
            return

        handleWin: =>
            setTimeout =>
                @level += 1
                @game.load @level
            , 0
            return

        handleLoss: =>
            setTimeout =>
                @game.load @level
            , 0
            return
