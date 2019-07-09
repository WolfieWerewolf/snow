package snow.types;

/** Window configuration information for creating windows */
typedef WindowConfig = {

    /** create in fullscreen, default: false, `mobile` true */
    @:optional var fullscreen       : Bool;

    /** If false, the users native window/desktop resolution will be used instead of the specified window size. default: false
        On native, changing the users video mode is less than ideal, so true_fullscreen is commonly discouraged. */
    @:optional var true_fullscreen  : Bool;

    /** allow the window to be resized, default: true */
    @:optional var resizable        : Bool;

    /** create as a borderless window, default: false */
    @:optional var borderless       : Bool;

    /** window x at creation. Leave this alone to use the OS default. */
    @:optional var x                : Int;

    /** window y at creation. Leave this alone to use the OS default. */
    @:optional var y                : Int;

    /** window width at creation, default: 960 */
    @:optional var width            : Int;

    /** window height at creation, default: 640 */
    @:optional var height           : Int;

    /** window title, default: 'snow app' */
    @:optional var title            : String;

    /** disables input arriving at/from this window. default: false */
    @:optional var no_input         : Bool;

    /** Time in seconds to sleep when in the background.
        Setting this to zero disables the behavior.
        This has no effect on the web target,
        as there is no concept of sleep there (and browsers usually throttle background tabs).
        Higher sleep times (i.e 1/10 or 1/30) use less cpu. default: 1/15 */
    @:optional var background_sleep : Float;
}