import flixel.input.keyboard.FlxKey;
// Define variables to track key state
var isKeyDown:Bool = false;
var keyPressedDuration:Int = 0;
var keyToCheck = FlxKey.X; // Change this to the key you want to check


function Create() {
    // Put initialization code here if needed
    Sys.window.onKeyDown = onKeyDown;
    Sys.window.onKeyUp = onKeyUp;
}

function Update() {

    Sys.timer(1000 / 60, updateLoop);
    // Check if the key is being held for a certain amount of time
    if (isKeyDown) {
        keyPressedDuration++;
        if (keyPressedDuration >= 60) { // 60 frames = 1 second
            // Execute your code here after the key has been held down for 1 second
            trace("Key held down for 1 second");
        }
    } else {
        keyPressedDuration = 0; // Reset the duration if the key is released
    }

    if (isKeyDown){
        trace("AAAAHHHHGAEHGIAEHIGO");
    }

    if (isKeyUp){
        trace("ajgeagjoi");
    }
    
    // Update your game or application logic here
    // This is where you would typically update your game state, handle input, etc.
}

function onKeyDown(key:KeyCode) {
    if (key == keyToCheck) {
        isKeyDown = true;
    }
}

function onKeyUp(key:KeyCode) {
    if (key == keyToCheck) {
        isKeyDown = false;
    }
}

static function main() {
    new Main();
}