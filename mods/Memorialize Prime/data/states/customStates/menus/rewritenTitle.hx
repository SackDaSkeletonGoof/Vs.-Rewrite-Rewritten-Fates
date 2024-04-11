import funkin.backend.system.framerate.Framerate;
var transitioning, canPressEnter:Bool = false;
Framerate.fpsCounter.visible = false;
Framerate.memoryCounter.visible = false;
Framerate.codenameBuildField.visible = false;
import flixel.text.FlxTextBorderStyle;
import funkin.backend.MusicBeatState;
import flixel.util.FlxAxes;
import funkin.backend.utils.DiscordUtil;

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
		}
	}
function startIntro()
	{
		Conductor.changeBPM(60);
		persistentUpdate = true;

		thing = new FlxSprite();
		thing.loadGraphic(Paths.image('menus/titlepog'));
    	thing.scale.x = 1;
    	thing.scale.y = 1;
		thing.screenCenter(FlxAxes.X);
		thing.y = 100;
		thing.alpha = 0;
		thing.cameras = [camera];
    	thing.scrollFactor.set(0, 0);
    	add(thing);
	}


function create(){
    window.title = "Vs. Rewrite: Rewriten Fates";
new FlxTimer().start(1, function(tmr:FlxTimer)
		{
			startIntro();
		});

		FlxG.sound.playMusic(Paths.music('hills'), 0);

		FlxG.sound.music.fadeIn(5, 0, 0.7);

		textGroup = new FlxGroup();

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
    }

	function pressEnter() {
		titleText.animation.play('press',true);
	
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.play(Paths.sound('menu/confirm'), 1);
	
		transitioning = true;
		// FlxG.sound.music.stop();
		new FlxTimer().start(2.0, () -> FlxG.switchState(new MainMenuState()));
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
	
		FlxTween.tween(FlxG.camera, {zoom: 1.04}, 0.7, {ease: FlxEase.quadOut, type: FlxTween.BACKWARD});
	
		if(skippedIntro) return;
		switch (curBeat)
		{
			case 2: createCoolText(["FNF' Gorefield Team"]);
			case 4: addMoreText('Present');
			case 5: deleteCoolText();
			case 6: createCoolText(['In not association', 'with'], -40);
			case 8: addMoreText('newgrounds', -40); ngSpr.visible = true;
			case 9: deleteCoolText(); ngSpr.visible = false;
			case 10: createCoolText(["Dathree was here"]);
			case 12: addMoreText("'Dathree'");
			case 13: deleteCoolText();
			case 14: createCoolText(["number one small arctic fox"]);
			case 15: addMoreText("'Lean'");
			case 16: deleteCoolText();
			case 17: createCoolText(["Gorefield for you BB"]);
			case 18: addMoreText("'Nex_s'");
			case 19: deleteCoolText();
			case 20: createCoolText(["Jon I require enchiladas"]);
			case 21: addMoreText("'Bitfox'");
			case 22: deleteCoolText();
			case 23: createCoolText(["Fifa 24"]);
			case 24: addMoreText("'Jloor'");
			case 25: deleteCoolText();
			case 26: createCoolText(["JLoorcito fiu fiu"]);
			case 27: addMoreText("'Zero'");
			case 28: deleteCoolText();
			case 29: createCoolText(["the worst fnf mod"]);
			case 30: addMoreText("'Keneth'");
			case 31: deleteCoolText();
			case 32: addMoreText("FNF'");
			case 33: addMoreText('Vs Gorefield');
			case 34: addMoreText('Part II'); // Hawaii Part II reference? -EstoyAburridow
			case 35:
				if(!FlxG.random.bool(10)) return;
				deleteCoolText();
				wiggleGorefield.visible = true;
			case 36: skipIntro();
		}
	}