var char:Int = 0;
var amogus = 'false';
var sus = 'false';
var baka = 'false';

function update(elapsed:Float) {
    var controls = FlxG.keys.justPressed;
    var pressed = false;

    if (pressed = controls.R)  {
		amogus = true;
    }


    if (amogus == 'true') {
        if (char == 0) pressed = controls.E;
        if (char == 1) pressed = controls.W;
        if (char == 2) pressed = controls.R;
        if (pressed) {
            char++;
        } else {
            if (controls.ANY) {
                char = 0;
            }
        }
        if (char >= 3) {
            PlayState.loadSong("Memorialize Prime", "hard");
			FlxG.switchState(new PlayState());
        }   
    }
}