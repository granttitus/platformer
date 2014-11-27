# TODO optimize

do (
    Render = platform.module 'render'
) ->

    class Render.Engine

        constructor: ->
            @cache = []

            @stage = new PIXI.Stage 0x00CCFF

            @renderer = PIXI.autoDetectRenderer 650, 500
            document.body.appendChild @renderer.view

        update: ({ @map, @entities }) ->
            @renderer.render @stage

            if @entities isnt @cache
                @stage.removeChild e for e in @cache
                @stage.addChild e for e in @entities
                @stage.addChild @map
                @cache = @entities
