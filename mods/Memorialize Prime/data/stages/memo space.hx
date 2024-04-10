import openfl.filters.ShaderFilter;
import flixel.FlxCamera;


//cameras. quite easy to understand.
var cam1 = null;
var cam2 = null;
var cam3 = null;
var cam4 = null;

//uhhhh thing i use for the cool blinking effect.
var bleck:FlxSprite;
var balls:FlxSprite;
var beb:FlxSprite;

//this is the shader variable list.
var lq = new CustomShader("lowquality");
var vhs = new CustomShader("hotlineVHS");
var tv = new CustomShader("vcr with no glitch");
var trip = new CustomShader("idk");
var filter = new ShaderFilter(vhs);
var filter2 = new ShaderFilter(tv);
var filter3 = new ShaderFilter(lq);

var myArray = ["uuuuuhhhhh", "have you ever did     but then you      so you didnt do     ?", "good thing that there is old code to reuse", "HEY, GO CHECK MY CHANNEL. use the credits thing to do that - Sack", "i have no idea if this will work", "memorialize is a cool song", "there are far too many phrases here.", "guh- *explodes*", "im inside your walls :)"];

var myIndex = Math.floor(Math.random()*myArray.length);

var mySelection = myArray[myIndex];


function onSubstateOpen() window.title = mySelection; trace(mySelection);
function onSubstateClose() window.title = "Now enjoying: " + SONG.meta.name + " By Nominal Dingus";

function create(){
    boyfriend.visible = false;


    //creates the shader thingies for the thing to work. amazing explanation ik.
    if (FlxG.game._filters == null)
        FlxG.game._filters = [];
    FlxG.game._filters = [filter, filter2, filter3];
    vhs.hset("iTime", 0);
    trip.hset("iTime", 0);
    
    
    
    //for any song that you want to have
    //a fade into the game you can do a thing like this.
    black();

    shaderfuk();
    black2();
    camGame.addShader(trip);
    camGame.alpha = 0;
    beb.alpha = 0;

    //creates the cameras so they work.
    FlxG.cameras.add(cam1 = new HudCamera(), false);
    FlxG.cameras.add(cam2 = new HudCamera(), false);
    FlxG.cameras.add(cam3 = new HudCamera(), false);
    FlxG.cameras.add(cam4 = new HudCamera(), false);
    cam1.bgColor = 0;
    cam2.bgColor = 0;
    cam3.bgColor = 0;
    cam4.bgColor = 0;
}


//cancels the countdown.
function onCountdown(event:CountdownEvent) event.cancelled = true;

//the actual thing for the black screen
function black(){
    bleck = new FlxSprite();
    bleck.makeSolid(1080 * 10, 1920 * 10, 0xFF000000);
    bleck.offset.set(0, 0);
    bleck.scrollFactor.set(0, 0);
    add(bleck);
    trace("yeah its dark here"); //this is for debug purposes
}

function shaderfuk(){
    balls = new FlxSprite(220, 100);
    balls.loadGraphic(Paths.image('testing/shade'));
    balls.scale.x = 1;
    balls.scale.y = 1;
    balls.scrollFactor.set(0.4, 0.4);
    add(balls);
}

function black2(){
    beb = new FlxSprite();
    beb.makeSolid(1080 * 5, 1920 * 5, 0xFF000000);
    beb.offset.set(-100, 0);
    beb.scrollFactor.set(0, 0);
    add(beb);
}

//change the camera of the hud elements and other things.
function postCreate() {
    for(s in strumLines.members[0]) {
        s.cameras = [cam2];
    }
    for (s in strumLines.members[1]) {
        s.cameras = [cam2];
    }

    dad.cameras = [cam3];
    bleck.cameras = [cam4];
    beb.cameras = [cam1];

    window.title = "Now enjoying: " + SONG.meta.name + " By Nominal Dingus";
}

var time:Float = 0;
function update(elapsed:Float){
    for (i in [missesTxt, accuracyTxt, scoreTxt, healthBar,healthBarBG, iconP2, iconP1]) i.visible = false;

    vhs.hset("iTime", time += elapsed);
    trip.hset("iTime", time += elapsed);

    //debuging, will be removed after im done with the mod.
    if (FlxG.keys.pressed.SIX){
        player.cpu = true;
        trace("SKILL ISSUE-");
    }
    if (FlxG.keys.pressed.FIVE){
        player.cpu = false;
        trace("oh, guess thats done");
    }

    //for the scroll and zoom to work properly
    cam3.scroll.x = camera.scroll.x;
    cam3.scroll.y = camera.scroll.y;

    cam3.zoom = camGame.zoom;
    cam2.zoom = camHUD.zoom;
    cam1.zoom = camHUD.zoom;
}

//so the shaders dont stay after the songs done and puts you back in the menu
function destroy() {
    FlxG.game._filters = [];
    trace("dingus");
}
//the rest of this functions are really easy to guess what they do.

function fadeBlack(shit:Float, time:Float){
    FlxTween.tween(bleck, {alpha:shit}, time);
}

function blackNow(){
    bleck.alpha = 1;
}

function noBlack(){
    bleck.alpha = 0;
}


function fadeIcon(fuck:Float, time:Float){
    FlxTween.tween(iconP2, {alpha:fuck}, time);
}

function fadeTrip(fuck:Float, time:Float){
    FlxTween.tween(beb, {alpha:fuck}, time);
}

function tripNOW(){
    camGame.alpha = 1;
}

function noTrip(){
    camGame.alpha = 0;
}

function fuk(){
    window.y = FlxG.random.int(window.y - 30, window.y + 30);
    
    window.x = FlxG.random.int(window.x - 30, window.x + 30);

    var v = FlxG.random.int(30,30);
    var h = FlxG.random.int(30,30);
    vhs.iResolution = [v, h];
    FlxG.cameras.shake(0.03, 0.2);
}