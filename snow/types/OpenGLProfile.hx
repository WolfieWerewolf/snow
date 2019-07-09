package snow.types;

/** A type of OpenGL context profile to request. see RenderConfigOpenGL for info */
@:enum abstract OpenGLProfile(Int)
    from Int to Int {

    var compatibility = 0;
    var core = 1;
    var gles = 2;

    inline function toString() {
        return switch(this) {
            case compatibility: 'compatibility';
            case core:          'core';
            case gles:          'gles';
            case _:             '$this';
        }
    }
}