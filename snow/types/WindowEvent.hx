package snow.types;

/** A system window event */
@:allow(snow.Snow)
class WindowEvent {
    /** The type of window event this was. */
    public var type (default,null) : WindowEventType = we_unknown;

    /** The time in seconds that this event occured, useful for deltas */
    public var timestamp (default,null) : Float = 0.0;

    /** The window id from which this event originated */
    public var window_id (default,null) : Int = -1;

    /** Potential window event data */
    public var x (default,default) : Null<Int>;

    /** Potential window event data */
    public var y (default,default) : Null<Int>;

    inline function new() {}

    inline function set(_type:WindowEventType, _timestamp:Float, _window_id:Int, ?_x:Null<Int>, ?_y:Null<Int>) {
        type = _type;
        timestamp = _timestamp;
        window_id = _window_id;
        x = _x;
        y = _y;
    }

    inline function toString() return '{ "WindowEvent":true, "type":"$type", "window":$window_id, "x":$x, "y":$y, "time":$timestamp }';
}
