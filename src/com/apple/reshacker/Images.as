/******************************************************************************
 * 			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 * 					Version 2, December 2004
 * 
 * Copyright (C) 2011 - Jay Moretti <jrmoretti@gmail.com>
 * 
 * Everyone is permitted to copy and distribute verbatim or modified
 * copies of this license document, and changing it is allowed as long
 * as the name is changed.
 * 
 *			DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
 *	TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
 * 
 *  0. You just DO WHAT THE FUCK YOU WANT TO. 
 *******************************************************************************/
package com.apple.reshacker
{
	import com.jaymoretti.core.debug.LogBook;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.utils.ByteArray;
	public class Images
	{
		private var _data : ByteArray;
		private var _rawimages : Array, _bitmaps:Array;
		private var _loadedCounter : int = 0;
		private var _callback : Function;
		private var _total : uint;
		public function Images() {
			
		}

		public function init(ba : ByteArray) : void
		{	
			_data = new ByteArray();
			
			var length:int = ba.length-ba.position; 
			for(var i:uint = 0; i!=length; i++)
				_data.writeByte(ba.readByte());
				
			parseImages();
		}
	
		private function parseImages() : void
		{
			LogBook.log("ME ME ME ME");
			_data.position = 0;
			var pngStart:Array = ["89", "50", "4e", "47"];
			var startingOffsets:Array = ByteSearch.search(_data, pngStart);
			
			_data.position = 0;
			var pngEnds:Array = ["49", "45", "4e", "44"];
			var endingOffsets:Array = ByteSearch.search(_data, pngEnds);
			
			_rawimages = []; 
			_bitmaps = [];
			for(var i:int = 0; i!=startingOffsets.length; i++)
			{
				var temp:ByteArray = new ByteArray();
				var start:uint = startingOffsets[i]-1;
				var length:uint = (endingOffsets[i]-startingOffsets[i])+4;
				_data.position = 0;
				
				try
				{
					
					temp.writeBytes(_data, start, length);
					_rawimages.push(temp);
				} catch (e:Error)
				{
					
				}
				temp.position = 0;
				
			}		
				
			loadPngs();
		}

		private function loadPngs() : void
		{
			for(var i:int = 0; i!=_rawimages.length; i++)
			{
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadedPNG);
				
				loader.loadBytes(_rawimages[i]);
			}
		}
		
		

		private function loadedPNG(event : Event) : void
		{
			var l:LoaderInfo = event.target as LoaderInfo;
			var bmp:Bitmap = l.content as Bitmap;
			
			_bitmaps.push(bmp);
			
			_loadedCounter++;
			
			if(_loadedCounter == _rawimages.length)
				_callback.call();
		}



		public function get data() : ByteArray
		{
			return _data;
		}

		public function get bitmaps() : Array
		{
			return _bitmaps;
		}

		public function set callback(callback : Function) : void
		{
			_callback = callback;
		}
		
	}
}
