package snow.types;

/** The type of format data for audio */
@:enum abstract AudioFormatType(Null<Int>)
    from Null<Int> to Null<Int> {

    var af_unknown  = 0;
    var af_custom   = 1;
    var af_ogg      = 2;
    var af_wav      = 3;
    var af_pcm      = 4;

    inline function toString() {
        return switch(this) {
            case af_unknown:   'af_unknown';
            case af_custom:    'af_custom';
            case af_ogg:       'af_ogg';
            case af_wav:       'af_wav';
            case af_pcm:       'af_pcm';
            case _:             '$this';
        }
    }
}