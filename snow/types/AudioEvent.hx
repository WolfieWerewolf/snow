package snow.types;

@:enum abstract AudioEvent(Int)
    from Int to Int {

    var ae_end = 0;
    var ae_destroyed = 1;
    var ae_destroyed_source = 2;

    inline function toString() {
        return switch(this) {
            case ae_end:                'ae_end';
            case ae_destroyed:          'ae_destroyed';
            case ae_destroyed_source:   'ae_destroyed_source';
            case _:                     '$this';
        }
    }
}