package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Map;
	import com.menohack.glebforge.model.Model;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.display.StageDisplayState;
	
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class UI implements View
	{
		[Embed(source = "../../../../../lib/ui.png")]
		private var uiImage:Class;
		
		[Embed(source = "../../../../../lib/cursor.png")]
		private var cursorImage:Class;
		
		private var render:RenderComponent;
		
		private var start:Point;
		
		private var shape:Shape;
		
		private var drawing:Boolean;
		
		private var cursor:Sprite;
		
		public var camera:Camera;
		
		private var stage:Stage;
		
		private var model:Model;
		
		private var lastTime:Date;
		
		//This sprite contains all elements of the GUI
		private var sprite:Sprite;
		
		public function UI(model:Model, stage:Stage) 
		{
			this.model = model;
			this.stage = stage;
			lastTime = new Date();
			
			sprite = new Sprite();
						
			shape = new Shape();
			shape.visible = false;
			sprite.addChild(shape);
			drawing = false;
			
			start = new Point();
			
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			stage.addChild(camera);
			
			var map:Map = new Map(camera);
			for (var bx:int = -5; bx < 5; bx++)
				for (var by:int = -5; by < 5; by++)
					map.addBlock(bx, by);

			sprite.addChild(new uiImage());
			
			stage.addChild(sprite);
			
			cursor = new Sprite(); 
			cursor.addChild(new cursorImage());
			stage.addChild(cursor); 
			 
			stage.addEventListener(MouseEvent.MOUSE_MOVE, redrawCursor); 
			Mouse.hide();
		}
		
		public function redrawCursor(event:MouseEvent):void 
		{ 
			cursor.x = event.stageX; 
			cursor.y = event.stageY; 
		}
		
		private function clear():void
		{
			shape.graphics.clear();
			shape.graphics.lineStyle(1, 0x00FF00);
		}
		
		public function StartDrawingSelectArea(start:Point):void
		{
			this.start = start;
			drawing = true;
		}
		
		public function DrawSelectArea(end:Point):void
		{
			if (drawing)
			{
				clear();
				//shape.graphics.drawRect(start.x, start.y, 40, 200);
				shape.graphics.drawRect(start.x, start.y, end.x - start.x, end.y - start.y);
				shape.visible = true;
				//trace(end);
			}
		}
		
		public function StopDrawingSelectArea():void
		{
			shape.visible = false;
			drawing = false;
		}
		
		public function AddSprite(sprite:Sprite):void
		{
			
		}
		
		public function Update(e:Event):void
		{
			//Update the time and compute the delta in milliseconds since the last update
			var currentTime:Date = new Date();
			var delta:Number = currentTime.getTime() - lastTime.getTime();
			lastTime = new Date();
			
			model.Update(delta);
			var sprites:Vector.<Sprite> = model.GetSprites();
			
			stage.removeChildren(0, stage.numChildren - 1);
			
			for each(var s:Sprite in sprites)
				stage.addChild(s);
		}
		
		private var width:uint;
		
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