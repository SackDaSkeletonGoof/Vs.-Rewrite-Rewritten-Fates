import lime.app.Application;
import lime.graphics.Image;
import funkin.backend.system.framerate.Framerate;

var sega:FlxTimer;

var bleck:FlxSprite;

var logo:FlxSprite;

Framerate.fpsCounter.visible = true;
Framerate.memoryCounter.visible = true;
Framerate.codenameBuildField.visible = false;


FlxG.resizeGame(640, 480);
FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

function create(){
    sega = new FlxTimer();
    importScript("data/scripts/cool VHS");
    window.title = "Vs. Rewrite: Rewriten Fates - starting up, sit tight!";
    bleck = new FlxSprite();
    bleck.makeSolid(1080 * 10, 1920 * 10, 0xFFFFFFFF);
    bleck.offset.set(0, 0);
    bleck.scrollFactor.set(0, 0);
    add(bleck);

    logo = new FlxSprite().loadGraphic(Paths.image('startup/sega'));
    logo.antialiasing = false;
    logo.alpha = 1;
    logo.screenCenter(FlxAxes.X);
    logo.screenCenter(FlxAxes.Y);
    add(logo);

    sega.start(1.0, () -> {FlxG.sound.play(Paths.sound('startUp'), 1); new FlxTimer().start(3.0, () -> FlxG.switchState(new ModState("customStates/menus/rewritenTitle")));});
}