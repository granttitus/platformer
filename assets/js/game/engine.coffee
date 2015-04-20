do (
    Game = platform.module 'game'
    {Event} = platform.module 'mixin'
) ->

    class Game.Engine

        Event.mixin @::

        load: (id) ->
            @camera = new Game.Camera
            @level = @getLevel id
            @level.initialize @camera
            @level.bind 'action:exit', @handleExit
            return

        update: ->
            @level.update()
            return

        handleExit: =>
            @level.unbind()
            @trigger 'win'
            return

        getLevel: (id) ->
            id = 1
            new Game['Level' + id]()
