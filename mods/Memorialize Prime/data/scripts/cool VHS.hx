import openfl.filters.ShaderFilter;
import funkin.backend.utils.ShaderResizeFix;

//this is the shader variable list.
var lq = new CustomShader("lowquality");
var vhs = new CustomShader("hotlineVHS");
var st = new CustomShader("vhsStatic");
var filter = new ShaderFilter(vhs);
var filter2 = new ShaderFilter(lq);
var filter3 = new ShaderFilter(st);

function create(){
    //creates the shader thingies for the thing to work. amazing explanation ik.
    if (FlxG.game._filters == null)
        FlxG.game._filters = [];
    FlxG.game._filters = [filter, filter3, filter2];
    vhs.hset("iTime", 0);
    st.hset("iTime", 0);
}

var time:Float = 0;
function update(elapsed:Float){
    vhs.hset("iTime", time += elapsed);
    st.hset("iTime", time += elapsed);
}

function destroy(){
    FlxG.game._filters = [];
}