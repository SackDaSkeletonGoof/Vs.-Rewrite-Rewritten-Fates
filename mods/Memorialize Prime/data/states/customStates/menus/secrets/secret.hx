function create(){
    trace("if any one sees this. dw bout it, i was just messing around with the mod");
}

function update(){
    if(FlxG.keys.justPressed.ESCAPE){
        FlxG.switchState(new TitleState());
    }
}