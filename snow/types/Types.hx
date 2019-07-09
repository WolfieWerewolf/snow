package snow.types;

    /** These types include further types we don't want to */
    #if !macro
    typedef Asset      = snow.systems.assets.Asset.Asset;
    typedef AssetBytes = snow.systems.assets.Asset.AssetBytes;
    typedef AssetText  = snow.systems.assets.Asset.AssetText;
    typedef AssetJSON  = snow.systems.assets.Asset.AssetJSON;
    typedef AssetImage = snow.systems.assets.Asset.AssetImage;
    typedef AssetAudio = snow.systems.assets.Asset.AssetAudio;
    typedef Key        = snow.systems.input.Keycodes.Keycodes;
    typedef Scan       = snow.systems.input.Keycodes.Scancodes;
    #end

    /** Init bound types */
    private typedef UserConfigInit     = haxe.macro.MacroType<[snow.types.TypeCreate.build("UserConfig")]>;
    private typedef RuntimeConfigInit  = haxe.macro.MacroType<[snow.types.TypeCreate.build("RuntimeConfig")]>;
    private typedef WindowHandleInit   = haxe.macro.MacroType<[snow.types.TypeCreate.build("WindowHandle")]>;
    private typedef AppHostInit        = haxe.macro.MacroType<[snow.types.TypeCreate.build("AppHost")]>;
    private typedef AppRuntimeInit     = haxe.macro.MacroType<[snow.types.TypeCreate.build("AppRuntime")]>;
    private typedef ModuleIOInit       = haxe.macro.MacroType<[snow.types.TypeCreate.build("ModuleIO")]>;
    private typedef ModuleAudioInit    = haxe.macro.MacroType<[snow.types.TypeCreate.build("ModuleAudio")]>;
    private typedef ModuleAssetsInit   = haxe.macro.MacroType<[snow.types.TypeCreate.build("ModuleAssets")]>;
    #if snow_native
    private typedef FileHandleInit = haxe.macro.MacroType<[snow.types.TypeCreate.build("FileHandle")]>; //:todo: snow_native use
    #end

    /** Then define aliases
        Trying to directly alias from the MacroType build call,
        triggers assertions in the compiler with no error message */
    typedef UserConfig      = snow.types.user.UserConfig;
    typedef RuntimeConfig   = snow.types.user.RuntimeConfig;
    typedef WindowHandle    = snow.types.user.WindowHandle;
    typedef AppHost         = snow.types.user.AppHost;
    typedef AppRuntime      = snow.types.user.AppRuntime;
    typedef ModuleIO        = snow.types.user.ModuleIO;
    typedef ModuleAudio     = snow.types.user.ModuleAudio;
    typedef ModuleAssets    = snow.types.user.ModuleAssets;
    #if snow_native
    typedef FileHandle  = snow.types.user.FileHandle;
    #end

    @:build(snow.types.TypeCreate.ext())
    private class ExtensionsInit {}

    /** An audio handle for tracking audio instances */
    typedef AudioHandle = Null<Int>;