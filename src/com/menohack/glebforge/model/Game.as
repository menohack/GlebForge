package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.controller.Controller;
	import com.menohack.glebforge.model.network.NetworkAdapter;
	import com.menohack.glebforge.model.network.NetworkComponent;
	import com.menohack.glebforge.view.RenderComponent;
	import com.menohack.glebforge.view.UI;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.utils.getTimer;
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
		

		
		private var selector:Bitmap;
		
		private var barracks:Bitmap;
		
		private var time:uint = 0;
		
		private var endX:uint;
		private var endY:uint;
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		public static var SPEED:Number = 300.0;
		
		private var camera:Camera;
		
		private var stage:Stage;
		
		private var map:Map;
		
		public var otherPlayer:Point;
		
		public var me:Point;
		
		private var networkComponent:NetworkComponent;
		private var networkAdapter:NetworkAdapter;
		
		public var player1:Player;
		
		
		private var controller:Controller;
		
		
		private var fullscreen:Boolean = false;
		
		public var ui:UI;
		
		//private var otherPlayers:Vector.<Point> = new Vector.<Point>;
		
		private var otherSprites:Sprite = new Sprite();
		
		public function Game(s:Stage, ui:UI, camera:Camera, controller:Controller) 
		{
			this.controller = controller;
			stage = s;
			//s.displayState = "fullScreen";
			stage.scaleMode = StageScaleMode.EXACT_FIT;
			
			selector = new tileSelector();
			
			/*
			camera = new Camera(stage.stageWidth, stage.stageHeight);
			stage.addChild(camera);
			*/
			this.camera = camera;
			
			/*
			map = new Map(camera);
			for (var bx:int = -5; bx < 5; bx++)
				for (var by:int = -5; by < 5; by++)
					map.addBlock(bx, by);
			*/
			barracks = new barracksImage();
			position.x = stage.stageWidth / 2 - barracks.width/2;
			position.y = stage.stageHeight / 2 - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
			
			player1 = new Player(barracks.x + 200, barracks.y, camera);
			/*
			peasant = new peasantImage();
			peasant.x = barracks.x + 200;
			peasant.y = barracks.y;
			peasantDirection.x = 0;
			peasantDirection.y = 0;
			*/
			
			/*
			var axe:Weapon = new Weapon('axe');
			axe.x = barracks.x + 100;
			axe.y = barracks.y + 100;
			
			stage.addChild(axe);
			*/
			
			//acm main: 128.220.251.35
			//var ip:String = "128.220.251.35";
			//acm http: 128.220.70.65
			//var ip:String = "128.220.70.65";
			//localhost: 127.0.0.1
			var ip:String = "127.0.0.1";
			otherPlayer = new Point(200, 200);
			me = new Point(400, 200);

			networkAdapter = new NetworkAdapter();
			networkComponent = new NetworkComponent(networkAdapter, ip, 11000);
			
			new Music();
			
			this.ui = ui;
			//ui = new UI(stage);
			
			
			
			camera.addChild(otherSprites);
		}
		
		public function Update():void
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
			
			player1.update(delta);
			
			//I dunno about this
			//controller.Update(delta);
			
			time = newTime;
		}
		
		private function draw():void
		{
			//map.draw();
			//camera.bitmapData.copyPixels(grid.bitmapData, new Rectangle(0, 0, grid.width, grid.height), new Point(grid.x, grid.y));
			//camera.bitmapData.copyPixels(selector.bitmapData, new Rectangle(0, 0, selector.width, selector.height), new Point(selector.x, selector.y), null, null, true);
			//player1.draw();
			//camera.bitmapData.copyPixels(peasant.bitmapData, new Rectangle(0, 0, peasant.width, peasant.height), new Point(otherPlayer.x, otherPlayer.y), null, null, true);
			//camera.bitmapData.copyPixels(barracks.bitmapData, new Rectangle(0, 0, barracks.width, barracks.height), new Point(barracks.x, barracks.y), null, null, true);
			
			
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
		

		
		
		
		
		

		
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		
		private function loadOtherPlayers(otherPlayers:Vector.<Point>):void
		{
			//this.otherPlayers = otherPlayers;
			
			var numChildren:int = otherSprites.numChildren;
			if (otherSprites.numChildren > 0)
				otherSprites.removeChildren(0, numChildren);
			
			for (var i:int = 0; i < otherPlayers.length; i++)
			{
				var sprite:Sprite = new Sprite();
				sprite.addChild(new peasantImage());
				sprite.x = otherPlayers[i].x;
				sprite.y = otherPlayers[i].y;
				
				otherSprites.addChild(sprite);
			}
			
			trace("Drawing " + otherPlayers.length + " other players");
		}
		
		/**
		 * This function is called by the controller to signal that an area was selected.
		 * @param	topLeft	The top left position of the box.
		 * @param	bottomRight	The bottom right position of the box.
		 */
		public function SelectArea(topLeft:Point, bottomRight:Point):void
		{
			
		}
		
		/**
		 * Gets a vector containing all of the sprites that should be drawn for the given frame.
		 * @param	delta The change in milliseconds since the last frame.
		 * @return	Returns a vector containing the sprites.
		 */
		public function GetSprites(delta:Number):Vector.<Sprite>
		{
			var sprites:Vector.<Sprite> = new Vector.<Sprite>(10);
			sprites[0] = new Sprite();
			
			return sprites;
		}
		
	}

}