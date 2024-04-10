var bleck:FlxSprite;
var text:FlxText;

function onCountdown(event:CountdownEvent) event.cancelled = true;

function create(){
    black();
}

function black(){
    bleck = new FlxSprite();
    bleck.makeGraphic(1080 * 2, 1920 * 2, 0xFF000000);
    bleck.cameras = camGame;
    bleck.offset.set(500, 500);
    bleck.scrollFactor.set(0, 0);
    add(bleck);
    trace("yeah its dark here");
}

function update(){
    if (FlxG.keys.pressed.SIX){
        playerStrums.cpu = true;
        trace("SKILL ISSUE-");
    }
    if (FlxG.keys.pressed.FIVE){
        playerStrums.cpu = false;
        trace("oh, guess thats done");
    }
}

function fadeBlack(shit:Float, time:Float){
    FlxTween.tween(bleck, {alpha:shit}, time);
}


function fadeIcon(fuck:Float, time:Float){
    FlxTween.tween(iconP2, {alpha:fuck}, time);
}