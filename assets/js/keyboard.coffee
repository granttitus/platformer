# TODO remove keydrown
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
