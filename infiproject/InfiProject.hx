package infiproject;

import flixel.FlxState;

class InfiProject 
{
    public static var defaultState:FlxState;

    public static var defaultWidth:Int = 1280;
    public static var defaultHeight:Int = 720;

    public static var defaultFPS:Int = 60;

    public static var startFullscreen:Bool = false;

    public static var importantFiles:Array<String> = [];

	public static function initialize(width:Int = 1280, height = 720, fps = 60, fullscreen = false, state:FlxState)
    {
        defaultState = state;
		defaultWidth = width;
		defaultHeight = height;
		defaultFPS = fps;
		startFullscreen = fullscreen;
    }
}
