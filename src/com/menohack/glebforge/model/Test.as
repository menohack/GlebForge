package com.menohack.glebforge.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	/** This class is for testing ActionScript functionality without having to deal with
	 * 	the game complexity.
	 * 
	 * @author James Doverspike
	 */
	public class Test 
	{
		[Embed(source = "../../../../../lib/peasant.png")]
		private var peasantImage:Class;
		

		public function Test(stage:Stage) 
		{
			var camera:Sprite = new Sprite();
			var peasant:Bitmap = new peasantImage();
			peasant.x = 200;
			peasant.y = 200;
			
			var peasantSprite:Sprite = new Sprite();
			peasantSprite.addChild(peasant);
			peasantSprite.addEventListener(MouseEvent.CLICK, onClickPeasant);
			
			var bitmap:Bitmap = new Bitmap();
			bitmap.bitmapData = new BitmapData(400, 400);
			bitmap.bitmapData.fillRect(new Rectangle(0, 0, 400, 400), 0x80336699);
			
			var bitmapSprite:Sprite = new Sprite();
			bitmapSprite.addChild(bitmap);
			bitmapSprite.addEventListener(MouseEvent.CLICK, onClickBitmap);
			
			
			camera.addChild(bitmapSprite);
			camera.addChild(peasantSprite);
			camera.addEventListener(MouseEvent.CLICK, onClick);
			
			
			stage.addChild(camera);
			
		}
		private function onClick(e:MouseEvent):void
		{
			trace("Clicked camera!");
		}
		
		private function onClickPeasant(e:MouseEvent):void
		{
			trace("Clicked peasant!");
		}
		
		private function onClickBitmap(e:MouseEvent):void
		{
			trace("Clicked Bitmap");
		}
		
	}

}