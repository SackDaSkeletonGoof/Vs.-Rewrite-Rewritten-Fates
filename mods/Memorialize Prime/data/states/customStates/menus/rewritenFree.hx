import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;

var textShit:FlxText;
var thing:FlxSprite;


FlxG.resizeGame(640, 480);
FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

function create(){
    importScript("data/scripts/cool VHS");
    FlxG.sound.playMusic(Paths.music('untitled'), 1);
    trace("if any one sees this. dw bout it, i was just messing around with the mod");

    new FlxTimer().start(4.0, () -> goToGame()); 

    var textShit = new FlxText(0, 200, FlxG.width, "Loading, please wait a bit :)", 14, true);
	textShit.setFormat("fonts/sonic.ttf", 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
    textShit.y = 100;
	textShit.screenCenter(FlxAxes.X);
	add(textShit);

    thing = new FlxSprite();
	thing.loadGraphic(Paths.image('menus/rewr'));
    thing.scale.x = 0.3;
    thing.scale.y = 0.3;
	thing.screenCenter(FlxAxes.X);
	thing.y = 50;
    thing.scrollFactor.set();
	add(thing);
}

function goToGame(){
    FlxG.switchState(new PlayState());
    PlayState.loadSong("Memorialize Prime", "hard");
}