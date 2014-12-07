# `Keyboard` provides an additional layer
# of convience on top of KeyDrown, a key
# event library. Our wrapper allows us to
# bind multiple functions to a single key
# event.
#
# The hash for a given action takes this form:
#
# down: {
#   'W': [fn, fn, fn]
#   'S': [fn]
# }
#
# When a key, say 'W', is pressed, all
# functions within the `down['W']`
# array are executed.

do (
    Keyboard = platform.module 'keyboard'
) ->

    class Keyboard.Delegate

        actions:
            up: {}
            down: {}

        up: (key, fn) ->
            @register key, fn, 'up'

        down: (key, fn) ->
            @register key, fn, 'down'

        # Register a function to a key event
        register: (key, fn, action) ->

            hash = @actions[action]

            # Bind a key to keydrown if it
            # has not previously been bound
            unless hash[key]
                hash[key] = []
                @bindKey key, action, hash

            hash[key].push fn

        # Bind key to a keydrown action
        bindKey: (key, action, hash) ->
            kd[key][action] ->
               fn() for fn in hash[key]

    Keyboard.Delegate = new Keyboard.Delegate()
