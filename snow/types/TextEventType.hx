package snow.types;

/** A text specific event event type */
@:enum abstract TextEventType(Int)
from Int to Int {

    /** An unknown text event */
    var te_unknown = 0;

    /** An edit text typing event */
    var te_edit = 1;

    /** An input text typing event */
    var te_input = 2;

    inline function toString() {
        return switch(this) {
            case te_unknown: 'te_unknown';
            case te_edit:    'te_edit';
            case te_input:   'te_input';
            case _:          '$this';
        }
    }
}