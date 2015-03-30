do (
    Game = platform.module 'game'
    {Event, Configurable} = platform.module 'mixin'
) ->

    class Game.Item

        Event.mixin @::
        Configurable.mixin @::

        constructor: ->
            @configure @defaults
