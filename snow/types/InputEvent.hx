package snow.types;

@:allow(snow.systems.input.Input)
class InputEvent {

    /** The type of input event this was. */
    public var type (default,null) : InputEventType;

    /** The time in seconds that this event occured, useful for deltas. 0.0 if not specified */
    public var timestamp (default,null) : Float = 0.0;

    /** The window id from which this event originated, if any. -1 if not specified */
    public var window_id (default,null) : Int = -1;

    /** Populated if the event type is ie_key, otherwise null */
    public var key (default,null) : KeyEvent;

    /** Populated if the event type is ie_text, otherwise null */
    public var text (default,null) : TextEvent;

    /** Populated if the event type is ie_mouse, otherwise null */
    public var mouse (default,null) : MouseEvent;

    /** Populated if the event type is ie_touch, otherwise null */
    public var touch (default,null) : TouchEvent;

    /** Populated if the event type is ie_gamepad, otherwise null */
    public var gamepad (default,null) : GamepadEvent;

    function new() {}

    inline function reset(_type:InputEventType, _window_id:Int, _timestamp:Float) {
        type = _type;
        key = null;
        text = null;
        mouse = null;
        touch = null;
        gamepad = null;
        window_id = _window_id;
        timestamp = _timestamp;
    }

    inline function set_key(_event:KeyEvent, _window_id:Int, _timestamp:Float) {
        reset(ie_key, _window_id, _timestamp);
        key = _event;
    }

    inline function set_text(_event:TextEvent, _window_id:Int, _timestamp:Float) {
        reset(ie_text, _window_id, _timestamp);
        text = _event;
    }

    inline function set_mouse(_event:MouseEvent, _window_id:Int, _timestamp:Float) {
        reset(ie_mouse, _window_id, _timestamp);
        mouse = _event;
    }

    inline function set_touch(_event:TouchEvent, _timestamp:Float) {
        reset(ie_touch, 0, _timestamp);
        touch = _event;
    }

    inline function set_gamepad(_event:GamepadEvent, _timestamp:Float) {
        reset(ie_gamepad, 0, _timestamp);
        gamepad = _event;
    }

    inline function toString() {
        var _s = '{ "InputEvent":true, "type":"$type"';

        if(key != null)     _s += ', "key":$key';
        if(text != null)    _s += ', "text":$text';
        if(mouse != null)   _s += ', "mouse":$mouse';
        if(touch != null)   _s += ', "touch":$touch';
        if(gamepad != null) _s += ', "gamepad":$gamepad';

        _s += '"window":$window_id, "time":$timestamp }';

        return _s;
    }
}
