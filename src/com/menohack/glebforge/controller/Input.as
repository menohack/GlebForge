package com.menohack.glebforge.controller 
{
	import com.menohack.glebforge.model.Model;
	import com.menohack.glebforge.model.SelectArea;
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.View;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * The Input class implements the Controller part of the MVC pattern. The Controller
	 * is part of the Model. The ActionScript runtime raises events for mouse and keyboard
	 * input, making this class completely event-driven.
	 * 
	 * @author James Doverspike
	 */
	public class Input implements Controller
	{
		/**
		 * Whether each key is being held down, could change to time since last press.
		 */
		private var keys:Vector.<Boolean> = new Vector.<Boolean>(256);
		
		/**
		 * The position of the mouse.
		 */
		private var mousePosition:Point = new Point();
		
		/**
		 * The view.
		 */
		private var view:View;
		
		/**
		 * The object describing user selection with the mouse.
		 */
		private var selectArea:SelectArea;
		
		private var rightClick:Function;
		
		/**
		 * Default constructor.
		 */
		public function Input(selectArea:SelectArea, rightClick:Function) 
		{
			this.selectArea = selectArea;
			this.rightClick = rightClick;
		}
		
		/**
		 * Sets the view.
		 * @param	view The new view.
		 */
		public function SetView(view:View):void
		{
			this.view = view;
		}
		
		/**
		 * Invoked by the ActionScript runtime when a key is depressed.
		 * @param	e The KeyboardEvent of the key press.
		 */
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
		
		/**
		 * Invoked by the ActionScript runtime when a key is released.
		 * @param	e The KeyboardEvent of the key release.
		 */
		public function onKeyUp(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			keys[key] = false;
		}
		
		/**
		 * Invoked by the ActionScript runtime when the left mouse button is depressed.
		 * @param	e The MouseEvent of the button press.
		 */
		public function onMouseDown(e:MouseEvent):void
		{
			selectArea.TopLeft = new Point(e.localX, e.localY);
			view.StartDrawingSelectArea(new Point(e.stageX, e.stageY));
		}
		
		/**
		 * Invoked by the ActionScript runtime when the left mouse button is released.
		 * @param	e The MouseEvent of the button release.
		 */
		public function onMouseUp(e:MouseEvent):void
		{
			view.StopDrawingSelectArea();
			selectArea.Select();
		}
		
		/**
		 * Invoked by the ActionScript runtime when the right mouse button is depressed.
		 * @param	e The MouseEvent of the button press.
		 */
		public function onRightMouseDown(e:MouseEvent):void
		{
			rightClick(new Point(e.localX, e.localY));
		}
		
		/**
		 * Invoked by the ActionScript runtime when the right mouse button is released.
		 * @param	e The MouseEvent of the button release.
		 */
		public function onRightMouseUp(e:MouseEvent):void
		{
			
		}
		
		/**
		 * Invoked by the ActionScript runtime when the mouse moves.
		 * @param	e The MouseEvent of the mouse move.
		 */
		public function onMouseMove(e:MouseEvent):void
		{
			selectArea.BottomRight.x = e.localX;
			selectArea.BottomRight.y = e.localY;
			
			mousePosition = new Point(e.stageX, e.stageY);
			//trace("(" + e.localX + "," + e.localY + ")");
			
			view.DrawSelectArea(mousePosition);
		}
		
		/**
		 * Updates the Controller.
		 * @param	delta The change in milliseconds since the last update.
		 */
		public function Update(delta:Number):void
		{
			//Consider locking the camera in place when we are drawing the selection box. Wrap these if statements
			//in another if and ask the UI if we are drawing.
			if (keys[Keyboard.W] || keys[Keyboard.UP] || (mousePosition.y == 0 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveUp(delta / 1000.0);
			}
			if (keys[Keyboard.S] || keys[Keyboard.DOWN] || (mousePosition.y >= view.Height - 1 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveDown(delta / 1000.0);
			}
			if (keys[Keyboard.A] || keys[Keyboard.LEFT] || (mousePosition.x == 0 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveLeft(delta / 1000.0);
			}
			if (keys[Keyboard.D] || keys[Keyboard.RIGHT] || (mousePosition.x >= view.Width - 1 && view.Fullscreen))
			{
				view.StopDrawingSelectArea();
				view.moveRight(delta / 1000.0);
			}
		}
	}

}