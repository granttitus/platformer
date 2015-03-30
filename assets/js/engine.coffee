do (
    Engine = platform.module 'engine'
    Render = platform.module 'render'
    Game = platform.module 'game'
    MapUtil = platform.module 'util.map'
) ->

    class Engine.Main

        constructor: ->
            @render = new Render.Engine()

        load: (n) ->
            data = Game.getLevel n
            entities = MapUtil.extractEntities data
            map = new Game.Map data
            e.map = map for e in entities
            @game = new Game.Engine()
            @game.bind 'win', @handleWin
            @game.bind 'lose', @handleLoss
            @game.initialize { map, entities }

        # TODO stop
        start: ->
            @update()

        update: =>
            @game.update()
            { map, entities, camera } = @game
            @render.update { map, entities, camera }

            kd.tick()
            requestAnimationFrame @update

        handleWin: =>
            setTimeout =>
                @game.unbind 'win', @handleWin
                @game.unbind 'lose', @handleLoss
                @load @level + 1
            , 0

        handleLoss: =>
            setTimeout =>
                @game.unbind 'win', @handleWin
                @game.unbind 'lose', @handleLoss
                @load @level
            , 0
