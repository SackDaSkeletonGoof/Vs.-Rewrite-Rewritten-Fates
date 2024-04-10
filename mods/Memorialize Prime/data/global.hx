import funkin.backend.utils.NativeAPI;
import funkin.backend.utils.ShaderResizeFix;
import funkin.backend.system.Main;

function update(elapsed) {
    if (FlxG.keys.justPressed.F6)
        NativeAPI.allocConsole();
    if (FlxG.keys.justPressed.F5)
        FlxG.resetState();
}

static var initialized:Bool = false;

function preStateSwitch() {
    FlxG.camera.bgColor = 0xFF000000;

	if (!initialized){
		initialized = true;
		FlxG.game._requestedState = new ModState('customStates/WarningState');
    }else 
    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}



static var redirectStates:Map<FlxState, String> = [
    TitleState => "customStates/menus/rewritenTitle",
    MainMenuState => "customStates/menus/rewritenMenu",
];