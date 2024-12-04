package infiproject.assets;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import openfl.media.Sound;

using StringTools;

class InfiAssets
{
    public var defaultAssets:String = 'assets';
    public var ignoreAudioExt:Bool = false;

    public var IGNORE_AUDIO_EXT:String = #if !web ".mp3" #else ".ogg" #end;

    /**
     * load files, images and audios.
     * 
     * @since 0.0.1
     */
    public var load(default, null):InfiLoad;
    /**
     * stored up all files for reuse them, useful for loading screens
     * 
     * @since 0.0.1
     */
    public var cache(default, null):InfiCache;
    /**
     * some extras tools
     * 
     * @since 0.0.1
     */
    public var extra(default, null):InfiAssetsExtra;

    public function new()
    {
        cache = new InfiCache();
        extra = new InfiAssetsExtra(this);
        load = new InfiLoad(this);
    }

    /**
     * Return a path
     * 
     * you can configure the main assets folder, see `defaultAssets`
     */
    public function getPath(path:String):String
        return '/$defaultAssets/$path';

    /**
     * Return a path for `data` folder
     * 
     * @param path the file or folder in `data` package
     * @return String
        return `getPath('data/' + path)`
     */
    public function getData(path:String):String
        return getPath('data/' + path);

    /**
     * ### detect if a image file exists in a `folder`
     * 
     * if is true return the image path
     * 
     * else return a void string chain(`''`)
     * 
     * @param withExt if can detect the extension
     * @return String
        return `getPath('$folder/$path')`
     */
    public function getImage(path:String, ?folder:String = 'images', ?withExt:Bool = true):String
    {
        if (withExt) return detectExtensions(getPath(folder + '/' + path), ['png', 'jpg']);
        return getPath('$folder/$path');
    }

    /**
     * ### detect if a audio file exists in a `folder`
     * 
     * if is true return the audio path
     * 
     * else return a void string chain(`''`)
     * 
     * ## RECOMENDATION
     * if you use .mp3 audios in windows builds, active the variable `ignoreAudioExt`
     * 
     * @param withExt if can detect the extension
     * @return String
        return `getPath('$folder/$path')`
     */
    public function getSound(path:String, ?folder:String = 'sounds', ?withExt:Bool = true):String
    {
        var audioExt = ['ogg', 'mp3', 'wav'];
        if (ignoreAudioExt) audioExt.remove(IGNORE_AUDIO_EXT);
        if (withExt) return detectExtensions(getPath('$folder/' + path), audioExt);
        return getPath('$folder/$path');
    }

    /**
     * works like `getSound`
     * 
     * but give a fast access to `music` folder
     * 
     * ## RECOMENDATION
     * if you use .mp3 audios in windows builds, active the variable `ignoreAudioExt`
     */
    public function getMusic(path:String, ?withExt:Bool = true):String
        return getSound(path, 'music', withExt);

    function detectExtensions(path:String, extensions:Array<String>):String
    {
        // openfl.Assets.exists()
        for (ext in extensions)
        {
            var daPath = path + ((!ext.startsWith('.')) ? '.' : '') + ext;
            if (openfl.Assets.exists(daPath)) return daPath;
        }
        return '';
    }
}

class InfiAssetsExtra
{
    var _parent:InfiAssets;

    public function new(parent:InfiAssets)
    {
        _parent = parent;
    }

    /**
     * If you are working in a mod of Friday Night Funkin'
     * 
     * but you can use this for other uses... idk
     * 
     * @since 0.0.1
     * @param song the song's name(you can configurate the songs path)
     * @param keepStorage if the file can keep stored up
     * @return Array<Sound>
     */
    public function getSong(song:String = 'bopeebo', ?keepStorage:Bool = false):Array<Sound>
        return [_parent.load.sound(_parent.getMusic('songs/' + song + '/Inst'), keepStorage),
                _parent.load.sound(_parent.getMusic('songs/' + song + '/Voices'), keepStorage)];

    /**
     * Return a sparrow atlas sprite sheet
     * 
     * load the image and xml file
     * 
     * @since 0.0.1
     * @param path the path of the file
     * @param keepStorage if the file can keep stored up
     * @return FlxAtlasFrames
     */
    public function getSparrowAtlas(path:String, ?keepStorage:Bool = false):FlxAtlasFrames
        return FlxAtlasFrames.fromSparrow(_parent.load.image(path + '.png', keepStorage), 
                _parent.load.file(path + '.xml', keepStorage));
}
