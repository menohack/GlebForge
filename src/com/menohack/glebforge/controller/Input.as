package com.menohack.glebforge.controller 
{
	import com.menohack.glebforge.model.Model;
	import com.menohack.glebforge.view.View;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Input implements Controller
	{
		private var model:Model;
		
		private var view:View;
		
		public function Input(model:Model, view:View) 
		{
			this.model = model;
			this.view = view;
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			//drawTileSelector(e.stageX - camera.bitmap.x, e.stageY - camera.bitmap.y);
			view.drawSelectArea(new Point(e.stageX, e.stageY));
		}
		internal function derp():void
		{
			
		}
	}

}