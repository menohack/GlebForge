package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Map;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
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
		
		//This sprite contains all elements of the GUI
		private var sprite:Sprite;
		
		public function UI(stage:Stage) 
		{
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
		
		public function startDrawingSelectArea(start:Point):void
		{
			this.start = start;
			drawing = true;
		}
		
		public function drawSelectArea(end:Point):void
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
		
		public function stopDrawingSelectArea():void
		{
			shape.visible = false;
			drawing = false;
		}
		
		public function AddSprite(sprite:Sprite):void
		{
			
		}
	}

}