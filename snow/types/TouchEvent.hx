package snow.types;

@:allow(snow.systems.input.Input)
class TouchEvent {
    public var type (default,null): TouchEventType;
    public var touch_id (default,null): Int;
    public var x (default,null): Float;
    public var y (default,null): Float;
    public var dx (default,null): Float;
    public var dy (default,null): Float;

    inline function new() {}

    inline function set(_type:TouchEventType, _id:Int, _x:Float, _y:Float, _dx:Float, _dy:Float) {
        type = _type;
        touch_id = _id;
        x = _x;
        y = _y;
        dx = _dx;
        dy = _dy;
    }

    inline function toString() return '{ "TouchEvent":true, "type":"$type", "touch_id":$touch_id, "x":$x, "y":$y, "dx":$dx, "dy":$dy }';
}