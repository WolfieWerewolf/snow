package snow.types;

/** Options for constructing an AudioData instance */
import snow.api.buffers.Uint8Array;
typedef AudioDataOptions = {
    @:optional var id: String;
    @:optional var rate: Int;
    @:optional var length: Int;
    @:optional var channels: Int;
    @:optional var bits_per_sample: Int;
    @:optional var format: AudioFormatType;
    @:optional var samples: Uint8Array;
    @:optional var is_stream: Bool;
}
