package infi_library.assets;

import flixel.FlxG;
import flixel.graphics.FlxGraphic as Graphic;
import openfl.media.Sound;

/**
 * A experimental cache storage.
 * 
 * @author Infinite Doggy
 */
class InfiCache
{
    /**
     * stored up images.
     */
    public var images:Map<String, CacheFile<Graphic>> = [];
    /**
     * stored up sounds.
     */
    public var sounds:Map<String, CacheFile<Sound>> = [];
    /**
     * stored up files.
     * 
     * for my language of for other types of files(as a .xml of a sprite)
     */
    public var files:Map<String, CacheFile<String>> = [];

    private var _list:Array<Map<String, Dynamic>> = [null, null, null];

    public function new()
    {   
        _list[0] = images;
        _list[1] = sounds;
        _list[2] = files;
    }

    /**
     * Stores a file
     * 
     * @param path the path of the file
     * @param data the file data
     * @param keepStored If the file can be kept stored
     */
    public function load<T>(path:String, data:T, keepStored:Bool):Void
    {
        switch Type.getClass(data) 
        {
            case Graphic:
                var graphic:Graphic = cast data;
                graphic.persist = true;
                images.set(path, new CacheFile(graphic, keepStored));
            case Sound:
                var sound:Sound = cast data;
                sounds.set(path, new CacheFile(sound, keepStored));
            case String:
                var file:String = cast data;
                files.set(path, new CacheFile(file, keepStored));
            default:
                throw "wut???";
        };
    }

    /**
     * Reset all files
     * 
     * except the files can be kept stored.
     */
    public function reset():Void
    {
        #if debug
        trace("reseting cache");
        #end

        for (map in _list) 
        {
            for (path => file in map) 
            {
                if (Project.importantFiles.contains(path)) continue;
                @:privateAccess
                {
                    switch Type.getClass(file.data) 
                    {
                        case Graphic:
                            var graphic:Graphic = cast file;
                            FlxG.bitmap.remove(graphic);
                            graphic.persist = false;
                            images.remove(path);
                        case Sound: sounds.remove(path);
                        case String: files.remove(path); 
                    }
                }
            }
        }

        #if debug
        trace("cache reseted");
        #end
    }
}

@:allow(utils.assets.InfiCache)
@:allow(utils.assets.InfiLoad)
private class CacheFile<T>
{
    private var data:T;
    private var keepStored:Bool;

    public function new(data:T, KeepStored:Bool)
    {
        this.data = data;
        keepStored = KeepStored;
    }
}
