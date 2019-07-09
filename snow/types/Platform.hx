package snow.types;

/** A platform identifier string */
@:enum abstract Platform(String)
    from String to String {

    var platform_unknown = 'unknown';
    var platform_windows = 'windows';
    var platform_mac     = 'mac';
    var platform_linux   = 'linux';
    var platform_android = 'android';
    var platform_ios     = 'ios';
    var platform_tvos    = 'tvos';
    var platform_web     = 'web';
}
