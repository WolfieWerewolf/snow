package snow.types;

/** A gamepad device event type */
@:enum abstract GamepadDeviceEventType(Int)
    from Int to Int {

    /** A unknown device event */
    var ge_unknown = 0;

    /** A device added event */
    var ge_device_added = 1;

    /** A device removed event */
    var ge_device_removed = 2;

    /** A device was remapped */
    var ge_device_remapped = 3;

    inline function toString() {
        return switch(this) {
            case ge_unknown:         'ge_unknown';
            case ge_device_added:    'ge_device_added';
            case ge_device_removed:  'ge_device_removed';
            case ge_device_remapped: 'ge_device_remapped';
            case _:                  '$this';
        }
    }
}