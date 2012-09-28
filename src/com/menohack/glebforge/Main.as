package com.menohack.glebforge
{
	import adobe.utils.CustomActions;
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
	import flash.utils.Timer;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../../../../lib/shittybarracks.png")]
		private var barracksImage:Class;
		
		[Embed(source="../../../../lib/blueTile.png")]
		private var blueTile:Class;
		
		[Embed(source = "../../../../lib/greyTile.png")]
		private var greyTile:Class;
		
		[Embed(source = "../../../../lib/mustardTile.png")]
		private var mustardTile:Class;
		
		[Embed(source = "../../../../lib/tileSelector.png")]
		private var tileSelector:Class;
		
		[Embed(source = "../../../../lib/peasant.png")]
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
		
		private var gridBitmapData:BitmapData;
		
		private var grid:Bitmap;
		
		private var camera:Camera;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.frameRate = 120;
			//Mouse.hide();
			
			gridBitmapData = new BitmapData(stage.stageWidth, stage.stageHeight);
			
			var tiles:Array = new Array(new greyTile(), new blueTile(), new mustardTile());
			
			for (var i:uint = 0; i * 41 < stage.stageWidth; i++)
			{
				for (var j:uint = 0; j * 41 < stage.stageHeight; j++)
				{
					var random:uint = uint(Math.random() * 3);
					var tile:Bitmap = tiles[random];
					gridBitmapData.copyPixels(tile.bitmapData, new Rectangle(0, 0, tile.width, tile.height), new Point(i * 41, j * 41));
				}
			}
			
			grid = new Bitmap(gridBitmapData);
			
			selector = new tileSelector();
			//addChild(selector);
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			addChild(camera.bitmap);
			
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
			
			
			addEventListener(Event.ENTER_FRAME, create);
		}
		
		private function create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, create);
			
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			//camera.bitmapData.fillRect(new Rectangle(0, 0, camera.bitmapData.width, camera.bitmapData.height), 0x0000FFFF);
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
			
			//random walk AI logic, every second the direction changes
			peasantDirection.normalize();
			peasantDirection.scaleBy(SPEED/10 * delta / 1000);
			peasant.x += peasantDirection.x;
			peasant.y += peasantDirection.y;
			
			
			camera.bitmapData.copyPixels(grid.bitmapData, new Rectangle(0, 0, grid.width, grid.height), new Point(grid.x, grid.y));
			camera.bitmapData.copyPixels(selector.bitmapData, new Rectangle(0, 0, selector.width, selector.height), new Point(selector.x, selector.y), null, null, true);
			camera.bitmapData.copyPixels(peasant.bitmapData, new Rectangle(0, 0, peasant.width, peasant.height), new Point(peasant.x, peasant.y), null, null, true);
			camera.bitmapData.copyPixels(barracks.bitmapData, new Rectangle(0, 0, barracks.width, barracks.height), new Point(barracks.x, barracks.y), null, null, true);
			
			
			time = newTime;
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
		
		private function onKeyDown(e:KeyboardEvent):void
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
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			end = new Vector3D(e.localX - camera.bitmap.x, e.localY - camera.bitmap.y, 0);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			drawTileSelector(e.localX - camera.bitmap.x, e.localY - camera.bitmap.y);
		}
		
	}
	
}