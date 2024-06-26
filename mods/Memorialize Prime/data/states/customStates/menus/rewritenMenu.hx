import funkin.editors.EditorPicker;
import funkin.options.OptionsMenu;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.text.FlxTextBorderStyle;
var menuItems:FlxTypedGroup<FlxSprite>;
var menuItems = new FlxTypedGroup();
var optionShit:Array<String> = ['freeplay', 'credits'];
var curSelected:Int = 0;
public var canAccessDebugMenus:Bool = true;
var ring:FlxSprite = new FlxSprite();	
var xval:Int = 200;


FlxG.resizeGame(640, 480);
FlxG.scaleMode.width = 640;
FlxG.scaleMode.height = 480;

function new() CoolUtil.playMenuSong();

function create(){
    FlxG.sound.music.stop();
    trace("ok so, we changed into the main menu, this shit aint good enough");

    importScript("data/scripts/cool VHS");

    add(menuItems);
    for (i in 0...optionShit.length)
    {
    var tex = Paths.getSparrowAtlas('menus/main_menu');   
    var menuItem:FlxSprite = new FlxSprite(xval, -10 + (i * 200));	
    if (i % 2 == 0) menuItem.x -= -20 + i * 40;

    menuItem.frames = tex;
    menuItem.animation.addByPrefix('idle', "main_menu " + optionShit[i], 24);
    menuItem.animation.play('idle');
    menuItem.x = 10;
    menuItem.scale.set(0.5, 0.5);
    menuItem.ID = i;
    menuItems.add(menuItem);
    menuItem.scrollFactor.set();
    menuItem.antialiasing = false;
    }

    ring.frames = Paths.getSparrowAtlas('menus/ring'); 
    ring.animation.addByPrefix('idle', "ring_spin", 24);
    ring.animation.play('idle');
    ring.alpha = 0.001;
    add(ring);
}


function update(){
    
    if (FlxG.keys.justPressed.ESCAPE)
    {
        FlxG.switchState(new TitleState());
    }
    if (controls.UP_P)
    {
        changeItem(-1);
    }

    if (controls.DOWN_P)
    {
        changeItem(1);
    }
    if (FlxG.keys.justPressed.F){
        FlxG.switchState(new FreeplayState());
    }

    if (FlxG.keys.justPressed.SEVEN) {
		persistentUpdate = false;
		openSubState(new EditorPicker());
	}
    if (controls.ACCEPT)
        {

            {
                selectedSomethin = true;
                FlxG.sound.play(Paths.sound('menu/'));
                
                if (FlxG.save.data.flashing)
                    FlxFlicker.flicker(bgdesat, 1.1, 0.15, false);

                menuItems.forEach(function(spr:FlxSprite)
                {
                    if (curSelected != spr.ID)
                    {
                        FlxTween.tween(spr, {alpha: 0}, .3, {
                            ease: FlxEase.expoOut,
                            onComplete: function(twn:FlxTween)
                            {
                                spr.kill();
                            }
                        });
                    }
                    else
                    {
        
                        FlxTween.tween(FlxG.camera, {zoom: 1.1}, 2, {ease: FlxEase.expoOut});
                        if (FlxG.save.data.flashing)
                        {
                            FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
                            {
                                goToState();
                            });	
                        }
                        else
                        {
                            new FlxTimer().start(1, function(tmr:FlxTimer)
                            {
                                goToState();
                            });
                        }
                    }
                });
            }
        }
    }

function changeItem(huh:Int = 0)
	{
		
			curSelected += huh;

			if (curSelected >= menuItems.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = menuItems.length - 1;


		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			if (spr.ID == curSelected )
			{
                ring.y = spr.y + 100;
                ring.alpha = 1;
			}

			//spr.updateHitbox();
		});
	}

function goToState()
	{
		var daChoice:String = optionShit[curSelected];
		switch (daChoice)
		{
			case 'freeplay':
				goToGame();

			case 'credits':
				FlxG.switchState(new OptionsMenu());
				trace("going to da options");

		}
	}

    function goToGame(){
        FlxG.switchState(new PlayState());
        PlayState.loadSong("Memorialize Prime", "hard");
    }