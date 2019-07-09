package snow.types;

@:enum abstract AudioState(Int)
    from Int to Int {

    var as_invalid  = -1;
    var as_paused   = 0;
    var as_playing  = 1;
    var as_stopped  = 2;

    inline function toString() {
        return switch(this) {
            case as_invalid:    'as_invalid';
            case as_paused:     'as_paused';
            case as_playing:    'as_playing';
            case as_stopped:    'as_stopped';
            case _:             '$this';
        }
    }
}