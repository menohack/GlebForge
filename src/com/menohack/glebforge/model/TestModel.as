package com.menohack.glebforge.model 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import mx.core.BitmapAsset;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import com.menohack.glebforge.controller.Controller;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class TestModel implements Model, Controller
	{
		/**
		 * Below is some sample data for testing
		 */
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		
		private var peasantSprite1:Sprite;
		private var peasantSprite2:Sprite;
		
		private var rate:Number = 60;
		
		private var endPosition:Point;
		private var moveRate:Number = 60;
		
		public function TestModel() 
		{
			var peasantData:BitmapData = new BitmapData(200, 200);
			peasantData.draw(new peasantImage());
			
			peasantSprite1 = new Sprite();
			peasantSprite1.addChild(new Bitmap(peasantData));
			peasantSprite1.x = 200.0;
			peasantSprite1.y = 200.0;
			
			peasantSprite2 = new Sprite();
			peasantSprite2.addChild(new Bitmap(peasantData));
			peasantSprite2.x = 400.0;
			peasantSprite2.y = 200.0;
			
			endPosition = new Point(400.0, 200.0);
		}
		
		public function GetController():Controller
		{
			return this;
		}
		
		public function Update(delta:Number):void
		{
			
			peasantSprite1.y += rate * delta / 1000.0;
			if (peasantSprite1.y > 300.0)
				rate *= -1.0;
			else if (peasantSprite1.y < 200.0)
				rate *= -1.0;
				
			var position:Point = new Point(peasantSprite2.x, peasantSprite2.y);
			var distance:Number = endPosition.subtract(position).length;
			if (distance > 0.0)
			{
				var newPosition:Point = new Point(endPosition.x - position.x, endPosition.y - position.y);
				if (newPosition.length > moveRate*delta/1000.0)
					newPosition.normalize(moveRate*delta/1000.0);

				peasantSprite2.x += newPosition.x;
				peasantSprite2.y += newPosition.y;
			}
				
		}
		
		public function Click(point:Point):void
		{
			endPosition = point;
		}
		
		public function GetSprites():Vector.<Sprite>
		{
			var sprites:Vector.<Sprite> = new Vector.<Sprite>(2);
			sprites[0] = peasantSprite1;
			sprites[1] = peasantSprite2;
			
			return sprites;
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			trace("Key depressed!");
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			trace("Key released!");
		}
		
		public function onMouseDown(e:MouseEvent):void
		{
			endPosition = new Point(e.stageX, e.stageY);
		}
		
		public function onMouseUp(e:MouseEvent):void
		{
			
		}
		
		public function onMouseMove(e:MouseEvent):void
		{
			
		}
	}

}