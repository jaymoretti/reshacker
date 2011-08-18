package 
{
	import com.apple.reshacker.Images;
	import com.apple.reshacker.file.Body;
	import com.apple.reshacker.file.Header;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.utils.ByteArray;
	[SWF(backgroundColor="#FFFFFF", frameRate="31", width="1920", height="480")]
	
	public class Main extends Sprite
	{
		private var loader : URLLoader;
		private var ba : ByteArray;
		private var header : ByteArray;
		private var body : ByteArray;
		private var images : ByteArray;
		private var pngs : Array;
		private var container : Sprite;
		private var _header : Header;
		private var _body : Body;
		private var _images : Images;
		public function Main()
		{
			super();
			addEventListener(Event.ADDED_TO_STAGE, start);
		}

		private function start(event : Event) : void
		{
			loader = new URLLoader();
			loader.dataFormat = URLLoaderDataFormat.BINARY;
			loader.addEventListener(Event.COMPLETE, loadedRSRC);
			loader.load(new URLRequest("Finder.rsrc"));
			
			container = new Sprite();
			addChild(container);
		}

		private function loadedRSRC(event : Event) : void
		{
			
			ba = loader.data;
			_header = new Header();
			_header.init(ba);
			
			_body = new Body();
			_body.callback = dataParsed;
			_body.init(ba);
			
			_images = new Images();
			_images.callback = imagesLoaded;
			_images.init(ba);
			
			
		}
		private function dataParsed():void
		{
			
		}

		private function imagesLoaded() : void
		{
			//for(var i:int = 0; i!=_images.bitmaps.length; i++)
				//container.addChild(_images.bitmaps[i]);
		}
	}
}