import funkin.backend.assets.ModsFolder;
import lime.graphics.Image;
import sys.io.File;

static var redirectStates:Map<FlxState, String> = [
    MainMenuState => "menus/rewriteMainMenuState",
];

function preStateSwitch() {
    window.title = "VS Rewrite: Rewritten Files";
    //window.setIcon(Image.fromBytes(File.getBytes('mods/' + ModsFolder.currentModFolder + '/images/icon.png')));

    for (redirectState in redirectStates.keys())
        if (FlxG.game._requestedState is redirectState)
            FlxG.game._requestedState = new ModState(redirectStates.get(redirectState));
}