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
		private var shape:Rectangle;
		
		private var mapShape:Rectangle;
		
		private static const CAMERA_SPEED:Number = 1000.0;
		
		public function Camera(width:uint, height:uint)
		{
			shape = new Rectangle(0, 0, width, height);
			
			mouseChildren = false;
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