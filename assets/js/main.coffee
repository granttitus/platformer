#= require namespace
#= require_tree vendor
#= require_tree .

do (
    Engine = platform.module 'game'
) ->

    window.onload = ->
        engine = new Engine.Main()
        engine.load 1
        engine.start()

        # TODO
        window.engine = engine
