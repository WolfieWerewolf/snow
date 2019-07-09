package snow.types;

@:enum abstract SystemEventType(Int)
    from Int to Int {

    /** An unknown system event */
    var se_unknown = 0;

    /** An system init event */
    var se_init = 1;

    /** An system ready event */
    var se_ready = 2;

    /** An system tick event */
    var se_tick = 3;

    /** An system freeze event */
    var se_freeze = 4;

    /** An system unfreeze event */
    var se_unfreeze = 5;

    /** An system pause event */
    var se_suspend = 6;

    /** An system shutdown event */
    var se_shutdown = 7;

    /** An system window event */
    var se_window = 8;

    /** An system input event */
    var se_input = 9;

    /**snow application events */

    /** An system quit event. Initiated by user, can be cancelled/ignored */
    var se_quit = 10;

    /** An system terminating event, called by the OS (mobile specific) */
    var se_app_terminating = 11;

    /** An system low memory event, clear memory if you can. Called by the OS (mobile specific) */
    var se_app_lowmemory = 12;

    /** An event for just before the app enters the background, called by the OS (mobile specific) */
    var se_app_willenterbackground = 13;

    /** An event for when the app enters the background, called by the OS (mobile specific) */
    var se_app_didenterbackground = 14;

    /** An event for just before the app enters the foreground, called by the OS (mobile specific) */
    var se_app_willenterforeground = 15;

    /** An event for when the app enters the foreground, called by the OS (mobile specific) */
    var se_app_didenterforeground = 16;

    inline function toString() {
        return switch(this) {
            case se_unknown:                    'se_unknown';
            case se_init:                       'se_init';
            case se_ready:                      'se_ready';
            case se_tick:                       'se_tick';
            case se_freeze:                     'se_freeze';
            case se_unfreeze:                   'se_unfreeze';
            case se_shutdown:                   'se_shutdown';
            case se_window:                     'se_window';
            case se_input:                      'se_input';
            case se_quit:                       'se_quit';
            case se_app_terminating:            'se_app_terminating';
            case se_app_lowmemory:              'se_app_lowmemory';
            case se_app_willenterbackground:    'se_app_willenterbackground';
            case se_app_didenterbackground:     'se_app_didenterbackground';
            case se_app_willenterforeground:    'se_app_willenterforeground';
            case se_app_didenterforeground:     'se_app_didenterforeground';
            case _:                             '$this';
        }
    }
}