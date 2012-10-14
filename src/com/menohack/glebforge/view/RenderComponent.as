package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Game;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class RenderComponent extends Sprite
	{
		//private var bitmapData:BitmapData;
		
		//private var bitmap:Bitmap;
		
		private var camera:Camera;
		
		//private var shape:Rectangle;
		
		//public var position:Point;
		
		public function RenderComponent() 
		{
			this.visible = true;
		}
		
		public function set Camera(camera:Camera):void
		{
			this.camera = camera;
			camera.addChild(this);
			//position = new Point(0, 0);
		}
		
		/*
		public function load(filename:String):void
		{
			//TODO: Error checking on the filename
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest(filename));
		}
		*/
		
		public function set Bitmap(bitmap:Bitmap):void
		{	
			addChild(bitmap);
			//this.bitmap = bitmap;
			//this.bitmapData = bitmap.bitmapData;
		}
		
		/*
		private function onComplete(e:Event):void
		{
			var info:LoaderInfo = e.target as LoaderInfo;
			bitmap = info.content as Bitmap;
			bitmapData = bitmap.bitmapData;
			
			shape = new Rectangle(0, 0, bitmap.width, bitmap.height);
			position = new Point(0, 0);
		}
		*/
		
		public function set Position(position:Point):void
		{
			//this.position = position;
			setPosition(position.x, position.y);
		}
		
		public function setPosition(x:uint, y:uint):void
		{
			this.x = x;
			this.y = y;
		}
		
		/*
		public function draw():void
		{
			if (bitmap == null || camera == null)
				return;
			if (shape == null)
				shape = new Rectangle(0, 0, bitmap.width, bitmap.height);	
				
			camera.draw(bitmapData, position);
		}
		*/
		
	}

}