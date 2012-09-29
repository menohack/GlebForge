package com.menohack.glebforge.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	import flash.display.Stage;
	
	import com.menohack.glebforge.view.Camera;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Game implements Model
	{
		[Embed(source="../../../../../lib/shittybarracks.png")]
		private var barracksImage:Class;
		
		[Embed(source="../../../../../lib/blueTile.png")]
		private var blueTile:Class;
		
		[Embed(source = "../../../../../lib/greyTile.png")]
		private var greyTile:Class;
		
		[Embed(source = "../../../../../lib/mustardTile.png")]
		private var mustardTile:Class;
		
		[Embed(source = "../../../../../lib/tileSelector.png")]
		private var tileSelector:Class;
		
		private var selector:Bitmap;
		
		private var barracks:Bitmap;
		
		private var time:uint = 0;
		
		private var endX:uint;
		private var endY:uint;
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		private static var SPEED:Number = 300.0;
		
		private var gridBitmapData:BitmapData;
		
		private var grid:Bitmap;
		
		private var camera:Camera;
		
		private var stage:Stage;
		
		public function Game(s:Stage) 
		{
			stage = s;
			
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
			stage.addChild(camera.bitmap);
			
			barracks = new barracksImage();
			position.x = stage.stageWidth / 2 - barracks.width/2;
			position.y = stage.stageHeight / 2 - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
		}
		
		public function update(e:Event):void
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
			
			
			camera.bitmapData.copyPixels(grid.bitmapData, new Rectangle(0, 0, grid.width, grid.height), new Point(grid.x, grid.y));
			camera.bitmapData.copyPixels(selector.bitmapData, new Rectangle(0, 0, selector.width, selector.height), new Point(selector.x, selector.y), null, null, true);
			camera.bitmapData.copyPixels(barracks.bitmapData, new Rectangle(0, 0, barracks.width, barracks.height), new Point(barracks.x, barracks.y), null, null, true);
			
			time = newTime;
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