import funkin.editors.EditorPicker;

var thing:FlxSprite;

function create(){
    trace("ok so, we changed into the main menu, this shit aint good enough");

    importScript("data/scripts/cool VHS");

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

    if (FlxG.keys.justPressed.F){
        FlxG.switchState(new FreeplayState());
    }

    if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		openSubState(new EditorPicker());
	}
}