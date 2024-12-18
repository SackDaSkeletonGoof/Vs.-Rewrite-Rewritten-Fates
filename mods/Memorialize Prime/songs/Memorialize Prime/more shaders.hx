import openfl.filters.ShaderFilter;
import funkin.backend.utils.ShaderResizeFix;

//this is the shader variable list.
var lq = new CustomShader("lowquality");
var vhs = new CustomShader("hotlineVHS");
var filter = new ShaderFilter(vhs);
var filter2 = new ShaderFilter(lq);

function create(){
    //creates the shader thingies for the thing to work. amazing explanation ik.
    if (FlxG.game._filters == null)
        FlxG.game._filters = [];
    FlxG.game._filters = [filter];
    vhs.hset("iTime", 0);
}

var time:Float = 0;
function update(elapsed:Float){
    vhs.hset("iTime", time += elapsed);
}

function destroy(){
    FlxG.game._filters = [];
}