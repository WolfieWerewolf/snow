package snow.types;

/** Config specific to the rendering context that would be used when creating windows */

typedef RenderConfig = {
    /** Request the number of depth bits for the rendering context.
        A value of 0 will not request a depth buffer. default: 0 */
    @:optional var depth: Int;

    /** Request the number of stencil bits for the rendering context.
        A value of 0 will not request a stencil buffer. default: 0 */
    @:optional var stencil: Int;

    /** A value of `0`, `2`, `4`, `8` or other valid system value.
        On WebGL contexts this value is true or false, bigger than 0 being true.
        On native contexts this value sets the MSAA typically.
        default webgl: 1 (enabled)
        default: 0 */
    @:optional var antialiasing: Int;

    /** Request a specific number of red bits for the rendering context.
        Unless you need to change this, don't. default: 8 */
    @:optional var red_bits: Int;

    /** Request a specific number of green bits for the rendering context.
        Unless you need to change this, don't. default: 8 */
    @:optional var green_bits: Int;

    /** Request a specific number of blue bits for the rendering context.
        Unless you need to change this, don't. default: 8 */
    @:optional var blue_bits: Int;

    /** Request a specific number of alpha bits for the rendering context.
        Unless you need to change this, don't. default: 8 */
    @:optional var alpha_bits: Int;

    /** A color value that when creating the window, the window backbuffer will be cleared to.
        A framework above snow can also use this for default clear color if desired.
       The values are specified as 0..1. default: black, 0,0,0,1  */
    @:optional var default_clear : { r:Float, g:Float, b:Float, a:Float };

    /** OpenGL render context specific settings */
    @:optional var opengl : RenderConfigOpenGL;

    /** WebGL render context specific settings */
    @:optional var webgl : RenderConfigWebGL;
}
