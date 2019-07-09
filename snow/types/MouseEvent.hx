package snow.types;

@:allow(snow.systems.input.Input)

class MouseEvent {
    public var type (default, null): MouseEventType;
    public var x (default, null): Int;
    public var y (default, null): Int;
    public var x_rel (default, null): Int;
    public var y_rel (default, null): Int;
    public var button (default, null): Int;
    public var wheel_x (default, null): Float;
    public var wheel_y (default, null): Float;

    inline function new() {}

    inline function set(_type:MouseEventType, _x:Int, _y:Int, _x_rel:Int, _y_rel:Int, _button:Int, _wheel_x:Float, _wheel_y:Float) {
        type = _type;
        x = _x;
        y = _y;
        x_rel = _x_rel;
        y_rel = _y_rel;
        button = _button;
        wheel_x = _wheel_x;
        wheel_y = _wheel_y;
    }

    inline function toString() return '{ "MouseEvent":true, "type":"$type", "x":$x, "y":$y, "button":$button, "x_rel":$x_rel, "y_rel":$y_rel, "wheel_x":$wheel_x, "wheel_y":$wheel_y }';
}
