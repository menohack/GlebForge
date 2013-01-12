package com.menohack.glebforge.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class UI 
	{
		[Embed(source = "../../../../../lib/ui.png")]
		private var uiImage:Class;
		
		private var sprite:Sprite;
		
		public function UI() 
		{
			sprite = new Sprite();
			var bitmap:Bitmap = new uiImage();
			sprite.addChild(bitmap);
			
			//Setting mouseEnabled to false allows mouse events to pass
			//through to sprites behind the UI (including transparent)
			//TODO: Allow clicking through transparency or divide the
			//UI into multiple sections and set mouseChildren = true
			sprite.mouseEnabled = false;
		}
		
		public function get Image():Sprite
		{
			return sprite;
		}
		
	}

}