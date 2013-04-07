package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.RenderComponent;
	import com.menohack.glebforge.view.Animation;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Marine extends Entity
	{
		/*
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		
		[Embed(source = "../../../../../lib/MarineUp.png")]
		private static var marineUp:Class;
		[Embed(source = "../../../../../lib/MarineRight.png")]
		private static var marineRight:Class;
		[Embed(source = "../../../../../lib/MarineDown.png")]
		private static var marineDown:Class;
		[Embed(source = "../../../../../lib/MarineLeft.png")]
		private static var marineLeft:Class;
		*/
		[Embed(source = "../../../../../lib/terranmarine.png")]
		private static var marineSheet:Class;

		private var peasantDirection:Vector3D = new Vector3D;
		
		private var position:Point;
		
		private var testSpeed:Number = 3000.0;
		
		public function Marine(x:int, y:int)
		{
			peasantDirection.x = 0;
			peasantDirection.y = 0;
			
			//var peasant:Bitmap = new peasantImage();
			
			//Extract the upwards walk animation
			//Each frame can have a different height and width
			var sizes:Array = new Array(new Point(23, 30), new Point(23, 29), new Point(24,30), new Point(24,29), new Point(25,30), new Point(24,31), new Point(25,32), new Point(24,32), new Point(23,31));
			var positions:Array = new Array(new Point(1, 188), new Point(1, 232), new Point(1, 275), new Point(1, 319), new Point(1, 362), new Point(1, 406), new Point(1, 450), new Point(1, 495), new Point(1, 540));
			
			//var widths:Array = new Array(23, 23, 24, 24, 25, 24, 25, 24, 23);
			//var heights:Array = new Array(30, 29, 30, 29, 30, 31, 32, 32, 31);
			
			var bitmaps:Vector.<Bitmap> = ExtractWalkAnimation(positions, sizes);
			var ani:Animation = new Animation(bitmaps, 70);
			
			var render:RenderComponent = new RenderComponent(this, ani);
			AddComponent(render);
			
			//render.GetSprite().addChild(peasant);
			


			
			position = new Point();
			position.x = x;
			position.y = y;
			render.Position = new Point(x, y);
			
			var select:SelectableComponent = new SelectableComponent(this);
			AddComponent(select);
			select.Position = position;
			
			var pathing:PathingComponent = new PathingComponent(this);
			AddComponent(pathing);
			pathing.Position = position;
			
			/*
			var randomWalkTimer:Timer = new Timer(1000);
			randomWalkTimer.addEventListener(TimerEvent.TIMER, changeRandWalkDir)
			randomWalkTimer.start();
			*/
		}
		
		private function ExtractWalkAnimation(positions:Array, sizes:Array):Vector.<Bitmap>
		{
			var numFrames:uint = positions.length;
			
			var bitmaps:Vector.<Bitmap> = new Vector.<Bitmap>();
			var sheet:Bitmap = new marineSheet;
			
			for (var i:uint; i < numFrames; i++)
			{
				//var spriteWidth:uint;
				var xOffset:uint;
				if (sizes[i].x < 25)
				{
					//spriteWidth = 25;
					xOffset = 25 - sizes[i].x;
				}
				var bitmapData:BitmapData = new BitmapData(sizes[i].x + xOffset, sizes[i].y, true, 0x000000FF);
				bitmapData.copyPixels(sheet.bitmapData, new Rectangle(positions[i].x, positions[i].y, sizes[i].x, sizes[i].y), new Point(xOffset, 0));
				bitmaps.push(new Bitmap(bitmapData));
			}
			
			return bitmaps;
		}
		
		public function Update(delta:Number):void
		{
			//random walk AI logic, every second the direction changes
			/*
			peasantDirection.normalize();
			peasantDirection.scaleBy(testSpeed / 10 * delta / 1000);
			var render:RenderComponent = GetComponent(RenderComponent) as RenderComponent;
			render.Position = new Point(position.x + peasantDirection.x, position.y + peasantDirection.y);
			*/
			
			var render:RenderComponent = GetComponent(RenderComponent) as RenderComponent;
			var pc:PathingComponent = GetComponent(PathingComponent) as PathingComponent;
			pc.Update(delta);
			render.Position = pc.Position;
		}
		
		/*
		private function changeRandWalkDir(event:TimerEvent):void //changes the random walk direction when timer goes off
		{
			peasantDirection.x = Math.sin(Math.random()*360);
			peasantDirection.y = Math.sin(Math.random()*360);
		}
		*/
	}

}