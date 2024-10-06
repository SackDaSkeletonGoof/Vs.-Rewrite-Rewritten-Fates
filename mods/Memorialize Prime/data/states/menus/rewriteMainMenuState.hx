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

	var shader = new CustomShader('vhsBuffer');
	var shader2 = new CustomShader('vhsBuffer2'); var shader3 = new CustomShader('vhs');

	function create()
	{
		FlxG.sound.playMusic(Paths.music(null),1);
		somethingSelected = false;

		menuOptions = new FlxTypedGroup();
		add(menuOptions);

		//y=150
		bgRewrite = new FlxSprite(0,-480).loadGraphic(Paths.image('menus/mainmenu/alt_thing'));
		add(bgRewrite);
		bgRewrite.alpha = 0;
		bgRewrite.scale.set(1.4,1.5);
		bgRewrite.scrollFactor.set();
		bgRewrite.screenCenter(FlxAxes.X);
		bgRewrite.antialiasing = true;

		for (i=>option in optionList)
		{
			var menuItem:FlxSprite;
			menuItem = new FlxSprite(0,0).loadGraphic(Paths.image('menus/mainmenu/' + option));
			menuItem.ID = i;
			menuOptions.add(menuItem);
			menuItem.scale.set(0.4,0.4);
			menuItem.alpha = 0;
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		menuOptions.members[0].setPosition(-700, -350); menuOptions.members[1].setPosition(70, -350);
		menuOptions.members[2].setPosition(-700, -130); menuOptions.members[3].setPosition(70, -130);

		FlxG.camera.follow(camFollow, null, 0.06);

		//FlxG.camera.addShader(shader); FlxG.camera.addShader(shader2); FlxG.camera.addShader(shader3);

		new FlxTimer().start(3, function(tmr:FlxTimer)
		{
			FlxTween.tween(bgRewrite, {alpha: 1}, 1.5);
			FlxTween.tween(bgRewrite, {y: 150}, 5.3, {ease: FlxEase.sineOut, onComplete: function()
				{
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

	function update(elapsed:Float)
	{
		if (canMove == false){
			if (controls.ACCEPT){
				menuOptions.members[0].alpha = 1; menuOptions.members[2].alpha = 1;
				menuOptions.members[1].alpha = 1; menuOptions.members[3].alpha = 1;
				changeItem();
				
				bgRewrite.alpha = 1;
				bgRewrite.y = 150;

				new FlxTimer().start(0.5, function(tmr:FlxTimer)
				{
					canMove = true;
				});
			}

			if (controls.BACK){
				FlxG.switchState(new TitleState());
			}
		}

		if (!somethingSelected && canMove == true)
		{
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

			if (controls.BACK){
				FlxG.switchState(new TitleState());
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

		shader.iTime = elapsed;
		shader2.iTime = elapsed;
		shader3.iTime = elapsed;
	}

	function changeItem()
	{
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
				if (hoveringOption[0] == 0 && hoveringOption[1] == 0) FlxG.switchState(new StoryMenuState());
				if (hoveringOption[0] == 1 && hoveringOption[1] == 0) FlxG.switchState(new OptionsMenu());
				if (hoveringOption[0] == 0 && hoveringOption[1] == 1) FlxG.switchState(new FreeplayState());
				if (hoveringOption[0] == 1 && hoveringOption[1] == 1) FlxG.switchState(new CreditsMain());
			});
	}
	