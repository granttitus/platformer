do (
    Render = platform.module 'render'
) ->

    # TODO
    class Render.Engine

        update: ({ @map, @entities }) ->
            x = document.querySelector '.x'
            x.innerHTML = @entities[0].position.x.toFixed(0)

            y = document.querySelector '.y'
            y.innerHTML = @entities[0].position.y.toFixed(0)
