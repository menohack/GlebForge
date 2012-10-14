package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.SelectableComponent;
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Camera extends Sprite
	{
		public var bitmapData:BitmapData;
		
		public var bitmap:Bitmap;
		
		private var shape:Rectangle;
		
		private var mapShape:Rectangle;
		
		private static const CAMERA_SPEED:Number = 20.0;
		
		public function Camera(width:uint, height:uint)
		{
			//bitmapData = new BitmapData(width, height);
			//bitmap = new Bitmap(bitmapData);
			
			shape = new Rectangle(0, 0, width, height);
			
			addEventListener(MouseEvent.CLICK, derp);
			mouseChildren = true;
		}
		
		public function derp(e:MouseEvent):void
		{
			
		}
		
		
		public function draw(renderData:BitmapData, renderPosition:Point):void
		{
			//NOTE: This only works for the map, needs to be rewritten
			//bitmapData.copyPixels(renderData, new Rectangle(shape.x, shape.y, shape.x + shape.width, shape.y + shape.height), renderPosition, null, null, true);
		}
		
		public function moveUp():void
		{
			y += CAMERA_SPEED;
		}
		
		public function moveDown():void
		{
			y -= CAMERA_SPEED;
		}
		
		public function moveLeft():void
		{
			x += CAMERA_SPEED;
		}
		
		public function moveRight():void
		{
			x -= CAMERA_SPEED;
		}
		
	}

}