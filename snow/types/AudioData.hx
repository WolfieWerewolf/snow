package snow.types;

import snow.api.Debug.*;

/** An audio data object contains information about audio samples or streams, ready to be used.
    `AudioData` objects typically come from the `app.assets.audio` API or `app.audio.module.data_from_path`,
    since the implemenation details of decoding audio and streams are module level implementation details.
    This is stored by `AudioSource` and `AssetAudio` objects for example.*/
import snow.api.buffers.Uint8Array;
@:allow(snow.systems.audio.AudioInstance)
class AudioData {

    /** Access to the snow runtime */
    public var app: snow.Snow;

    /** The associated id for the data */
    public var id: String = 'AudioData';

    /** The sample data bytes, if any (streams don't populate this) */
    public var samples: Uint8Array;

    /** The sample rate in samples per second */
    public var rate: Int = 44100;

    /** The PCM length in samples */
    public var length: Int = 0;

    /** The number of channels for this data */
    public var channels: Int = 1;

    /** The number of bits per sample for this data */
    public var bits_per_sample: Int = 16;

    /** The audio format type of the sample data */
    public var format: AudioFormatType = af_unknown;

    /** Whether or not this data is a stream of samples */
    public var is_stream: Bool = false;

    /** Whether or not this data has been destroyed */
    public var destroyed: Bool = false;

    inline public function new(_app:snow.Snow, _options:AudioDataOptions) {
        app = _app;
        id = def(_options.id, id);
        rate = def(_options.rate, rate);
        length = def(_options.length, length);
        format = def(_options.format, format);
        channels = def(_options.channels, channels);
        bits_per_sample = def(_options.bits_per_sample, bits_per_sample);
        is_stream = def(_options.is_stream, is_stream);
        samples = def(_options.samples, samples);

        _options = null;
    }

    /** Public API, typically populated by subclasses */
    public function destroy() {
        if(destroyed) return;

        _debug('destroy AudioData `$id`');
        destroyed = true;

        id = null;
        #if snow_native
        if(samples != null) {
            samples.buffer = null;
        }
        #end
        samples = null;
    }

    /** Internal implementation details, populated by subclasses */

    function seek(_to:Int) : Bool return false;

    function portion(_into:Uint8Array, _start:Int, _len:Int, _into_result:Array<Int>) : Array<Int> return _into_result;

    inline function toString() return '{ "AudioData":true, "id":$id, "rate":$rate, "length":$length, "channels":$channels, "format":"$format", "is_stream":$is_stream }';
}
