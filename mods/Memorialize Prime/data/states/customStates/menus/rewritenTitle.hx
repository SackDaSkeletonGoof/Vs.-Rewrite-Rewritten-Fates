import funkin.backend.system.framerate.Framerate;
var canDoShit:Bool = true;
Framerate.fpsCounter.visible = false;
Framerate.memoryCounter.visible = false;
Framerate.codenameBuildField.visible = false;

function new() CoolUtil.playMenuSong();

static var initialized:Bool = false;

var blackScreen:FlxSprite;
var logoBl:FlxSprite;
var ngSpr:FlxSprite;
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


			FlxG.sound.playMusic(Paths.music('hills'), 0);

			FlxG.sound.music.fadeIn(5, 0, 0.7);
		}

		Conductor.changeBPM(60);
		persistentUpdate = true;
	}


function create(){
    window.title = "Vs. Rewrite: Rewriten Fates";
new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});
}
var transitioning:Bool = false;
function update(elapsed:Float)
	{
    } 