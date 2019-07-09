package snow.types;

/** A platform identifier string */
@:enum abstract OS(String)
    from String to String {

    var os_unknown = 'unknown';
    var os_windows = 'windows';
    var os_mac     = 'mac';
    var os_linux   = 'linux';
    var os_android = 'android';
    var os_ios     = 'ios';
    var os_tvos    = 'tvos';
}
