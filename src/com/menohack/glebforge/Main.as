package com.menohack.glebforge
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.ui.Mouse;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Main extends Sprite 
	{
		[Embed(source="../../../../lib/barracks.png")]
		private var barracksImage:Class;
		
		[Embed(source="../../../../lib/blueTile.png")]
		private var blueTile:Class;
		
		[Embed(source = "../../../../lib/greyTile.png")]
		private var greyTile:Class;
		
		[Embed(source = "../../../../lib/mustardTile.png")]
		private var mustardTile:Class;
		
		[Embed(source = "../../../../lib/tileSelector.png")]
		private var tileSelector:Class;
		
		private var selector:Bitmap;
		
		private var barracks:Bitmap;
		
		private var time:uint = 0;
		
		private var endX:uint;
		private var endY:uint;
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		private static var SPEED:Number = 300.0;
		
		private var grid:BitmapData;
		
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
			stage.frameRate = 120;
			//Mouse.hide();
			
			grid = new BitmapData(stage.stageWidth, stage.stageHeight);
			
			var tiles:Array = new Array(new greyTile(), new blueTile(), new mustardTile());
			
			for (var i:uint = 0; i * 41 < stage.stageWidth; i++)
			{
				for (var j:uint = 0; j * 41 < stage.stageHeight; j++)
				{
					var random:uint = uint(Math.random() * 3);
					var tile:Bitmap = tiles[random];
					grid.copyPixels(tile.bitmapData, new Rectangle(0, 0, tile.width, tile.height), new Point(i * 41, j * 41));
				}
			}
			var gridBitmap:Bitmap = new Bitmap(grid);
			addChild(gridBitmap);
			
			selector = new tileSelector();
			addChild(selector);
			
			addChild(barracks = new barracksImage());
			position.x = stage.stageWidth / 2 - barracks.width/2;
			position.y = stage.stageHeight / 2 - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
			
			
			addEventListener(Event.ENTER_FRAME, create);
			//while (true)
			//	gameLoop();
		}
		
		private function create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, create);
			
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
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
			

			time = newTime;
		}
		
		private function drawTileSelector(x:int, y:int):void
		{
			if (x > stage.stageWidth || x < 0 || y > stage.stageHeight || y < 0)
				selector.visible = false;
			else
			{
				selector.x = Math.floor((x) / selector.width) * selector.width;
				selector.y = Math.floor((y) / selector.height) * selector.height;
				selector.visible = true;
			}
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			end = new Vector3D(e.localX, e.localY, 0);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			drawTileSelector(e.localX, e.localY);
		}
		
	}
	
}