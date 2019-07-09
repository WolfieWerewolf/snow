package snow.types;

/** Config specific to an OpenGL rendering context.
    Note that these are hints to the system,
    you must always check the values after initializing
    for what you actually received. The OS/driver decides. */
typedef RenderConfigOpenGL = {

    /** The major OpenGL version to request */
    @:optional var major : Int;

    /** The minor OpenGL version to request */
    @:optional var minor : Int;

    /** The OpenGL context profile to request */
    @:optional var profile : OpenGLProfile;
}