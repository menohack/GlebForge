package com.menohack.glebforge.model 
{
	//import adobe.utils.CustomActions;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	import flash.utils.Timer;
	
	import com.menohack.glebforge.view.Camera;

	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Game implements Model
	{
		[Embed(source="../../../../../lib/shittybarracks.png")]
		private var barracksImage:Class;
		
		[Embed(source = "../../../../../lib/tileSelector.png")]
		private var tileSelector:Class;
		
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		
		private var selector:Bitmap;
		
		private var barracks:Bitmap;
		
		private var peasant:Bitmap;
		private var peasantDirection:Vector3D = new Vector3D;
		
		private var time:uint = 0;
		
		private var endX:uint;
		private var endY:uint;
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		private static var SPEED:Number = 300.0;
		
		private var camera:Camera;
		
		private var stage:Stage;
		
		private var map:Map;
		
		public var otherPlayer:Point;
		
		public var me:Point;
		
		public static var networkAdapter:NetworkAdapter = new NetworkAdapter();
		
		public function Game(s:Stage) 
		{
			stage = s;
			
			selector = new tileSelector();
			
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			stage.addChild(camera.bitmap);
			
			barracks = new barracksImage();
			position.x = stage.stageWidth / 2 - barracks.width/2;
			position.y = stage.stageHeight / 2 - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
			
			peasant = new peasantImage();
			peasant.x = barracks.x + 200;
			peasant.y = barracks.y;
			peasantDirection.x = 0;
			peasantDirection.y = 0;
			
			var randomWalkTimer:Timer = new Timer(1000);
			randomWalkTimer.addEventListener(TimerEvent.TIMER, changeRandWalkDir)
			randomWalkTimer.start();
			
			map = new Map(2000, 2000, camera);
			
			//acm main: 128.220.251.35
			//acm http: 128.220.70.65
			//localhost: 127.0.0.1
			otherPlayer = new Point(200, 200);
			me = new Point(400, 200);
			networkAdapter.addComponent(new NetworkComponent(otherPlayer, me, "128.220.251.35", 11000));
		}
		
		public function update(e:Event):void
		{
			var newTime:uint = getTimer();
			var delta:uint = newTime - time;
			
			position.x = barracks.x;
			position.y = barracks.y;
			var direction:Vector3D = end.subtract(position);
			
			direction.normalize();
			direction.scaleBy(SPEED * delta / 1000);
				
			if (direction.x > 0)
			{
				if (barracks.x + direction.x > end.x)
					barracks.x = end.x;
				else
					barracks.x += direction.x;
			}
			else
			{
				if (barracks.x + direction.x < end.x)
					barracks.x = end.x;
				else
					barracks.x += direction.x;
			}
				
			if (direction.y > 0)
			{
				if (barracks.y + direction.y > end.y)
					barracks.y = end.y;
				else
					barracks.y += direction.y;
			}
			else
			{
				if (barracks.y + direction.y < end.y)
					barracks.y = end.y;
				else
					barracks.y += direction.y;
			}
			me.x = barracks.x;
			me.y = barracks.y;
			
			//random walk AI logic, every second the direction changes
			peasantDirection.normalize();
			peasantDirection.scaleBy(SPEED/10 * delta / 1000);
			peasant.x += peasantDirection.x;
			peasant.y += peasantDirection.y;
			
			time = newTime;
			
			//I feel dirty as a game programmer calling draw from update
			draw();
		}
		
		private function draw():void
		{
			map.draw();
			//camera.bitmapData.copyPixels(grid.bitmapData, new Rectangle(0, 0, grid.width, grid.height), new Point(grid.x, grid.y));
			camera.bitmapData.copyPixels(selector.bitmapData, new Rectangle(0, 0, selector.width, selector.height), new Point(selector.x, selector.y), null, null, true);
			camera.bitmapData.copyPixels(peasant.bitmapData, new Rectangle(0, 0, peasant.width, peasant.height), new Point(otherPlayer.x, otherPlayer.y), null, null, true);
			camera.bitmapData.copyPixels(barracks.bitmapData, new Rectangle(0, 0, barracks.width, barracks.height), new Point(barracks.x, barracks.y), null, null, true);
			
			
		}
		
		private function changeRandWalkDir(event:TimerEvent):void //changes the random walk direction when timer goes off
		{
			peasantDirection.x = Math.sin(Math.random()*360);
			peasantDirection.y = Math.sin(Math.random()*360);
		}
		
		private function drawTileSelector(x:int, y:int):void
		{
			if (x > stage.stageWidth || x < 0 || y > stage.stageHeight || y < 0)
				selector.visible = true;
			else
			{
				selector.x = Math.floor((x) / selector.width) * selector.width;
				selector.y = Math.floor((y) / selector.height) * selector.height;
				selector.visible = true;
			}
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			var key:uint = e.keyCode;
			if (Keyboard.W == key || Keyboard.UP == key)
				camera.moveUp();
			if (Keyboard.S == key || Keyboard.DOWN == key)
				camera.moveDown();
			if (Keyboard.A == key || Keyboard.LEFT == key)
				camera.moveLeft();
			if (Keyboard.D == key || Keyboard.RIGHT == key)
				camera.moveRight();
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			
		}
		
		public function onMouseClick(e:MouseEvent):void
		{
			end = new Vector3D(e.localX - camera.bitmap.x, e.localY - camera.bitmap.y, 0);
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			drawTileSelector(e.localX - camera.bitmap.x, e.localY - camera.bitmap.y);
		}
		
	}

}