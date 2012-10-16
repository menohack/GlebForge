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
	
	/** The Camera class is a container class that contains all of the sprites that it
	 * should render. This allows the position of all of the sprites to be adjusted at once
	 * by changing the position of the camera itself. The Camera class does not contain the
	 * GUI because it would never change based on the camera's position. There can be multiple
	 * cameras for cinematics.
	 * 
	 * @author James Doverspike
	 */
	public class Camera extends Sprite
	{
		public var bitmapData:BitmapData;
		
		public var bitmap:Bitmap;
		
		private var shape:Rectangle;
		
		private var mapShape:Rectangle;
		
		private static const CAMERA_SPEED:Number = 1000.0;
		
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
			trace("Camera space was clicked");
		}
		
		
		public function draw(renderData:BitmapData, renderPosition:Point):void
		{
			//NOTE: This only works for the map, needs to be rewritten
			//bitmapData.copyPixels(renderData, new Rectangle(shape.x, shape.y, shape.x + shape.width, shape.y + shape.height), renderPosition, null, null, true);
		}
		
		public function moveUp(delta:Number):void
		{
			y += CAMERA_SPEED * delta;
		}
		
		public function moveDown(delta:Number):void
		{
			y -= CAMERA_SPEED * delta;
		}
		
		public function moveLeft(delta:Number):void
		{
			x += CAMERA_SPEED * delta;
		}
		
		public function moveRight(delta:Number):void
		{
			x -= CAMERA_SPEED * delta;
		}
		
	}

}