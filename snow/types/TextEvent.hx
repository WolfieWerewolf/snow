package snow.types;

@:allow(snow.systems.input.Input)
class TextEvent {

    public var type (default, null): Null<TextEventType>;
    public var text (default, null): String;
    public var start (default, null): Null<Int>;
    public var length (default, null): Null<Int>;

    inline function new() {}

    @:allow(snow.core.Runtime)
    inline function set(_type:TextEventType, _text:String, _start:Int, _length:Int) {
        type = _type;
        text = _text;
        start = _start;
        length = _length;
    }

    inline function toString() return '{ "TextEvent":true, "type":"$type", "text":"$text", "start":$start, "length":$length }';
}
