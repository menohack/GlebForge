package com.menohack.glebforge.view 
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Camera 
	{
		public var bitmapData:BitmapData;
		
		public var bitmap:Bitmap;
		
		private var shape:Rectangle;
		
		private var mapShape:Rectangle;
		
		private static const CAMERA_SPEED:Number = 20.0;
		
		public function Camera(width:uint, height:uint)
		{
			bitmapData = new BitmapData(width, height);
			bitmap = new Bitmap(bitmapData);
			
			shape = new Rectangle(0, 0, width, height);
		}
		
		
		public function draw(renderData:BitmapData, renderPosition:Point):void
		{
			//NOTE: This only works for the map, needs to be rewritten
			bitmapData.copyPixels(renderData, new Rectangle(shape.x, shape.y, shape.x + shape.width, shape.y + shape.height), new Point(0, 0), null, null, true);
		}
		
		public function moveUp():void
		{
			shape.y -= CAMERA_SPEED;
		}
		
		public function moveDown():void
		{
			shape.y += CAMERA_SPEED;
		}
		
		public function moveLeft():void
		{
			shape.x -= CAMERA_SPEED;
		}
		
		public function moveRight():void
		{
			shape.x += CAMERA_SPEED;
		}
		
	}

}