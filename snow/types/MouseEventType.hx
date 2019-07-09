package snow.types;

/** A mouse specific event event type */
@:enum abstract MouseEventType(Int)
    from Int to Int {

    var me_unknown = 0;
    var me_move = 1;
    var me_down = 2;
    var me_up = 3;
    var me_wheel = 4;

    inline function toString() {
        return switch(this) {
            case me_unknown:    'me_unknown';
            case me_move:       'me_move';
            case me_down:       'me_down';
            case me_up:         'me_up';
            case me_wheel:      'me_wheel';
            case _:             '$this';
        }
    }
}