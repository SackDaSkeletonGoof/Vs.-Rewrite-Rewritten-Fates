import funkin.backend.system.framerate.Framerate;
var transitioning, canPressEnter:Bool = false;
Framerate.fpsCounter.visible = false;
Framerate.memoryCounter.visible = false;
Framerate.codenameBuildField.visible = false;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.MusicBeatState;
import flixel.util.FlxAxes;
import funkin.backend.utils.DiscordUtil;
import flixel.util.FlxTimer;

/* aight so uhhhhhhhh, there is a lot of shitty code in here.
pls fix it if you can because i honestly dont know what im doing

	- sack
*/

function new() CoolUtil.playMenuSong();

static var initialized:Bool = false;

var blackScreen:FlxSprite;
var thing:FlxSprite;
var rewr:FlxSprite;
var textGroup:FlxGroup;
var code:Int = 0;
var wackyImage:FlxSprite;
var titleText:FlxSprite;

var skippedIntro:Bool = false;

	function skipIntro():Void
	{
		if (!skippedIntro)
		{
			remove(ngSpr);
			remove(textGroup);
			remove(blackScreen);
			FlxG.camera.flash(FlxColor.WHITE, 2);
			skippedIntro = true;
			thing.alpha = 1;
			thing.animation.play('no');
		}
	}
	

	function didSkipIntro(){
		if (skippedIntro){
			FlxG.sound.music.stop();
			FlxG.sound.play(Paths.sounds('skip-Intro'), 0);
		}
	}
function startIntro()
	{
		Conductor.changeBPM(125);
		persistentUpdate = true;

		thing = new FlxSprite();
		thing.frames = Paths.getSparrowAtlas('menus/title');
		thing.animation.addByPrefix('no', 'rewrTitle', 24, true);
		thing.scale.set(1.3, 1.3);
		thing.x = 15;
		thing.y = -25;
		thing.updateHitbox();
		thing.alpha = 0;
		thing.cameras = [camera];
		thing.antialiasing = false;
		add(thing);

		if (!initialized)
			CoolUtil.playMenuSong(true);
	}


function create(){

	thing = new FlxSprite();

	trans = new FlxTimer();

	importScript("data/scripts/Pause");
	importScript("data/scripts/cool VHS");

    window.title = "Vs. Rewrite: Rewriten Fates";
new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});

		FlxG.sound.playMusic(Paths.music('RF - title screen'), 1);

		FlxG.sound.music.fadeIn(5, 0, 0.7);

		textGroup = new FlxGroup();

		secret = new FlxTimer();

	if(skippedIntro) return;
	titleText = new FlxSprite(100, 576);
	titleText.frames = Paths.getSparrowAtlas('menus/titlescreen/titleEnter');
	titleText.animation.addByPrefix('idle', "Press Enter to Begin", 24);
	titleText.animation.addByPrefix('press', "ENTER PRESSED", 24);
	titleText.antialiasing = true;
	titleText.animation.play('idle');
	titleText.updateHitbox();
	add(titleText);


	ngSpr = new FlxSprite(0, FlxG.height * 0.52).loadGraphic(Paths.image('menus/titlescreen/newgrounds_logo'));
	add(ngSpr);
	ngSpr.visible = false;
	ngSpr.setGraphicSize(Std.int(ngSpr.width * 0.8));
	ngSpr.updateHitbox();
	ngSpr.screenCenter(FlxAxes.X);
	ngSpr.antialiasing = true;

	if(skippedIntro) return;
	blackScreen = new FlxSprite().makeSolid(FlxG.width, FlxG.height, FlxColor.fromRGB(0,0,0));
	add(blackScreen);
	add(textGroup);
}
var transitioning:Bool = false;

function createCoolText(textArray:Array<String>) {
	for (i => text in textArray) {
		if (text == "" || text == null) continue;
		var textShit = new FlxText(0, (i * 90) + 200, FlxG.width, text, 19, true);
		textShit.setFormat("fonts/NiseSegaSonic.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		textShit.scrollFactor.set();
		textShit.screenCenter(FlxAxes.X);
		textGroup.add(textShit);
	}
}

function addMoreText(text:String) {
	var moretextShit = new FlxText(0, (textGroup.length * 90) + 200, FlxG.width, text, 19, true);
	moretextShit.setFormat("fonts/NiseSegaSonic.ttf", 60, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
	moretextShit.scrollFactor.set();
	moretextShit.screenCenter(FlxAxes.X);
	textGroup.add(moretextShit);
}

function deleteCoolText() {
	while (textGroup.members.length > 0) {
		textGroup.members[0].destroy();
		textGroup.remove(textGroup.members[0], true);
	}
}

var secret:FlxTimer;

var trans:FlxTimer;

var weewoo:Float = 0;
function update(elapsed:Float)
	{
		var pressedEnter:Bool = FlxG.keys.justPressed.ENTER;
		/*weewoo += 0.03;

		thing.y += (Math.sin(weewoo) * 0.8);
		thing.angle += Math.cos(weewoo) * 0.1;
		*/
		if (pressedEnter) {
			if (!skippedIntro)
				skipIntro();
			else if (!transitioning)
				pressEnter();
		}
/*
		if (pressedEnter && skippedIntro){
			didSkipIntro();
		} else if (thing.visible == true && pressedEnter){
			pressEnter();
			trans.cancel();
			trans.start(2, () -> {FlxG.switchState(new MainMenuState()); FlxG.sound.music.stop();});
		}*/
		

		if (FlxG.keys.justPressed.X == true){
			secret.start(4.0, () -> {
				Conductor.changeBPM(0);
				FlxG.sound.music.stop();
				deleteCoolText();
				FlxG.sound.play(Paths.sound('menu/secrets/codes'), 0.5); 
				new FlxTimer().start(4.0, () -> FlxG.switchState(new ModState("customStates/menus/secrets/secret"))); 
				trace("we pressing X alright");});

		} else if (FlxG.keys.justReleased.X == true){
			secret.cancel();
			trace("oh shit, we no longer pressing X");
		}
    }

	function pressEnter() {
		titleText.animation.play('press',true);
	
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.play(Paths.sound('menu/sonicConfirm'), 1);
	
		transitioning = true;
		trans.start(2.0, () -> {FlxG.switchState(new MainMenuState()); FlxG.sound.music.stop();});
	}

	function getIntroTextShit():Array<Array<String>> {
		var fullText:String = Assets.getText(Paths.txt('titlescreen/introText'));
	
		var firstArray:Array<String> = fullText.split('\n');
		var swagGoodArray:Array<Array<String>> = [];
	
		for (i in firstArray)
			swagGoodArray.push(i.split('--'));
		return swagGoodArray;
	}

	function beatHit(curBeat:Int) {
	
		FlxTween.tween(FlxG.camera, {zoom: 1.10}, 0.5, {ease: FlxEase.quadOut, type: FlxTween.BACKWARD});
	
		if(skippedIntro) return;
		switch (curBeat)
		{
			case 1: createCoolText(["Rewriten Fates Team"]);
			case 2: addMoreText('Present');
			case 3: deleteCoolText();
			case 5: createCoolText(['In not association', 'with'], -40);
			case 6: addMoreText('Nominal Dingus and Newgrounds', -40);
			case 7: deleteCoolText();
			case 8: createCoolText(["I AM IN SO MUCH PAIN"]);
			case 9: addMoreText("'Sack while coding this'");
			case 10: deleteCoolText();
			case 11: createCoolText(["pls send help"]);
			case 15: deleteCoolText();
			case 16: addMoreText("FNF'"); addMoreText('Vs Rewrite:');
			case 17: addMoreText('Rewriten Fates'); // Hawaii Part II reference? -EstoyAburridow
			case 18: deleteCoolText(); skipIntro();
		}
	}