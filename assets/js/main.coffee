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
        resize()

    # TODO remove hack
    resize = ->
        canvas = document.querySelector('canvas')
        canvas.style.width = "#{window.innerHeight * 1.3}px"
        canvas.style.height = "#{window.innerHeight - 20}px"
    window.onresize = resize
