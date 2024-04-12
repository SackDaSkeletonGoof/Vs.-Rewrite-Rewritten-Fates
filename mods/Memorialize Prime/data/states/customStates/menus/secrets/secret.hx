import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;

var textShit:FlxText;
var thing:FlxSprite;

function create(){
    importScript("data/scripts/cool VHS");
    trace("if any one sees this. dw bout it, i was just messing around with the mod");

    var textShit = new FlxText(0, 200, FlxG.width, "there is nothing here.\n\nPress ESC to get back to the title screen :)", 19, true);
	textShit.setFormat("fonts/sonic.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
	textShit.screenCenter(FlxAxes.X);
	add(textShit);

    thing = new FlxSprite();
	thing.loadGraphic(Paths.image('menus/rewr'));
    thing.scale.x = 0.5;
    thing.scale.y = 0.5;
	thing.screenCenter(FlxAxes.X);
	thing.y = 200;
    thing.scrollFactor.set();
	add(thing);
}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new TitleState());
    }
}