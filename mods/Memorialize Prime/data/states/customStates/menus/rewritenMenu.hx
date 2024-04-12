import funkin.editors.EditorPicker;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;

var thing:FlxSprite;

function create(){
    trace("ok so, we changed into the main menu, this shit aint good enough");

    importScript("data/scripts/cool VHS");

    thing = new FlxSprite();
	thing.loadGraphic(Paths.image('menus/rewr'));
    thing.scale.x = 0.5;
    thing.scale.y = 0.5;
	thing.screenCenter(FlxAxes.X);
	thing.y = 200;
    thing.scrollFactor.set(0, 0);
	add(thing);

    var textShit = new FlxText(0, 200, FlxG.width, "For the time being, please press F to enter Freeplay\n\nInakuro aint doing the thing he said he would do so uhh- yeah :) - Sack", 19, true);
	textShit.setFormat("fonts/sonic.ttf", 30, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
	textShit.screenCenter(FlxAxes.X);
	add(textShit);
}

function update(){
    if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new TitleState());
        }

    if (FlxG.keys.justPressed.F){
        FlxG.switchState(new FreeplayState());
    }

    if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		openSubState(new EditorPicker());
	}
}