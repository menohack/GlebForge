package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Entity;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.ui.Mouse;
	import com.menohack.glebforge.model.Entity;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Cursor
	{
		[Embed(source = "../../../../../lib/cursor.png")]
		private var cursorImage:Class;
		
		/**
		 * The cursor sprite.
		 */
		private var cursor:Sprite;
		
		/**
		 * The starting point of the selection box.
		 */
		private var start:Point;
		
		/**
		 * The selection rectangle.
		 */
		private var shape:Shape;
		
		/**
		 * Whether the selection box is being dragged.
		 */
		private var drawing:Boolean;
		
		/**
		 * Default constructor. The addEventListener function allows
		 * the cursor to redraw itself on mouse move.
		 * @param	addEventListener The stage addEventListener function.
		 */
		public function Cursor(addEventListener:Function)
		{
			shape = new Shape();
			shape.visible = false;
			//addChild(shape);
			
			drawing = false;
			
			start = new Point();
			
			cursor = new Sprite(); 
			cursor.addChild(new cursorImage());
			
			addEventListener(MouseEvent.MOUSE_MOVE, redrawCursor);
			Mouse.hide();
		}
		
		public function get Rectangle():Shape
		{
			return shape;
		}
		
		public function get Image():Sprite
		{
			return cursor;
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
				shape.graphics.drawRect(start.x, start.y, end.x - start.x, end.y - start.y);
				shape.visible = true;
			}
		}
		
		public function StopDrawingSelectArea():void
		{
			shape.visible = false;
			drawing = false;
		}
	}

}