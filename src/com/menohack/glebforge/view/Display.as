package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Model;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * The Display class handles rendering and encapsulates the View of the MVC design pattern.
	 * Sprites are requested from the model by GetSprites() and rendered, then the user interface
	 * elements like the cursor and buttons are rendered. This should be the only class that has
	 * access to the Stage.
	 * 
	 * @todo Extract the Select Area functionality into the cursor and simplify the View methods
	 * to draw it.
	 * 
	 * @author James Doverspike
	 */
	public class Display implements View
	{
		/**
		 * The cursor object.
		 */
		private var cursor:Cursor;
		
		/**
		 * The user interface: such as menus and buttons.
		 */
		private var ui:UI;
		
		/**
		 * The current camera.
		 */
		public var camera:Camera;
		
		/**
		 * A reference to the stage object.
		 */
		private var stage:Stage;
		
		/**
		 * The model of the game logic.
		 */
		private var model:Model;
		
		/**
		 * The last date that the Update function was called.
		 */
		private var lastTime:Date;
		
		/**
		 * Whether the game is fullscreen or windowed.
		 */
		private var fullscreen:Boolean = false;
		
		/**
		 * Default constructor.
		 * @param	model
		 * @param	stage
		 */
		public function Display(model:Model, stage:Stage) 
		{
			this.model = model;
			this.stage = stage;
			
			lastTime = new Date();
			
			camera = new Camera(Width, Height);
			
			ui = new UI();
			
			cursor = new Cursor(stage.addEventListener);
		}
		
		//TODO: Refactor the following three methods
		
		public function StartDrawingSelectArea(start:Point):void
		{
			cursor.StartDrawingSelectArea(start);
		}
		
		public function DrawSelectArea(end:Point):void
		{
			cursor.DrawSelectArea(end);
		}
		
		public function StopDrawingSelectArea():void
		{
			cursor.StopDrawingSelectArea();
		}
		
		/**
		 * Gets the current camera.
		 * @return The current camera.
		 */
		public function GetCamera():Camera
		{
			return camera;
		}
		
		/**
		 * The Update method is called once per frame by the ActionScript runtime. All rendering
		 * should take place here. The method expects to receive the sprites that should be
		 * rendered from the game in order by the GetSprites() method.
		 * @param	e The ENTER_FRAME event.
		 */
		public function Update(e:Event):void
		{
			//Update the time and compute the delta in milliseconds since the last update
			var currentTime:Date = new Date();
			var delta:Number = currentTime.getTime() - lastTime.getTime();
			lastTime = new Date();
			
			model.Update(delta);
			var sprites:Vector.<Sprite> = model.GetSprites();
			
			if (stage.numChildren > 0)
				stage.removeChildren(0, stage.numChildren - 1);
			
			for each(var s:Sprite in sprites)
				camera.addChild(s);
				
			stage.addChild(camera);
				
			
			if (cursor.Rectangle != null)
				stage.addChild(cursor.Rectangle);
			if (cursor.Image)
				stage.addChild(cursor.Image);
			if (ui.Image != null)
				stage.addChild(ui.Image);
		}
		
		/**
		 * Gets the width of the stage.
		 * @return The width of the stage.
		 */
		public function get Width():uint
		{
			return stage.stageWidth;
		}
		
		/**
		 * Sets the width of the stage.
		 * @param	width The new width.
		 */
		public function set Width(width:uint):void
		{
			stage.stageWidth = width;
		}
		
		/**
		 * Gets the height of the stage.
		 * @return The height of the stage.
		 */
		public function get Height():uint
		{
			return stage.stageHeight;
		}
		
		/**
		 * Sets the height of the stage.
		 * @param 	height The new height.
		 */
		public function set Height(height:uint):void
		{
			stage.stageHeight = height;
		}
		
		/**
		 * Sets the fullscreen state of the game.
		 * @param	fullscreen True if fullscreen, false if windowed.
		 */
		public function set Fullscreen(fullscreen:Boolean):void
		{
			if (this.fullscreen == fullscreen)
				return;
				
			if (!this.fullscreen)
			{
				stage.displayState = StageDisplayState.FULL_SCREEN;
				this.fullscreen = true;
			}
			else
			{
				stage.displayState = StageDisplayState.NORMAL;
				this.fullscreen = false;
			}
		}
		
		/**
		 * Gets whether the game is in fullscreen mode.
		 * @return True if the game is fullscreen, false if it is windowed.
		 */
		public function get Fullscreen():Boolean
		{
			return fullscreen;
		}
		
		/**
		 * Moves the camera up for delta seconds
		 * @param	delta The number of seconds to move upwards.
		 */
		public function moveUp(delta:Number):void
		{
			camera.moveUp(delta);
		}
		
		/**
		 * Moves the camera down for delta seconds
		 * @param	delta The number of seconds to move downwards.
		 */
		public function moveDown(delta:Number):void
		{
			camera.moveDown(delta);
		}
		
		/**
		 * Moves the camera left for delta seconds
		 * @param	delta The number of seconds to move leftwards.
		 */
		public function moveLeft(delta:Number):void
		{
			camera.moveLeft(delta);
		}
		
		/**
		 * Moves the camera right for delta seconds
		 * @param	delta The number of seconds to move rightwards.
		 */
		public function moveRight(delta:Number):void
		{
			camera.moveRight(delta);
		}
	}
}