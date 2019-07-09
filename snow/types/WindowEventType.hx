package snow.types;

@:enum abstract WindowEventType(Int)
    from Int to Int {

    /** An unknown window event */
    var we_unknown = 0;

    /** The window is shown */
    var we_shown = 1;

    /** The window is hidden */
    var we_hidden = 2;

    /** The window is exposed */
    var we_exposed = 3;

    /** The window is moved */
    var we_moved = 4;

    /** The window is resized, by the user or code. */
    var we_resized = 5;

    /** The window is resized, by the OS or internals. */
    var we_size_changed = 6;

    /** The window is minimized */
    var we_minimized = 7;

    /** The window is maximized */
    var we_maximized = 8;

    /** The window is restored */
    var we_restored = 9;

    /** The window is entered by a mouse */
    var we_enter = 10;

    /** The window is left by a mouse */
    var we_leave = 11;

    /** The window has gained focus */
    var we_focus_gained = 12;

    /** The window has lost focus */
    var we_focus_lost = 13;

    /** The window is being closed/hidden */
    var we_close = 14;

    inline function toString() {
        return switch(this) {
            case we_unknown:       'we_unknown';
            case we_shown:         'we_shown';
            case we_hidden:        'we_hidden';
            case we_exposed:       'we_exposed';
            case we_moved:         'we_moved';
            case we_resized:       'we_resized';
            case we_size_changed:  'we_size_changed';
            case we_minimized:     'we_minimized';
            case we_maximized:     'we_maximized';
            case we_restored:      'we_restored';
            case we_enter:         'we_enter';
            case we_leave:         'we_leave';
            case we_focus_gained:  'we_focus_gained';
            case we_focus_lost:    'we_focus_lost';
            case we_close:         'we_close';
            case _:                '$this';
        }
    }
}