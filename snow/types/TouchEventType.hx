package snow.types;

/** A touch specific event event type */
@:enum abstract TouchEventType(Int)
    from Int to Int {

    var te_unknown = 0;
    var te_move = 1;
    var te_down = 2;
    var te_up = 3;

    inline function toString() {
        return switch(this) {
            case te_unknown:    'te_unknown';
            case te_move:       'te_move';
            case te_down:       'te_down';
            case te_up:         'te_up';
            case _: '$this';
        }
    }
}
