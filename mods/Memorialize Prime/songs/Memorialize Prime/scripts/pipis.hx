var curWinX = window.x;
var curWinY = window.y;

function update(){
    if (dad.animation.curAnim.name == "idle" || dad.animation.curAnim.name == "idle-alt"){
        window.x = FlxMath.lerp(window.x, curWinX, .2);
        window.y = FlxMath.lerp(window.y, curWinY, .2);
    }
}

function onDadHit(e){
    switch(e.direction){
        case 0:
            window.x = FlxMath.lerp(window.x, curWinX - 20, .2);
            window.y = FlxMath.lerp(window.y, curWinY, .2);
        case 1:
            window.x = FlxMath.lerp(window.x, curWinX, .2);
            window.y = FlxMath.lerp(window.y, curWinY + 20, .2);
        case 2:
            window.x = FlxMath.lerp(window.x, curWinX, .2);
            window.y = FlxMath.lerp(window.y, curWinY - 20, .2);
        case 3:
            window.x = FlxMath.lerp(window.x, curWinX + 20, .2);
            window.y = FlxMath.lerp(window.y, curWinY, .2);
    }
}

function destroy(){
    window.x = curWinX;
    window.y = curWinY;
}

//all dat up there is so the window moves when the bozo you fighting hits a note.

//if anyone is able too and somehow nominal got someone to help with this, please make the code better if possible.
//all code by Sack The Skeleton goof, help to make it work was given by the CNE discord server.