package snow.core;

import snow.types.SystemEvent;

@:allow(snow.Snow)
interface Extension {
    private function onevent(event:SystemEvent) : Void;
}