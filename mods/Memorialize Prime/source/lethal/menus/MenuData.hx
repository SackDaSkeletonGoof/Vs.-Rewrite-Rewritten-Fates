// workaround stupid but works
class MenuData extends flixel.FlxBasic {
    public var data:{title:String, letterMin:Int, options:Array<{text:String, callback:Void->Void}>} = null;
    public var parent:MenuData = null;

    public function new() {}
}