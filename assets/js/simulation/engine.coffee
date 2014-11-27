do (
    Simulation = platform.module 'simulation'
) ->

    class Simulation.Engine

        update: ({ @map, @entities }) ->
            for e in @entities
                e.update()
