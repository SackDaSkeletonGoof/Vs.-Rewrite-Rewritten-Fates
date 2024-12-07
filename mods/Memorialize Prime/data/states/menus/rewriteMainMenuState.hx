import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import funkin.menus.ModSwitchMenu;
import funkin.menus.credits.CreditsMain;
import flixel.effects.FlxFlicker;

	
var hoveringOption:Array<String> = [0,0];
var menuOptions:FlxTypedGroup<FlxSprite>;
var optionList:Array<String> = ["story_mode_text","options_text","freeplay_text","credits_text"];

var camFollow:FlxObject;
var bgRewrite:FlxSprite;

var canMove:Bool = false;

FlxG.resizeGame(640, 480);
FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

function create()
{
	importScript("data/scripts/cool VHS");

	FlxG.sound.playMusic(Paths.music('untitled'),1);
	somethingSelected = false;

	bgRewrite = new FlxSprite(0,-480).loadGraphic(Paths.image('menus/mainmenu/alt_thing'));
	bgRewrite.alpha = 0;
	bgRewrite.scale.set(0.9,1);
	bgRewrite.scrollFactor.set();
	bgRewrite.screenCenter(FlxAxes.X);
	bgRewrite.antialiasing = true;
	add(bgRewrite);

	menuOptions = new FlxTypedGroup();
	add(menuOptions);

	for (i=>option in optionList)
	{
		var menuItem:FlxSprite;
		menuItem = new FlxSprite(0,0).loadGraphic(Paths.image('menus/mainmenu/' + option));
		menuItem.ID = i;
		menuOptions.add(menuItem);
		menuItem.scale.set(0.25,0.25);
		menuItem.alpha = 0;
		menuItem.scrollFactor.set();
		menuItem.antialiasing = true;
	}

	menuOptions.members[0].setPosition(-820, -420); menuOptions.members[1].setPosition(-450, -420);
	menuOptions.members[2].setPosition(-820, -260); menuOptions.members[3].setPosition(-450, -260);

	FlxG.camera.follow(camFollow, null, 0.06);

	new FlxTimer().start(3, function(tmr:FlxTimer) {
		FlxTween.tween(bgRewrite, {alpha: 1}, 1.5);
		FlxTween.tween(bgRewrite, {y: 10}, 5.3, {ease: FlxEase.sineOut, onComplete: function() {
				FlxTween.tween(menuOptions.members[0], {alpha: 1}, 1.5);
				FlxTween.tween(menuOptions.members[1], {alpha: 1}, 1.5);
				FlxTween.tween(menuOptions.members[2], {alpha: 1}, 1.5);
				FlxTween.tween(menuOptions.members[3], {alpha: 1}, 1.5, {ease: FlxEase.linear, onComplete: function()
					{
						changeItem();
						canMove = true;
					}
				});
			}
		});
	});
}

var somethingSelected:Bool = false;
var time:Float = 0;

function update(elapsed:Float) {
	if (canMove == false){
		if (controls.ACCEPT){
			menuOptions.members[0].alpha = 1; menuOptions.members[2].alpha = 1;
			menuOptions.members[1].alpha = 1; menuOptions.members[3].alpha = 1;
			changeItem();
				
			FlxTween.cancelTweensOf(bgRewrite);
			bgRewrite.alpha = 1;
			bgRewrite.y = 10;

			new FlxTimer().start(0.5, function(tmr:FlxTimer)
			{
				canMove = true;
			});
		}
	}

	if (!somethingSelected && canMove == true) {
		if (FlxG.keys.justPressed.ESCAPE) FlxG.switchState(new TitleState());
		if (FlxG.keys.justPressed.EIGHT) FlxG.switchState(new MainMenuState());
		if (FlxG.keys.justPressed.SEVEN) openSubState(new EditorPicker());

		if (controls.LEFT_P){
			hoveringOption[0] = hoveringOption[0] - 1;
			changeItem();
		}

		if (controls.RIGHT_P){
			hoveringOption[0] = hoveringOption[0] + 1;
			changeItem();
		}

		if (controls.UP_P){
			hoveringOption[1] = hoveringOption[1] - 1;
			changeItem();
		}

		if (controls.DOWN_P){
			hoveringOption[1] = hoveringOption[1] - 1;
			changeItem();
		}

		#if MOD_SUPPORT
		if (controls.SWITCHMOD) {
			openSubState(new ModSwitchMenu());
			persistentUpdate = false;
			persistentDraw = true;
		}
		#end

		if (controls.ACCEPT){
			selectItem();
		}
	}
}

function changeItem() {

	if (hoveringOption[0] == 2) hoveringOption[0] = 0;
	if (hoveringOption[0] == -1) hoveringOption[0] = 1;
	if (hoveringOption[1] == 2) hoveringOption[1] = 0;
	if (hoveringOption[1] == -1) hoveringOption[1] = 1;

	FlxG.sound.play(Paths.sound('menu/scroll'));

	if (hoveringOption[0] == 0 && hoveringOption[1] == 0){
		menuOptions.members[0].loadGraphic(Paths.image('menus/mainmenu/selected_' + optionList[0]));
	} else { 
		menuOptions.members[0].loadGraphic(Paths.image('menus/mainmenu/' + optionList[0]));
	}

	if (hoveringOption[0] == 0 && hoveringOption[1] == 1){
		menuOptions.members[2].loadGraphic(Paths.image('menus/mainmenu/selected_' + optionList[2]));
	} else { 
		menuOptions.members[2].loadGraphic(Paths.image('menus/mainmenu/' + optionList[2]));
	}

	if (hoveringOption[0] == 1 && hoveringOption[1] == 0){
		menuOptions.members[1].loadGraphic(Paths.image('menus/mainmenu/selected_' + optionList[1]));	
	} else { 
		menuOptions.members[1].loadGraphic(Paths.image('menus/mainmenu/' + optionList[1]));
	}

	if (hoveringOption[0] == 1 && hoveringOption[1] == 1){
		menuOptions.members[3].loadGraphic(Paths.image('menus/mainmenu/selected_' + optionList[3]));
	} else { 
		menuOptions.members[3].loadGraphic(Paths.image('menus/mainmenu/' + optionList[3]));
	}
}

function selectItem() {
	somethingSelected = true;
	FlxG.sound.play(Paths.sound('menu/confirm'));

	if (hoveringOption[0] == 0 && hoveringOption[1] == 0) FlxFlicker.flicker(menuOptions.members[0], 1.1, 0.05, false);
	if (hoveringOption[0] == 1 && hoveringOption[1] == 0) FlxFlicker.flicker(menuOptions.members[1], 1.1, 0.05, false);
	if (hoveringOption[0] == 0 && hoveringOption[1] == 1) FlxFlicker.flicker(menuOptions.members[2], 1.1, 0.05, false);
	if (hoveringOption[0] == 1 && hoveringOption[1] == 1) FlxFlicker.flicker(menuOptions.members[3], 1.1, 0.05, false);
	
	new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			if (hoveringOption[0] == 0 && hoveringOption[1] == 0) FlxG.switchState(new ModState("menus/primeStory"));
			if (hoveringOption[0] == 1 && hoveringOption[1] == 0) FlxG.switchState(new OptionsMenu());
			if (hoveringOption[0] == 0 && hoveringOption[1] == 1) FlxG.switchState(new ModState("customStates/menus/rewritenFree"));
			if (hoveringOption[0] == 1 && hoveringOption[1] == 1) FlxG.switchState(new ModState("menus/credits"));
	});
}
	