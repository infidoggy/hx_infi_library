package infiproject.assets;

import flixel.FlxG;
import flixel.graphics.FlxGraphic as Graphic;
import haxe.Json;
import openfl.Assets as OFLAssets;
import openfl.media.Sound;

using StringTools;

class InfiLoad
{
    public var _parent:InfiAssets;
    public function new(parent:InfiAssets)
    {
        _parent = parent;
    }

    /**
     * load a image
     * 
     * @param keepStored if can keep stored up in cache
     * @return Graphic
     */
    public function image(path:String, ?keepStored:Bool = false):Graphic
    {
        if (_parent.cache.images.exists(path)) return cast _parent.cache.images[path].data;

        if (OFLAssets.exists(path))
        {
            var graphic:Graphic = FlxG.bitmap.add(path, path);
            _parent.cache.load(path, graphic, keepStored);

            return graphic;
        }

        return null;
    }

    // public function sounds(sound:String, subFolder:String = "sounds", folder:String = ""):Sound
    // {
    //     return getSound(sound, subFolder, folder);
    // }

    // public function music(sound:String, folder:String = ""):Sound
    // {
    //     return sounds(sound, "music", folder);
    // }

    /**
     * load a file
     * 
     * @param keepStored if can keep stored up in cache
     * @return String
     */
    public function file(path:String, ?keepStored:Bool = false):String
    {
        var daFile:String = null;

        if (_parent.cache.files.exists(path)) return cast _parent.cache.files[path].data;

        if (OFLAssets.exists(path))
        {
            daFile = OFLAssets.getText(path);
            _parent.cache.load(path, daFile, keepStored);
        }

        return daFile;
    }

    public function json(path:String, ?keepStored:Bool = false):Dynamic
        return Json.parse(file(path + '.json', keepStored));

    /**
     * load a audio
     * 
     * @param keepStored if can keep stored up in cache
     * @return Sound
     */
    public function audio(path:String, ?keepStored:Bool = false):Sound
    {
        var sound:Sound = null;

		if (_parent.cache.audios.exists(path))
			return cast _parent.cache.audios[path].data;

        if (OFLAssets.exists(path))
        {
            sound = OFLAssets.getSound(path);
            _parent.cache.load(path, sound, keepStored);
        }

        return sound;
    }
}