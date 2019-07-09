package snow.systems.audio;

import snow.types.AudioData;
import snow.api.Debug.*;
import snow.types.Types.AudioHandle;
import snow.systems.audio.AudioInstance;

class AudioSource {

    public var app: snow.Snow;
    public var data: AudioData;

        /** Streams only:  The size in bytes of a single stream buffer.
            This is ~1 sec in 16 bit mono. default:176400
            for most cases this can be left alone. */
    public var stream_buffer_length : Int = 176400;
        /** Streams only: The number of buffers to queue up. default:2
            For most cases this can be left alone. */
    public var stream_buffer_count : Int = 2;
        /** Whether this source has been destroyed */
    public var destroyed : Bool = false;
        /** A unique key for this source  */
    public var source_id : String;

        //local list of instances spawned from this source.
        //used when destroying the source, to take instances with it.
    var instances : Array<AudioInstance>;

    public function new(_app:snow.Snow, _data:AudioData) {

        app = _app;
        data = _data;
        source_id = app.uniqueid;

        _debug('AudioSource / `$source_id` / ${data.id}');

        instances = [];

    } //new

        /** Called by the audio system to obtain a new instance of this source. */
    public function instance(_handle:AudioHandle) : AudioInstance {

        var _instance = new AudioInstance(this, _handle);

        if(instances.indexOf(_instance) == -1) {
            instances.push(_instance);
        }

        return _instance;

    } //instance

        /** A helper for converting bytes to seconds for a sound source */
    public function bytes_to_seconds(_bytes:Int) : Float {

        var _word = data.bits_per_sample == 16 ? 2 : 1;
        var _sample_frames = (data.rate * data.channels * _word);

        return _bytes / _sample_frames;

    } //bytes_to_seconds

        /** A helper for converting seconds to bytes for this audio source */
    public function seconds_to_bytes(_seconds:Float) : Int {

        var _word = data.bits_per_sample == 16 ? 2 : 1;
        var _sample_frames = (data.rate * data.channels * _word);

        return Std.int(_seconds * _sample_frames);

    } //seconds_to_bytes

        //
    public function duration() : Float {

        return bytes_to_seconds(data.length);

    } //duration

    public function destroy() {

        if(destroyed) {
            log('destroying already destroyed source!');
            return;
        }

        destroyed = true;

        var c = instances.length;
        var i = 0;

        _debug('destroy / $source_id / ${data.id}, stream=${data.is_stream}, instances=$c');

        while(i < c) {
            var _instance = instances.pop();
            _instance.destroy();
            _instance = null;
            i++;
        }

        app.audio.emit(ae_destroyed_source, this);

        data.destroy();
        data = null;
        instances = null;
        app = null;

    } //destroy

    @:allow(snow.systems.audio.AudioInstance)
    function instance_killed(_instance:AudioInstance) {

        instances.remove(_instance);

    }

} //AudioSource
