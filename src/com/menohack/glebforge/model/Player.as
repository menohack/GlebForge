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
	public class Player
	{
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		
		private var peasant:Bitmap;
		private var peasantDirection:Vector3D = new Vector3D;
		
		private var render:RenderComponent;
		
		private var select:SelectableComponent;
		
		private var position:Point;
		
		public function Player(x:int, y:int, camera:Camera)
		{
			peasantDirection.x = 0;
			peasantDirection.y = 0;
			
			render = new RenderComponent();
			select = new SelectableComponent(render);
			render.Camera = camera;
			peasant = new peasantImage();
			render.Bitmap = peasant;
			
			position = new Point();
			position.x = x;
			position.y = y;
			render.setPosition(x, y);
			
			var randomWalkTimer:Timer = new Timer(1000);
			randomWalkTimer.addEventListener(TimerEvent.TIMER, changeRandWalkDir)
			randomWalkTimer.start();
		}
		
		public function update(delta:uint):void
		{
			//random walk AI logic, every second the direction changes
			peasantDirection.normalize();
			peasantDirection.scaleBy(Game.SPEED / 10 * delta / 1000);
			render.setPosition(position.x + peasantDirection.x, position.y + peasantDirection.y);
			//render.position.x += peasantDirection.x;
			//render.position.y += peasantDirection.y;
			
		}
		
		/*
		public function draw():void
		{
			render.draw();
		}
		*/
		
		private function changeRandWalkDir(event:TimerEvent):void //changes the random walk direction when timer goes off
		{
			peasantDirection.x = Math.sin(Math.random()*360);
			peasantDirection.y = Math.sin(Math.random()*360);
		}
	}

}