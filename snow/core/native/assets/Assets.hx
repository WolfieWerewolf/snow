package snow.core.native.assets;

import snow.types.Types;
import snow.api.Promise;
import snow.api.Debug.*;

import snow.api.buffers.Uint8Array;
import snow.api.buffers.ArrayBufferView;
import snow.api.buffers.DataView;
import snow.core.native.io.IO.FileSeek;

import stb.Image;
import ogg.Ogg;

@:allow(snow.systems.assets.Assets)
class Assets implements snow.modules.interfaces.Assets {

    var app: snow.Snow;
    function new( _app:snow.Snow ) app = _app;
    function onevent(event:SystemEvent):Void {}
    function shutdown() {}

//images

    public function image_info_from_load(_path:String, ?_components:Int = 4) : Promise {

        assertnull(_path);

        return new Promise(function(resolve, reject) {

            var _image = image_info_from_load_direct(_path, _components);

            if(_image == null) {
                var reason = load_direct_err == 1 ? 'invalid file handle, file not found?' : stb.Image.failure_reason();
                reject(Error.error('failed to load `$_path` as image. reason: `$reason`'));
            } else {
                resolve(_image);
            }

        }); //promise

    } //image_info_from_load

    var load_direct_err = 0;
    public function image_info_from_load_direct(_path:String, ?_components:Int = 4) : ImageInfo {

        assertnull(_path);

        load_direct_err = 0;

        var _handle = app.io.module.file_handle(_path, 'rb');
        if(_handle == null) {
            load_direct_err = 1;
            return null;
        }

        var _size = app.io.module.file_size(_handle);
        var _file = new Uint8Array(_size);

        if(_size > 0) {
            app.io.module.file_read(_handle, _file, _size, 1);
        }

        app.io.module.file_close(_handle);

        return image_info_from_bytes_direct(_path, _file, _components);

    } //image_info_from_load

    public function image_info_from_bytes(_id:String, _bytes:Uint8Array, ?_components:Int = 4) : Promise {

        assertnull(_id);
        assertnull(_bytes);

        return new Promise(function(resolve, reject) {

            var _image = image_info_from_bytes_direct(_id, _bytes, _components);

            if(_image == null) {
                reject(Error.error('failed to load `$_id` from bytes. reason: `${stb.Image.failure_reason()}`'));
            } else {
                resolve(_image);
            }

        }); //promise

    } //image_info_from_bytes

    public function image_info_from_bytes_direct(_id:String, _bytes:Uint8Array, ?_components:Int=4) : ImageInfo {

        assertnull(_id);
        assertnull(_bytes);

        var _image_bytes = _bytes.toBytes();
        var _info = stb.Image.load_from_memory(_image_bytes.getData(), _image_bytes.length, _components);

        if(_info == null) {
            return null;
        }

        var _pixel_bytes : haxe.io.Bytes = haxe.io.Bytes.ofData(_info.bytes);

        return {
            id : _id,
            bpp : _info.req_comp,
            width : _info.w,
            height : _info.h,
            width_actual : _info.w,
            height_actual : _info.h,
            bpp_source : _info.comp,
            pixels : new Uint8Array( _pixel_bytes )
        };

    } //info_from_bytes

    public function image_info_from_pixels(_id:String, _width:Int, _height:Int, _pixels:Uint8Array, ?_bpp:Int=4) : ImageInfo {

        assertnull( _id );
        assertnull( _pixels );

        return {
            id : _id,
            bpp : _bpp,
            width : _width,
            height : _height,
            width_actual : _width,
            height_actual : _height,
            bpp_source : _bpp,
            pixels : _pixels
        };

    } //image_info_from_pixels

//audio

    public function audio_info_from_load(_path:String, ?_is_stream:Bool=false, ?_format:AudioFormatType) : Promise {

        assertnull(_path);

        if(_format == null) _format = audio_format_from_ext(_path);

        return new Promise(function(resolve,reject) {

            var _audio = audio_info_from_load_direct(_path, _is_stream, _format);

            if(_audio == null) {
                reject(Error.error('failed to load `$_path` as `$_format` audio.'));
            } else {
                resolve(_audio);
            }

        });

    } //audio_info_from_load

    public function audio_info_from_load_direct(_path:String, ?_is_stream:Bool=false, ?_format:AudioFormatType) : AudioInfo {

        assertnull(_path);

        if(_format == null) _format = audio_format_from_ext(_path);

        var _info = switch(_format) {
            case af_wav: WAV.from_file(app, _path, _is_stream);
            case af_ogg: OGG.from_file(app, _path, _is_stream);
            case af_pcm: PCM.from_file(app, _path, _is_stream);
            case _: null;
        } //switch _format

        return _info;

    } //audio_info_from_load

    public function audio_info_from_bytes(_id:String, _bytes:Uint8Array, ?_format:AudioFormatType) : Promise {

        assertnull(_id);
        assertnull(_bytes);

        return new Promise(function(resolve, reject) {

            var _audio = audio_info_from_bytes_direct(_id, _bytes, _format);

            if(_audio == null) {
                reject(Error.error('failed to load `$_id` from bytes as ${_format}.'));
            } else {
                resolve(_audio);
            }

        }); //promise

    } //image_info_from_bytes

    public function audio_info_from_bytes_direct(_id:String, _bytes:Uint8Array, ?_format:AudioFormatType) : AudioInfo {

        assertnull(_id);
        assertnull(_bytes);

        if(_format == null) _format = audio_format_from_ext(_id);

        var _info = switch(_format) {
            case af_wav: WAV.from_bytes(app, _id, _bytes);
            case af_ogg: OGG.from_bytes(app, _id, _bytes);
            case af_pcm: PCM.from_bytes(app, _id, _bytes);
            case _ : null;
        } //switch _format

        return _info;

    } //audio_info_from_bytes_direct

//helpers

    function audio_format_from_ext(_path:String) : AudioFormatType {

        var _ext = haxe.io.Path.extension(_path);
        return switch(_ext) {
            case 'wav': af_wav;
            case 'ogg': af_ogg;
            case 'pcm': af_pcm;
            case _:     af_unknown;
        }

    } //audio_format_from_ext

} //Assets


private typedef WavChunk = { id:String, offset:Int, data:Uint8Array }
private typedef WavHandle = { handle:FileHandle, offset:Int }

private class AudioInfoWAV extends AudioInfo {

    public var data_offset : Int;
    public var handle : FileHandle;

    inline public function new(_handle:FileHandle, _offset:Int, _opt:AudioInfoOptions) {

        handle = _handle;
        data_offset = _offset;

        super(_opt);

    } //new

    override public function destroy() {

        if(handle != null) {
            app.io.module.file_close(handle);
        }

        handle = null;

    } //destroy

    override public function seek(_to:Int) : Bool {

        var _result = app.io.module.file_seek(handle, data_offset + _to, FileSeek.set);

        return _result == 0;

    } //seek

    override public function portion(_into:Uint8Array, _start:Int, _len:Int, _into_result:Array<Int>) : Array<Int> {

        if(_start != -1) {
            seek(_start+data_offset);
        }

        var _complete = false;
        var _read_len = _len;
        var _current_pos = app.io.module.file_tell(handle) - data_offset;
        var _distance_to_end = data.length_pcm - _current_pos;

        if(_distance_to_end <= _read_len) {
            _read_len = _distance_to_end;
            _complete = true;
        }

        if(_read_len <= 0) {
            _into_result[0] = 0;
            _into_result[1] = 1;
            return _into_result;
        }

        _debug('wav / reading $_read_len bytes from $_start');

            //resize to fit the requested/remaining length
        var _byte_gap = (_read_len & 0x03);
        // var _samples = new Uint8Array(_read_len + _byte_gap);
        var _n_elements = 1;
        var _elements_read = app.io.module.file_read(handle, _into, _read_len, _n_elements);

            //if no elements were read, it was an error
            //or end of file so either way it's complete.
        if(_elements_read == 0) _complete = true;

        _debug('wav / total read $_read_len bytes, complete? $_complete');

        _into_result[0] = _read_len;
        _into_result[1] = (_complete)?1:0;

        return _into_result;

    } //portion

} //AudioInfoWaV

@:allow(snow.core.native.assets.Assets)
private class WAV {

    static function from_file(app:snow.Snow, _path:String, _is_stream:Bool) {

        var _handle = app.io.module.file_handle(_path, 'rb');

        return from_file_handle(app, _handle, _path, _is_stream);

    } //from_file

    static function from_bytes(app:snow.Snow, _path:String, _bytes:Uint8Array) : AudioInfo {

        var _handle = app.io.module.file_handle_from_mem(_bytes, _bytes.length);

        return from_file_handle(app, _handle, _path, false);

    } //from_bytes

 //helpers

    static function from_file_handle(app:snow.Snow, _handle:FileHandle, _path:String, _is_stream:Bool) : AudioInfo {

        if(_handle == null) return null;

        var _length = 0;
        var _info = new AudioInfoWAV(_handle, 0, {
            app:        app,
            id:         _path,
            is_stream:  _is_stream,
            format:     af_wav,
            data: {
                samples         : null,
                length          : _length,
                length_pcm      : _length,
                channels        : 1,
                rate            : 44100,
                bitrate         : 88200,
                bits_per_sample : 16
            }
        });

        if(!_is_stream) {

            var _header = new Uint8Array(12);
            app.io.module.file_read(_handle, _header, 12, 1);

            var _bytes = _header.toBytes();
            var _file_id = _bytes.getString(0, 4);
            var _file_format = _bytes.getString(8, 4);

            _header = null;
            _bytes = null;

            if(_file_id != 'RIFF') {
                log('assets / audio / wav / file `$_path` has invalid header (id `$_file_id`, expected RIFF)');
                return null;
            }

            if(_file_format != 'WAVE') {
                log('assets / audio / wav / file `$_path` has invalid header (id `$_file_format`, expected WAVE)');
                return null;
            }

            var _chunks = ['fmt ', 'data'];
            var _found_data = false;
            var _found_format = false;
            var _limit = 0;

            while(!_found_format && !_found_data || _limit < 32) {

                var _chunk = read_chunk(app, _handle, _chunks);

                if(_chunk.id == _chunks[0]) {
                    _found_format = true;

                    // 16 bytes                 size /  at
                    // short audioFormat;         2  /  0
                    // short numChannels;         2  /  2
                    // unsigned int sampleRate;   4  /  4
                    // unsigned int byteRate;     4  /  8
                    // short blockAlign;          2  /  12
                    // short bitsPerSample;       2  /  14

                    var _format = _chunk.data.toBytes();
                    _info.data.bitrate = _format.getInt32(8);
                    _info.data.bits_per_sample = _format.getUInt16(14);
                    _info.data.channels = _format.getUInt16(2);
                    _info.data.rate = _format.getInt32(4);
                    _format = null;
                } //fmt

                if(_chunk.id == _chunks[1]) {
                    _found_data = true;
                    _info.data.samples = _chunk.data;
                    _info.data.length = _info.data.length_pcm = _chunk.data.length;
                    _info.data_offset = _chunk.offset;
                } //data

                _chunk.data = null;
                _chunk = null;

                ++_limit;

            } //while

        } //if !_is_stream

        return _info;

    } //from_file_handle

    static function read_chunk(app:snow.Snow, _handle:FileHandle, _read_if:Array<String>) : WavChunk {

        var _header_size = 8;
        var _header = new Uint8Array(_header_size);

        app.io.module.file_read(_handle, _header, _header_size, 1);

        var _header_bytes = _header.toBytes();
        var _chunk_id = _header_bytes.getString(0, 4);
        var _chunk_size = _header_bytes.getInt32(4);

        _header = null;
        _header_bytes = null;

        var _data : Uint8Array = null;
        var _pos = app.io.module.file_tell(_handle);

            //if this is a chunk we want to read?
        if(_read_if.indexOf(_chunk_id) != -1) {
            _data = new Uint8Array(_chunk_size);
            app.io.module.file_read(_handle, _data, _chunk_size, 1);
        } else {
            app.io.module.file_seek(_handle, _pos+_header_size+_chunk_size, set);
        }

        return {
            id: _chunk_id,
            offset: _pos,
            data: _data
        }

    } //read_chunk

} //WAV

private class AudioInfoPCM extends AudioInfo {

    public var handle : FileHandle;

    inline public function new(_handle:FileHandle, _opt:AudioInfoOptions) {

        handle = _handle;

        super(_opt);

    } //new

    override public function destroy() {

        if(handle != null) {
            app.io.module.file_close(handle);
            handle = null;
        }

        app = null;
        handle = null;

    } //destroy

    override public function seek(_to:Int) : Bool {

        if(handle == null) return false;

        var _result = app.io.module.file_seek(handle, _to, FileSeek.set);

        return _result == 0;

    } //seek

    override public function portion(_into:Uint8Array, _start:Int, _len:Int, _into_result:Array<Int>) : Array<Int> {

        inline function _fail() {
            _into_result[0] = 0;
            _into_result[1] = 1;
            return _into_result;
        }

        if(handle == null) return _fail();

        if(_start != -1) {
            seek(_start);
        }

        var _complete = false;
        var _read_len = _len;
        var _cur_pos = app.io.module.file_tell(handle);
        var _distance_to_end = data.length_pcm - _cur_pos;

        if(_distance_to_end <= _read_len) {
            _read_len = _distance_to_end;
            _complete = true;
        }

        if(_read_len <= 0) return _fail();

        log('pcm / reading $_read_len bytes from $_start');

            //resize to fit the requested/remaining length
        var _byte_gap = (_read_len & 0x03);
        // var _samples = new Uint8Array(_read_len + _byte_gap);
        var _n_elements = 1;
        var _elements_read = app.io.module.file_read(handle, _into, _read_len, _n_elements);

            //if no elements were read, it was an error
            //or end of file so either way it's complete.
        if(_elements_read == 0) _complete = true;

        log('pcm / total read $_read_len bytes, complete? $_complete');

        _into_result[0] = _read_len;
        _into_result[1] = (_complete)?1:0;

        return _into_result;

    } //portion

} //AudioInfoPCM


@:allow(snow.core.native.assets.Assets)
private class PCM {

    static function from_file(app:snow.Snow, _path:String, _is_stream:Bool) : AudioInfo {

        var _handle = app.io.module.file_handle(_path, 'rb');
        if(_handle == null) return null;

        var _length = app.io.module.file_size(_handle);
        var _samples : Uint8Array = null;

        if(!_is_stream) {
            _samples = new Uint8Array(_length);
            var _read = app.io.module.file_read(_handle, _samples, _length, 1);
            if(_read != _length) {
                _samples = null;
                return null;
            }
        } //!_is_stream

        //the sound format values are sane defaults -
        //change these values right before creating the sound itself.

        return new AudioInfoPCM(_handle, {
            app:        app,
            id:         _path,
            is_stream:  _is_stream,
            format:     af_pcm,
            data: {
                samples         : _samples,
                length          : _length,
                length_pcm      : _length,
                channels        : 1,
                rate            : 44100,
                bitrate         : 88200,
                bits_per_sample : 16
            }

        }); //return

    } //from_file

    static function from_bytes(app:snow.Snow, _id:String, _bytes:Uint8Array) : AudioInfo {

        return new AudioInfoPCM(null, {
            app:        app,
            id:         _id,
            is_stream:  false,
            format:     af_pcm,
            data: {
                samples         : _bytes,
                length          : _bytes.length,
                length_pcm      : _bytes.length,
                channels        : 1,
                rate            : 44100,
                bitrate         : 88200,
                bits_per_sample : 16
            }
        }); //return

    } //from_bytes


} //PCM


private class AudioInfoOGG extends AudioInfo {

    public var handle : FileHandle;
    public var oggfile : OggVorbisFile;

    inline public function new(_handle:FileHandle, _oggfile:OggVorbisFile, _opt:AudioInfoOptions) {

        handle = _handle;
        oggfile = _oggfile;

        super(_opt);

    } //new

    override public function destroy() {

        if(handle != null) {
            app.io.module.file_close(handle);
        }

        handle = null;
        Ogg.ov_clear(oggfile);
        oggfile = null;

    } //destroy

    override public function seek(_to:Int) : Bool {

            //pcm seek is in samples, not bytes
            //:todo: ogg is always 16?
        var _to_samples = haxe.Int64.ofInt(Std.int(_to/16));
        var res = Ogg.ov_pcm_seek(oggfile, _to_samples);

        return res == 0;

    } //seek

    override public function portion(_into:Uint8Array, _start:Int, _len:Int, _into_result:Array<Int>) : Array<Int> {

        var complete = false;
        var word = 2; //1 for 8 bit, 2 for 16 bit. 2 is typical
        var sgned = 1; //0 for unsigned, 1 is typical
        var bit_stream = 1;

        var _read_len = _len;

        if(_start != -1) {
            // log('start was $_start, skipping there first');
            seek(_start);
        }

            //resize to fit the requested length, but pad it slightly to align
        // var byte_gap = (_read_len & 0x03);
        // out_buffer.resize(_read_len + byte_gap);
        //:todo: check these alignment paddings in snow alpha-2.0

        var reading = true;
        var bytes_left = _read_len;
        var total_read = 0;
        var bytes_read = 0;
        var OGG_BUFFER_LENGTH = 128;

        while(reading) {

            var _read_max = OGG_BUFFER_LENGTH;

            if(bytes_left < _read_max) {
                _read_max = bytes_left;
            }

                // Read the decoded sound data
            bytes_read = Ogg.ov_read(oggfile, _into.buffer.getData(), total_read, _read_max, OggEndian.TYPICAL, OggWord.TYPICAL, OggSigned.TYPICAL);

            total_read += bytes_read;
            bytes_left -= bytes_read;

                //at the end?
            if(bytes_read == 0) {
                reading = false;
                complete = true;
            }

            if(total_read >= _read_len) {
                reading = false;
            }

        } //while

            //we need the buffer length to reflect the real size,
            //just in case it read shorter than requested
        if(total_read != _read_len) {
            var byte_gap = (_read_len & 0x03);
            // trace('not matched size $total_read / $_read_len');
            // out_buffer.resize(total_read+byte_gap);
            //:todo: check these alignment paddings in snow alpha-2.0
        }

        _into_result[0] = total_read;
        _into_result[1] = (complete) ? 1 : 0;

        return _into_result;

    } //portion

} //AudioInfoOGG


@:allow(snow.core.native.assets.Assets)
private class OGG {

    static function from_file(app:snow.Snow, _path:String, _is_stream:Bool) : AudioInfo {

        var _handle = app.io.module.file_handle(_path, 'rb');

        return from_file_handle(app, _handle, _path, _is_stream);

    } //from_file


    static function from_bytes(app:snow.Snow, _path:String, _bytes:Uint8Array) : AudioInfo {

        var _handle = app.io.module.file_handle_from_mem(_bytes, _bytes.length);

        return from_file_handle(app, _handle, _path, false);

    } //from_bytes

    static function from_file_handle(app:snow.Snow, _handle:FileHandle, _path:String, _is_stream:Bool) : AudioInfo {

        if(_handle == null) return null;

        var _ogg_file = Ogg.newOggVorbisFile();

        var _ogg = new AudioInfoOGG(_handle, _ogg_file, {
            app:    app,
            id:     _path,
            format: af_ogg,
            data: {
                samples         : null,
                length          : app.io.module.file_size(_handle),
                length_pcm      : 0,
                channels        : 0,
                rate            : 0,
                bitrate         : 0,
                bits_per_sample : 16 //:todo:optionize ogg bits per sample
            }
        });

        // trace('file size is ' + _ogg.data.length);

        var _ogg_result = Ogg.ov_open_callbacks(_ogg, _ogg_file, null, 0, {
            read_fn:  ogg_read,
            seek_fn:  ogg_seek,
            close_fn: null,
            tell_fn:  ogg_tell
        });

        // trace('ov_open_callbacks ' + code(_ogg_result));

        if(_ogg_result < 0) {

            app.io.module.file_close(_handle);

            log('/ snow / ogg file failed to open!? / result:$_ogg_result code: ${code(_ogg_result)}');

            return null;

        } //result < 0

        var _ogg_info = Ogg.ov_info(_ogg_file, -1);

        _verbose('version: '+Std.int(_ogg_info.version));
        _verbose('serial: '+Std.int(Ogg.ov_serialnumber(_ogg_file,-1)));
        _verbose('seekable: '+Std.int(Ogg.ov_seekable(_ogg_file)));
        _verbose('streams: '+Std.int(Ogg.ov_streams(_ogg_file)));
        _verbose('rate: '+Std.int(_ogg_info.rate));
        _verbose('channels: '+Std.int(_ogg_info.channels));

        _verbose('pcm: '+Std.string( Ogg.ov_pcm_total(_ogg_file,-1) ));
        _verbose('raw: '+Std.string( Ogg.ov_raw_total(_ogg_file,-1) ));
        _verbose('time: '+Std.string( Ogg.ov_time_total(_ogg_file,-1) ));

        _verbose('ov_bitrate: ' + code(Ogg.ov_bitrate(_ogg_file, -1)));
        _verbose('ov_bitrate_instant: ' + code(Ogg.ov_bitrate_instant(_ogg_file)));
        _verbose('bitrate_lower: '+Std.int(_ogg_info.bitrate_lower));
        _verbose('bitrate_nominal: '+Std.int(_ogg_info.bitrate_nominal));
        _verbose('bitrate_upper: '+Std.int(_ogg_info.bitrate_upper));
        _verbose('bitrate_window: '+Std.int(_ogg_info.bitrate_window));

        _verbose('pcm tell: '+code( cast Ogg.ov_pcm_tell(_ogg_file) ));
        _verbose('raw tell: '+code( cast Ogg.ov_raw_tell(_ogg_file) ));
        _verbose('time tell: '+code( cast Ogg.ov_time_tell(_ogg_file) ));

        var _total_pcm_length : UInt = haxe.Int64.toInt(Ogg.ov_pcm_total(_ogg_file, -1)) * _ogg_info.channels * 2;

        _ogg.data.channels = _ogg_info.channels;
        _ogg.data.rate = Std.int(_ogg_info.rate);
        _ogg.data.bitrate = Std.int(_ogg_info.bitrate_nominal);
        _ogg.data.length_pcm = _total_pcm_length;

        _ogg.seek(0);

        var _comment = Ogg.ov_comment(_ogg_file, -1);
        _verbose('vendor: ' + _comment.vendor);
        for(c in _comment.comments) {
            _verbose('           $c');
        }

        if(!_is_stream) {
            _ogg.data.samples = new Uint8Array(_total_pcm_length);
            _ogg.portion(_ogg.data.samples, 0, _total_pcm_length, []);
        }

        return _ogg;

    } //from_file_handle

 //helpers

        //converts return code to string
    inline static function code(_code:OggCode) : String {
        return switch(_code){
            case OggCode.OV_EBADHEADER:'OV_EBADHEADER';
            case OggCode.OV_EBADLINK:'OV_EBADLINK';
            case OggCode.OV_EBADPACKET:'OV_EBADPACKET';
            case OggCode.OV_EFAULT:'OV_EFAULT';
            case OggCode.OV_EIMPL:'OV_EIMPL';
            case OggCode.OV_EINVAL:'OV_EINVAL';
            case OggCode.OV_ENOSEEK:'OV_ENOSEEK';
            case OggCode.OV_ENOTAUDIO:'OV_ENOTAUDIO';
            case OggCode.OV_ENOTVORBIS:'OV_ENOTVORBIS';
            case OggCode.OV_EOF:'OV_EOF';
            case OggCode.OV_EREAD:'OV_EREAD';
            case OggCode.OV_EVERSION:'OV_EVERSION';
            case OggCode.OV_FALSE:'OV_FALSE';
            case OggCode.OV_HOLE: 'OV_HOLE';
            case _:'$_code';
        }
    } //code



 //ogg callbacks


        //read function for ogg callbacks
    static function ogg_read(_ogg:AudioInfoOGG, size:Int, nmemb:Int, data:haxe.io.BytesData):Int {

        var _total = size * nmemb;
        var _bytes = haxe.io.Bytes.ofData(data);
        var _buffer = new Uint8Array(_bytes);

        //file_read past the end of file may return 0 amount read,
        //which can mislead the amounts, so we work out how much is left if near the end
        var _file_size = _ogg.app.io.module.file_size(_ogg.handle);
        var _file_cur = _ogg.app.io.module.file_tell(_ogg.handle);
        var _read_size = Std.int(Math.min(_file_size-_file_cur, _total));

        var _read_n = _ogg.app.io.module.file_read(_ogg.handle, _buffer, _read_size, 1);
        var _read = (_read_n * _read_size);

        // trace('ogg_read cur:$_file_cur, fs:$_file_size, rs:$_read_size, size:$size, nmemb:$nmemb, read amount:$_read');

        _bytes = null;

        return _read;

    } //ogg_read

        //seek function for ogg callbacks
    static function ogg_seek(_ogg:AudioInfoOGG, offset:Int, whence:OggWhence):Void {

        // trace('ogg_seek offset:$offset whence:$whence');

        var _w:FileSeek = switch(whence) {
            case OGG_SEEK_CUR: cur;
            case OGG_SEEK_END: end;
            case OGG_SEEK_SET: set;
        }

        _ogg.app.io.module.file_seek(_ogg.handle, offset, _w);

    } //ogg_seek

        //tell function for ogg callbacks
    static function ogg_tell(_ogg:AudioInfoOGG):Int {

        var res = _ogg.app.io.module.file_tell(_ogg.handle);

        // trace('ogg_tell tell:$res');

        return res;

    } //ogg_tell


} //OGG
