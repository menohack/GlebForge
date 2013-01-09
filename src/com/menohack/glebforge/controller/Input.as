package com.menohack.glebforge.controller 
{
	import com.menohack.glebforge.model.Model;
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.UI;
	import com.menohack.glebforge.view.View;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Input implements Controller
	{
		//Whether each key is being held down, could change to time since last press
		private var keys:Vector.<Boolean> = new Vector.<Boolean>(256);
		
		public var view:View;
		
		public function Input() 
		{
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{			
			var key:uint = e.keyCode;
			keys[key] = true;
			
			//Stop drawing the selection box whenever a key is pressed
			view.StopDrawingSelectArea();
				
			//For some strange reason (probably having to do with Flash's default escape behavior)
			//we have store when we are in fullscreen rather than just checking stage.displayState
			if (Keyboard.ESCAPE == key)
			{
				if (view.Fullscreen)
					view.Fullscreen = false;
				else
					view.Fullscreen = true;
			}
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			keys[key] = false;
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			//end = new Vector3D(e.stageX - camera.bitmap.x, e.stageY - camera.bitmap.y, 0);
			view.StartDrawingSelectArea(new Point(e.stageX, e.stageY));
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			//end = new Vector3D(e.stageX - camera.bitmap.x, e.stageY - camera.bitmap.y, 0);
			view.StopDrawingSelectArea();
			
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			//drawTileSelector(e.stageX - camera.bitmap.x, e.stageY - camera.bitmap.y);
			view.DrawSelectArea(new Point(e.stageX, e.stageY));
		}
		
		public function Update(camera:Camera, fullscreen:Boolean, stage:Stage, delta:uint):void
		{
			//Consider locking the camera in place when we are drawing the selection box. Wrap these if statements
			//in another if and ask the UI if we are drawing.
			if (keys[Keyboard.W] || keys[Keyboard.UP] || (stage.mouseY == 0 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveUp(delta / 1000.0);
			}
			if (keys[Keyboard.S] || keys[Keyboard.DOWN] || (stage.mouseY >= stage.stageHeight - 1 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveDown(delta / 1000.0);
			}
			if (keys[Keyboard.A] || keys[Keyboard.LEFT] || (stage.mouseX == 0 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveLeft(delta / 1000.0);
			}
			if (keys[Keyboard.D] || keys[Keyboard.RIGHT] || (stage.mouseX >= stage.stageWidth - 1 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveRight(delta / 1000.0);
			}
		}
	}

}