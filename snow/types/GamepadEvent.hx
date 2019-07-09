package snow.types;

@:allow(snow.systems.input.Input)

class GamepadEvent {
    public var type (default,null): GamepadEventType;
    public var gamepad (default,null): Int;
    public var axis (default,null): Null<Int>;
    public var button (default,null): Null<Int>;
    public var value (default,null): Null<Float>;
    public var device_id (default,null): String;
    public var device_event (default,null): Null<GamepadDeviceEventType>;

    inline function new() {}

    inline function set_axis(_gamepad:Int, _axis:Int, _value:Float) {
        button = null;
        device_id = null;
        device_event = null;

        axis    = _axis;
        value   = _value;
        type    = ge_axis;
        gamepad = _gamepad;
    }

    inline function set_button(_type:GamepadEventType, _gamepad:Int, _button:Int, _value:Float) {
        axis = null;
        device_id = null;
        device_event = null;

        type    = _type;
        value   = _value;
        button  = _button;
        gamepad = _gamepad;
    }

    inline function set_device(_gamepad:Int, _id:String, _event:GamepadDeviceEventType) {
        axis = null;
        value = null;
        button = null;

        device_id    = _id;
        device_event = _event;
        gamepad      = _gamepad;
        type         = ge_device;
    }

    inline function toString() return '{ "GamepadEvent":true, "type":"$type", "gamepad":$gamepad, "axis":$axis, "button":$button, "value":$value, "device_id":"$device_id", "device_event":"$device_event" }';
}