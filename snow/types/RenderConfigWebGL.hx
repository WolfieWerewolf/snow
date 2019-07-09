package snow.types;

/** Config specific to a WebGL rendering context.
    See: https://www.khronos.org/registry/webgl/specs/latest/1.0/#WEBGLCONTEXTATTRIBUTES */
typedef RenderConfigWebGL = {

    /** The WebGL version to request. default: 1 */
    @:optional var version : Int;

    /** If the value is true, the drawing buffer has an alpha channel for the
        purposes of performing OpenGL destination alpha operations and
        compositing with the page. If the value is false, no alpha buffer is available.
        snow default: false
        webgl default:true */
    @:optional var alpha : Bool;

    /** If the value is true, the drawing buffer has a depth buffer of at least 16 bits.
        If the value is false, no depth buffer is available.
        snow default: uses render config depth flag
        webgl default:true */
    @:optional var depth : Bool;

    /** If the value is true, the drawing buffer has a stencil buffer of at least 8 bits.
        If the value is false, no stencil buffer is available.
        snow default: uses render config stencil flag
        webgl default: false */
    @:optional var stencil : Bool;

    /** If the value is true and the implementation supports antialiasing the drawing buffer
        will perform antialiasing using its choice of technique (multisample/supersample) and quality.
        If the value is false or the implementation does not support
        antialiasing, no antialiasing is performed
        snow default: uses render config antialias flag
        webgl default: true */
    @:optional var antialias : Bool;

    /** If the value is true the page compositor will assume the drawing buffer contains colors with premultiplied alpha.
        If the value is false the page compositor will assume that colors in the drawing buffer are not premultiplied.
        This flag is ignored if the alpha flag is false.
        snow default: false
        webgl default: true */
    @:optional var premultipliedAlpha : Bool;

    /** If false, once the drawing buffer is presented as described in theDrawing Buffer section,
        the contents of the drawing buffer are cleared to their default values. All elements of the
        drawing buffer (color, depth and stencil) are cleared. If the value is true the buffers will
        not be cleared and will preserve their values until cleared or overwritten by the author.
        On some hardware setting the preserveDrawingBuffer flag to true can have significant performance implications.
        snow default: uses webgl default
        webgl default: false */
    @:optional var preserveDrawingBuffer : Bool;

    /** Provides a hint to the implementation suggesting that, if possible, it creates a context
        that optimizes for power consumption over performance. For example, on hardware that has more
        than one GPU, it may be the case that one of them is less powerful but also uses less power.
        An implementation may choose to, and may have to, ignore this hint.
        snow default: uses webgl default
        webgl default: false */
    @:optional var preferLowPowerToHighPerformance : Bool;

    /** If the value is true, context creation will fail if the implementation determines that the
        performance of the created WebGL context would be dramatically lower than that of a native
        application making equivalent OpenGL calls.
        snow default: uses webgl default
        webgl default: false */
    @:optional var failIfMajorPerformanceCaveat : Bool;
}