package com.menohack.glebforge.view 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class UI 
	{
		[Embed(source = "../../../../../lib/ui.png")]
		private var uiImage:Class;
		
		private var render:RenderComponent;
		
		private var start:Point;
		
		private var shape:Shape;
		
		private var drawing:Boolean;
		
		//This sprite contains all elements of the GUI
		private var sprite:Sprite;
		
		public function UI(stage:Stage) 
		{
			sprite = new Sprite();
			sprite.addChild(new uiImage());
			
			shape = new Shape();
			shape.visible = false;
			sprite.addChild(shape);
			
			drawing = false;
			
			start = new Point();
			
			stage.addChild(sprite);
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
	}

}