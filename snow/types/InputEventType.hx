package snow.types;

@:enum abstract InputEventType(Int)
    from Int to Int {
    /** An unknown input event */
    var ie_unknown = 0;

    /** An keyboard input event */
    var ie_key = 1;

    /** An keyboard text input event */
    var ie_text = 2;

    /** An mouse input event */
    var ie_mouse = 3;

    /** An touch input event */
    var ie_touch = 4;

    /** An gamepad input event. */
    var ie_gamepad = 5;

    /** An joystick input event. These are for older devices, and on mobile (for now): accellerometer */
    var ie_joystick = 6;

    inline function toString() {
        return switch(this) {
            case ie_unknown:       'ie_unknown';
            case ie_key:           'ie_key';
            case ie_text:          'ie_text';
            case ie_mouse:         'ie_mouse';
            case ie_touch:         'ie_touch';
            case ie_gamepad:       'ie_gamepad';
            case ie_joystick:      'ie_joystick';
            case _:                '$this';
        }
    }
}