package snow.types;

/** The runtime application config info */
import snow.types.Types.RuntimeConfig;
import snow.types.Types.UserConfig;

typedef AppConfig = {
    /** The window config for the default window. default: see `WindowConfig` docs*/
    @:optional var window: WindowConfig;

    /** The render config that specifies rendering and context backend specifics.  */
    @:optional var render: RenderConfig;

    /** The user specific config, by default, read from a json file at runtime */
    @:optional var user: UserConfig;

    /** The runtime specific config */
    @:optional var runtime: RuntimeConfig;
}
