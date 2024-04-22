import lime.app.Application;
import lime.graphics.Image;

var sega:FlxTimer;

var bleck:FlxSprite;

var logo:FlxSprite;

function create(){
    importScript("data/scripts/cool VHS");
    sega = new FlxTimer();

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