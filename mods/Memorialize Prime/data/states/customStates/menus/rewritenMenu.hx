var thing:FlxSprite;

function create(){
    trace("ok so, we changed into the main menu, this shit aint good enough");

    thing = new FlxSprite();
	thing.loadGraphic(Paths.image('menus/rewr'));
    thing.scale.x = 1;
    thing.scale.y = 1;
	thing.screenCenter(FlxAxes.X);
	thing.screenCenter(FlxAxes.Y);
    thing.scrollFactor.set(0, 0);
	add(thing);
}

function update(){
    if (FlxG.keys.justPressed.ESCAPE)
        {
            FlxG.switchState(new TitleState());
        }
}