import flixel.text.FlxText;
import flixel.util.FlxColor;

function create(){
    trace("if any one sees this. dw bout it, i was just messing around with the mod");

    var g = new FlxText(0, 200, FlxG.width, "there is nothing here.", 19, true);
	textShit.setFormat("fonts/sonic.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	textShit.scrollFactor.set();
	textShit.screenCenter(FlxAxes.X);
	textGroup.add(textShit);
}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new TitleState());
    }
}