import funkin.backend.assets.ModsFolder;
import lime.graphics.Image;
import sys.io.File;
import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.system.Main;
import openfl.system.Capabilities;

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

static var initialized:Bool = false;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "menus/rewriteMainMenuState",
    TitleState => "customStates/menus/rewritenTitle",
];

function preStateSwitch() {
    window.title = "Vs. Rewrite: Rewriten Fates";

    trace("it be doing something");
    FlxG.camera.bgColor = 0xFF000000;

	if (!initialized){
		initialized = true;
		FlxG.game._requestedState = new ModState("customStates/WarningState");
    }else 
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}