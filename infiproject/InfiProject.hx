package infiproject;

import flixel.FlxState;

class InfiProject 
{
    // this is setted in `initialize`
    public static var defaultState:FlxState;

    public static var defaultWidth:Int = 1280;
    public static var defaultHeight:Int = 720;

    public static var defaultFPS:Int = 60;

    public static var startFullscreen:Bool = false;

    public static var importantFiles:Array<String> = [];

    public static function initialize(state:FlxState)
    {
        defaultState = state;
    }
}
