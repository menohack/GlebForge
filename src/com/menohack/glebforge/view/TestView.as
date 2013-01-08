package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Model;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class TestView implements View 
	{
		private var model:Model;
		
		private static var lastTime:Date;
		
		private var stage:Stage;
		
		public function TestView(model:Model, stage:Stage) 
		{
			this.model = model;
			this.stage = stage;
			
			lastTime = new Date();
		}
		public function AddSprite(sprite:Sprite):void
		{
			
		}
		
		public function DrawSelectArea(end:Point):void
		{
			
		}
		
		public function StopDrawingSelectArea():void
		{
			
		}
		
		public function StartDrawingSelectArea(start:Point):void
		{
			
		}
		
		//Not sure if I want to keep this, maybe the view should update the model
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
	}

}