package snow.types;

/** A type to identify assets when stored as an Asset */
@:enum abstract AssetType(Int)
    from Int to Int {

    /** An unknown asset type */
    var at_unknown = 0;

    /** An asset holding bytes data, as `Uint8Array` */
    var at_bytes = 1;

    /** An asset holding text data, as `String` */
    var at_text = 2;

    /** An asset holding JSON data, as `Dynamic` */
    var at_json = 3;

    /** An asset holding image data, as `ImageData` */
    var at_image = 4;

    /** An asset holding audio data, as `AudioSource` */
    var at_audio = 5;

    inline function toString() {
        return switch(this) {
            case at_unknown: 'at_unknown';
            case at_bytes:   'at_bytes';
            case at_text:    'at_text';
            case at_json:    'at_json';
            case at_image:   'at_image';
            case at_audio:   'at_audio';
            case _:          '$this';
        }
    }
}