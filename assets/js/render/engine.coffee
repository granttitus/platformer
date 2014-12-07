do (
    Render = platform.module 'render'
) ->

    class Render.Engine

        constructor: ->
            @stage = new PIXI.Stage 0x00CCFF
            @renderer = PIXI.autoDetectRenderer 650, 500
            document.body.appendChild @renderer.view

        # TODO dirty flags
        update: ({ @map, @entities }) ->
            @renderer.render @stage

            @stage.addChild @map
            for e in @entities
                @addToStage e

        # TODO remove
        addToStage: (obj) ->
            return unless obj?
            @stage.addChild obj
            for child in obj.children when child?
                @addToStage child
                unless child in @entities
                    child.map = @map
                    @entities.push child
