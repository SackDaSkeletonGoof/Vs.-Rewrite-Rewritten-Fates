import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;

var textShit:FlxText;
var thing:FlxSprite;


FlxG.resizeGame(640, 480);
FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

balls = 100;

function create(){
    importScript("data/scripts/cool VHS");
    FlxG.sound.playMusic(Paths.music('untitled'), 1);
    trace("if any one sees this. dw bout it, i was just messing around with the mod");

    var textShit = new FlxText(0, 200, FlxG.width, "Credits Gonna be cool once V1 comes out\n Shit made by a bunch of dumbasses.\n\n
    Thanks For playing - \nSack The Skeleton goof,\n Rewrite Prime's Co-Owner", 14, true);
	textShit.setFormat("fonts/Century.ttf", 20, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
    textShit.y = balls;
	textShit.screenCenter(FlxAxes.X);
	add(textShit);
}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new MainMenuState());
    }
}