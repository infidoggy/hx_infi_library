package infi_library.assets;

import flixel.graphics.FlxGraphic;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.system.FlxAssets;
import openfl.media.Sound;

using StringTools;

class InfiAssets
{
    public var DEFAULT_AUDIO_EXT:String = #if web ".mp3" #else ".ogg" #end;

    public var load(default, null):InfiLoad;
    public var cache(default, null):InfiCache;
    public var extra(default, null):InfiAssetsExtra;

    public function new()
    {
        cache = new InfiCache();
        extra = new InfiAssetsExtra(this);
        load = new InfiLoad(this);
    }

    public function getPath(path:String):String
        return 'assets/' + path;

    public function getData(path:String):String
        return getPath('data/' + path);

    public function getImage(path:String, ?withExt:Bool = true):String
    {
        if (withExt) return detectExtensions(getPath('images/' + path), ['png', 'jpg']);
        return getPath('images/' + path);
    }

    public function getSound(path:String, ?folder:String = 'sounds', ?withExt:Bool = true):String
    {
        if (withExt) return detectExtensions(getPath('$folder/' + path), [DEFAULT_AUDIO_EXT, 'wav']);
        return getPath('$folder/' + path);
    }

    public function getMusic(path:String, ?withExt:Bool = true):String
        return getSound(path, 'music', withExt);

    public function detectExtensions(path:String, extensions:Array<String>):String
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

    public function getSong(song:String = 'dandaniel', ?keepStorage:Bool = false):Array<Sound>
        return [_parent.load.sound(_parent.getMusic('songs/' + song + '/Inst'), keepStorage),
                _parent.load.sound(_parent.getMusic('songs/' + song + '/Voices'), keepStorage)];

    public function getSparrowAtlas(path:String, ?keepStorage:Bool = false):FlxAtlasFrames
        return FlxAtlasFrames.fromSparrow(_parent.load.image(path + '.png', keepStorage), 
                _parent.load.file(path + '.xml', keepStorage));
}
