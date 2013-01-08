package com.menohack.glebforge.controller 
{
	import com.menohack.glebforge.model.Model;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class TestController implements Controller 
	{
		private var model:Model;
		
		public function TestController(model:Model) 
		{
			this.model = model;
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			trace("Key depressed!");
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			trace("Key released!");
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			model.Click(new Point(e.stageX, e.stageY));
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			
		}
	}

}