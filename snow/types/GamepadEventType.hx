package snow.types;

/** A touch specific event event type */
@:enum abstract GamepadEventType(Int)
from Int to Int {

    var ge_unknown  = 0;
    var ge_axis     = 1;
    /** */
    var ge_down     = 2;
    /** */
    var ge_up       = 3;
    /** */
    var ge_device   = 4;

    inline function toString() {
        return switch(this) {
            case ge_unknown:    'ge_unknown';
            case ge_axis:       'ge_axis';
            case ge_down:       'ge_down';
            case ge_up:         'ge_up';
            case ge_device:     'ge_device';
            case _:             '$this';
        }
    } //toString
} //GamepadEventType