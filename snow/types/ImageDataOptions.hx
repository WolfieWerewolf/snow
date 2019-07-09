package snow.types;

import snow.api.buffers.Uint8Array;

/** Information about an image file/data */
typedef ImageDataOptions = {

    /** source asset id */
    var id : String;

    /** image width from source image */
    var width : Int;

    /** image height from source image */
    var height : Int;

    /** The actual width, used when image is automatically padded to POT */
    var width_actual : Int;

    /** The actual height, used when image is automatically padded to POT */
    var height_actual : Int;

    /** used bits per pixel */
    var bpp : Int;

    /** source bits per pixel */
    var bpp_source : Int;

    /** image pixel data */
    var pixels : Uint8Array;
}
