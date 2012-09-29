package com.menohack.glebforge.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class RenderComponent 
	{
		private var bitmapData:BitmapData;
		
		private var bitmap:Bitmap;
		
		private var camera:Camera;
		
		private var shape:Rectangle;
		
		private var position:Point;
		
		public function RenderComponent() 
		{
		}
		
		public function set Camera(camera:Camera):void
		{
			this.camera = camera;
			position = new Point(0, 0);
		}
		
		public function load(filename:String):void
		{
			//TODO: Error checking on the filename
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest(filename));
		}
		
		public function set Bitmap(bitmap:Bitmap):void
		{	
			this.bitmap = bitmap;
			this.bitmapData = bitmap.bitmapData;
		}
		
		private function onComplete(e:Event):void
		{
			var info:LoaderInfo = e.target as LoaderInfo;
			bitmap = info.content as Bitmap;
			bitmapData = bitmap.bitmapData;
			
			shape = new Rectangle(0, 0, bitmap.width, bitmap.height);
			position = new Point(0, 0);
		}
		
		public function set Position(position:Point):void
		{
			this.position = position;
		}
		
		public function draw():void
		{
			if (bitmap == null || camera == null)
				return;
			if (shape == null)
				shape = new Rectangle(0, 0, bitmap.width, bitmap.height);	
				
			camera.draw(bitmapData, position);
		}
		
	}

}