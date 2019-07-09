package snow.types;

import snow.api.Debug.*;
import snow.api.buffers.Uint8Array;

class ImageData {

    public var app : snow.Snow;

    /** source asset id */
    public var id : String = 'ImageData';

    /** image width from source image */
    public var width : Int = 0;

    /** image height from source image */
    public var height : Int = 0;

    /** The actual width, used when image is automatically padded to POT */
    public var width_actual : Int = 0;

    /** The actual height, used when image is automatically padded to POT */
    public var height_actual : Int = 0;

    /** used bits per pixel */
    public var bpp : Int = 4;

    /** source bits per pixel */
    public var bpp_source : Int = 4;

    /** image pixel data */
    public var pixels : Uint8Array;

    inline public function new(_app:snow.Snow, _options:ImageDataOptions) {
        app = _app;

        id = def(_options.id, id);
        width = _options.width;
        height = _options.height;
        width_actual = _options.width_actual;
        height_actual = _options.height_actual;
        bpp = _options.bpp;
        bpp_source = _options.bpp_source;
        pixels = def(_options.pixels, pixels);

        _options = null;
    }

    public function destroy() {
        id = null;
        #if snow_native pixels.buffer = null; #end
        pixels = null;
    }

    inline function toString() return '{ "ImageData":true, "id":$id, "width":$width, "height":$height, "width_actual":$width_actual, "height_actual":$height_actual, "bpp":$bpp, "bpp_source":$bpp_source }';
}
