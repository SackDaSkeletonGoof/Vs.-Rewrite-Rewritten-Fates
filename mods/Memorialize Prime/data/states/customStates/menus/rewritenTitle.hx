import funkin.backend.system.framerate.Framerate;
var transitioning, canPressEnter:Bool = false;
Framerate.fpsCounter.visible = false;
Framerate.memoryCounter.visible = false;
Framerate.codenameBuildField.visible = false;

function new() CoolUtil.playMenuSong();

static var initialized:Bool = false;

var blackScreen:FlxSprite;
var thing:FlxSprite;
var rewr:FlxSprite;
var code:Int = 0;
var wackyImage:FlxSprite;

var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			FlxG.camera.flash(FlxColor.RED, 2);
			skippedIntro = true;
		}
	}
function startIntro()
	{
		if (!initialized)
		{


			FlxG.sound.playMusic(Paths.music('music/hills'), 0);

			FlxG.sound.music.fadeIn(5, 0, 0.7);
		}

		Conductor.changeBPM(60);
		persistentUpdate = true;

		thing = new FlxSprite();
		thing.loadGraphic(Paths.image('menus/titlepog'));
    	thing.scale.x = 1;
    	thing.scale.y = 1;
		thing.screenCenter(FlxAxes.X);
		thing.y = 100;
    	thing.scrollFactor.set(0.4, 0.4);
    	add(thing);
	}


function create(){
    window.title = "Vs. Rewrite: Rewriten Fates";
new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
}
var transitioning:Bool = false;

var weewoo:Float = 0;
function update(elapsed:Float)
	{
		weewoo += 0.03;

		thing.y += Math.sin(weewoo) * 0.8;
		thing.angle += Math.cos(weewoo) * 0.1;
    }