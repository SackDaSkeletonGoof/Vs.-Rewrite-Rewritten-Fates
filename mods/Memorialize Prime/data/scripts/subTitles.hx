import flixel.text.FlxTextBorderStyle;

var sub:FlxText;
function create() {
    sub = new FlxText(0, 19, 400, "", 32);
    sub.setFormat(Paths.font("vcr.ttf"), 42, FlxColor.WHITE, "center", FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
    sub.scrollFactor.set();
    sub.borderColor = 0xFF000000;
    sub.borderSize = 2;
    sub.screenCenter(FlxAxes.X);
    add(sub);
    sub.cameras = [camHUD];
}

function updateText(text:String) {
    sub.scale.x = 1.2;
    sub.scale.y = 1.2;
    sub.text = text;
    FlxTween.tween(sub.scale, {x: 1, y: 1}, 0.2, {ease: FlxEase.circOut});
}
function stepHit(curStep:Int) { //this is all template btw lol so
    switch (curStep) {
        case 145:
            updateText("RAP");
        case 156:
            updateText("BAT");
        case 160:
            updateText("BATTLES");
        case 172:
            updateText("");
        case 210:
            updateText("");
        case 194:
            updateText("TO");
        case 198:
            updateText("TOBY");
        case 203:
            updateText("TOBY\nFOX!");
        case 216:
            updateText("VER");
        case 220:
            updateText("VERSUS");
        case 227:
            updateText("SCOTT");
        case 235:
            updateText("SCOTT\nCAW");
        case 241:
            updateText("SCOTT\nCAWTHON!");
        case 247:
            updateText(" ");
        case 250:
            updateText("BE");
        case 252:
            updateText("BEGIN!");
        case 256:
            updateText(" ");
    }
}