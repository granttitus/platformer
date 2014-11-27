#= require namespace
#= require_tree vendor
#= require_tree .

do (
    Game = platform.module 'game'
) ->

    window.onload = ->
        engine = new Game.Engine()
        engine.load 1
        engine.start()
