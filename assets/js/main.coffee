#= require namespace
#= require_tree vendor
#= require util/index
#= require ./mixin
#= require_tree .

do (
    Engine = platform.module 'engine'
) ->

    window.addEventListener 'load', ->
        engine = new Engine.Main()
        engine.load 1
        engine.start()

        # TODO
        window.engine = engine
