package snow.types;

/** A system event */
@:allow(snow.Snow)
class SystemEvent {

    /** The type of system event this event is. SystemEventType */
    public var type (default,null) : SystemEventType;

    /** If type is `window` this will be populated, otherwise null */
    public var window (default,null) : WindowEvent;

    /** If type is `input` this will be populated, otherwise null */
    public var input (default,null) : InputEvent;

    inline function new() {}

    inline function set(_type:SystemEventType, _window:WindowEvent, _input:InputEvent) {
        type = _type;
        window = _window;
        input = _input;
    }

    inline function toString() {
        var _s = '{ "SystemEvent":true, "type":"$type"';
        if(window != null) _s += ', "window":$window';
        if(input != null) _s += ', "input":$input';
        _s += ' }';
        return _s;
    }
}