package snow.types;

/** Input modifier state */
@:publicFields
class ModState {
    @:allow(snow)
    private inline function new() {}

    /** no modifiers are down */
    var none : Bool = false;

    /** left shift key is down */
    var lshift : Bool = false;

    /** right shift key is down */
    var rshift : Bool = false;

    /** left ctrl key is down */
    var lctrl : Bool = false;

    /** right ctrl key is down */
    var rctrl : Bool = false;

    /** left alt/option key is down */
    var lalt : Bool = false;

    /** right alt/option key is down */
    var ralt : Bool = false;

    /** left windows/command key is down */
    var lmeta : Bool = false;

    /** right windows/command key is down */
    var rmeta : Bool = false;

    /** numlock is enabled */
    var num : Bool = false;

    /** capslock is enabled */
    var caps : Bool = false;

    /** mode key is down */
    var mode : Bool = false;

    /** left or right ctrl key is down */
    var ctrl : Bool = false;

    /** left or right shift key is down */
    var shift : Bool = false;

    /** left or right alt/option key is down */
    var alt : Bool = false;

    /** left or right windows/command key is down */
    var meta : Bool = false;

    inline function toString() {
        var _s = '{ "ModState":true ';

        if(none) return _s + ', "none":true }';
        if(lshift) _s += ', "lshift":true';
        if(rshift) _s += ', "rshift":true';
        if(lctrl)  _s += ', "lctrl":true';
        if(rctrl)  _s += ', "rctrl":true';
        if(lalt)   _s += ', "lalt":true';
        if(ralt)   _s += ', "ralt":true';
        if(lmeta)  _s += ', "lmeta":true';
        if(rmeta)  _s += ', "rmeta":true';
        if(num)    _s += ', "num":true';
        if(caps)   _s += ', "caps":true';
        if(mode)   _s += ', "mode":true';
        if(ctrl)   _s += ', "ctrl":true';
        if(shift)  _s += ', "shift":true';
        if(alt)    _s += ', "alt":true';
        if(meta)   _s += ', "meta":true';

        _s += '}';

        return _s;
    }
}