package snow.core.native;

import snow.api.Debug.*;
import snow.types.Types;
import snow.types.OS;
import snow.types.Platform;

#if (hxcpp_static_std && cpp && !scriptable)
//These use hxcpp magic to
//import the std/zlib/regex modules

import hxcpp.StaticRegexp;
import hxcpp.StaticStd;
import hxcpp.StaticZlib;
#end

@:allow(snow.Snow)
class Runtime implements snow.core.Runtime {
    public var name: String = 'native';
    public var app: snow.Snow;

    function new(_app:snow.Snow) {
        _debug('runtime / native / new');
        app = _app;

        #if tvos     app.os = os_tvos;    app.platform = platform_tvos;    #end
        #if ios      app.os = os_ios;     app.platform = platform_ios;     #end
        #if mac      app.os = os_mac;     app.platform = platform_mac;     #end
        #if linux    app.os = os_linux;   app.platform = platform_linux;   #end
        #if android  app.os = os_android; app.platform = platform_android; #end
        #if windows  app.os = os_windows; app.platform = platform_windows; #end

        /** ensure the correct running path */
        var _app_path = app.io.app_path();

        _debug('init / app path / `$_app_path`');
        _debug('init / pref path / `${app.io.app_path_prefs()}`');

        if(_app_path != null && _app_path != '') {
            Sys.setCwd( _app_path );
        } else {
            _debug('init / app path / no change (app path was `$_app_path`)');
        }
    }

    function run() : Bool {
        _debug('runtime / native / run');
        
        app.dispatch_event(se_tick);

        return true;
    }

    function ready() {
        log('runtime / native / ready');
    }

    function shutdown(?_immediate:Bool=false) {
        log('runtime / native / shutdown / immediate=$_immediate');
    }

    public function window_grab(enable:Bool) : Bool {
        log('runtime / native / window_grab');

        return false;
    }

    public function window_fullscreen(enable:Bool, ?true_fullscreen:Bool=false) : Bool {
        log('runtime / native / window_fullscreen');

        return false;
    }

    public function window_device_pixel_ratio() : Float {
        log('runtime / native / window_device_pixel_ratio');

        return 1.0;
    }

    public function window_width() : Int {
        log('runtime / native / window_width');

        return 0;
    }

    public function window_height() : Int {
        log('runtime / native / window_height');

        return 0;
    }

    inline public static function timestamp() : Float {
        return haxe.Timer.stamp();
    }
}

@:noCompletion typedef RuntimeConfig = {}
@:noCompletion typedef WindowHandle = Int