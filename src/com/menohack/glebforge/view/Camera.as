package com.menohack.glebforge.view 
{
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.geom.Point;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Camera 
	{
		public var bitmapData:BitmapData;
		
		public var bitmap:Bitmap;
		
		private var position:Point;
		
		private static const CAMERA_SPEED:Number = 20.0;
		
		public function Camera(width:uint, height:uint) 
		{
			bitmapData = new BitmapData(width, height);
			bitmap = new Bitmap(bitmapData);
			
			position = new Point();
		}
		
		
		public function moveUp():void
		{
			bitmap.y += CAMERA_SPEED;
		}
		
		public function moveDown():void
		{
			bitmap.y -= CAMERA_SPEED;
		}
		
		public function moveLeft():void
		{
			bitmap.x += CAMERA_SPEED;
		}
		
		public function moveRight():void
		{
			bitmap.x -= CAMERA_SPEED;
		}
		
	}

}