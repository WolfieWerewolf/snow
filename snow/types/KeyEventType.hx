package snow.types;

/** A key specific event event type */
@:enum abstract KeyEventType(Int)
from Int to Int {

    var ke_unknown = 0;
    var ke_down = 1;
    var ke_up = 2;

    inline function toString() {
        return switch(this) {
            case ke_unknown: 'ke_unknown';
            case ke_down:    'ke_down';
            case ke_up:      'ke_up';
            case _:          '$this';
        }
    }
}