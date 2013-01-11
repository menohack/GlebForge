package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Map;
	import com.menohack.glebforge.model.Model;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Display implements View
	{
		private var render:RenderComponent;
		
		private var cursor:Cursor;
		
		private var ui:UI;
		
		public var camera:Camera;
		
		private var stage:Stage;
		
		private var model:Model;
		
		private var lastTime:Date;
		
		//This sprite contains all elements of the GUI
		private var sprite:Sprite;
		
		public function Display(model:Model, stage:Stage) 
		{
			this.model = model;
			this.stage = stage;
			lastTime = new Date();
			
			sprite = new Sprite();
			
			
			camera = new Camera(Width, Height);
			stage.addChild(camera);
			
			
			
			ui = new UI();
			
			cursor = new Cursor(stage.addEventListener);
			
			
			stage.addChild(sprite);
		}
		
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
		
		
		public function get Width():uint
		{
			return stage.stageWidth;
		}
		
		public function set Width(width:uint):void
		{
			stage.stageWidth = width;
		}
		
		public function get Height():uint
		{
			return stage.stageHeight;
		}
		
		public function set Height(height:uint):void
		{
			stage.stageHeight = height;
		}
		
		private var fullscreen:Boolean = false;
		
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
		
		public function get Fullscreen():Boolean
		{
			return fullscreen;
		}
		
		public function moveUp(delta:Number):void
		{
			camera.moveUp(delta);
		}
		
		public function moveDown(delta:Number):void
		{
			camera.moveDown(delta);
		}
		
		public function moveLeft(delta:Number):void
		{
			camera.moveLeft(delta);
		}
		
		public function moveRight(delta:Number):void
		{
			camera.moveRight(delta);
		}
	}
}