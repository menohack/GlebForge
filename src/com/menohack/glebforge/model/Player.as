package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.RenderComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Player extends Entity
	{
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;

		private var peasantDirection:Vector3D = new Vector3D;
		
		
		private var position:Point;
		
		private var testSpeed:Number = 300.0;
		
		public function Player(x:int, y:int)
		{
			peasantDirection.x = 0;
			peasantDirection.y = 0;
			
			var render:RenderComponent = new RenderComponent();
			AddComponent(render);
			//render.Camera = camera;
			var peasant:Bitmap = new peasantImage();
			render.Bitmap = peasant;
			
			position = new Point();
			position.x = x;
			position.y = y;
			render.Position = new Point(x, y);
			
			var randomWalkTimer:Timer = new Timer(1000);
			randomWalkTimer.addEventListener(TimerEvent.TIMER, changeRandWalkDir)
			randomWalkTimer.start();
		}
		
		public function update(delta:Number):void
		{
			//random walk AI logic, every second the direction changes
			peasantDirection.normalize();
			peasantDirection.scaleBy(testSpeed / 10 * delta / 1000);
			var render:RenderComponent = GetComponent(RenderComponent) as RenderComponent;
			render.Position = new Point(position.x + peasantDirection.x, position.y + peasantDirection.y);
		}
		
		private function changeRandWalkDir(event:TimerEvent):void //changes the random walk direction when timer goes off
		{
			peasantDirection.x = Math.sin(Math.random()*360);
			peasantDirection.y = Math.sin(Math.random()*360);
		}
	}

}