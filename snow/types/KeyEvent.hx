package snow.types;

@:allow(snow.systems.input.Input)
class KeyEvent {
    public var type (default,null): Null<KeyEventType>;
    public var keycode (default,null): Null<Int>;
    public var scancode (default,null): Null<Int>;
    public var repeat (default,null): Null<Bool>;
    public var mod (default,null): ModState;

    inline function new() {}

    inline function set(_type:KeyEventType, _keycode:Int, _scancode:Int, _repeat:Bool, _mod:ModState) {
        type = _type;
        keycode = _keycode;
        scancode = _scancode;
        repeat = _repeat;
        mod = _mod;
    }

    inline function toString() return '{ "KeyEvent":true, "type":"$type", "keycode":$keycode, "scancode":$scancode, "repeat":$repeat, "mod":$mod }';
}
