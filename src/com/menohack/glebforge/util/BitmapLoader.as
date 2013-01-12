package com.menohack.glebforge.util 
{
	import flash.display.LoaderInfo;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.display.Stage;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.errors.IOError;
	
	/**
	 * The BitmapLoader class loads bitmaps asynchronously from a URL.
	 * 
	 * @author James Doverspike
	 */
	public class BitmapLoader 
	{
		private var loader:Loader;
		
		private var loaded:Function;
		
		public function BitmapLoader() 
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, error);
		}
		
		private function error(e:IOErrorEvent):void
		{
			trace(e);
		}
		
		private function onComplete(e:Event):void
		{
			var info:LoaderInfo = e.target as LoaderInfo;
			var bitmap:Bitmap = info.content as Bitmap;
			loaded(bitmap);
		}
		
		/**
		 * Load a bitmap asynchonously from the filesystem or the network. Supported
		 * filetypes are JPEG, PNG, GIF and SWF.
		 * @param	filename The file path or URL to load.
		 * @param	loaded The function that will be invoked once the image is loaded.
		 * The function must accept a single Bitmap parameter.
		 */
		public function Load(filename:String, loaded:Function):void
		{
			//TODO: Error checking on the filename
			try
			{
				this.loaded = loaded;
				loader.load(new URLRequest(filename));
			}
			catch (e:IOError)
			{
				trace("Threw exception: " + e.message);
			}
		}
	}

}