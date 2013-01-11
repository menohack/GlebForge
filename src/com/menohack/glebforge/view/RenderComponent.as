package com.menohack.glebforge.view 
{
	import com.menohack.glebforge.model.Component;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.geom.Point;
	import com.menohack.glebforge.model.World;
	
	/**
	 * The RenderComponent class is added to any Entity that needs to be rendered.
	 * On creation it automatically adds itself to the World's list of other
	 * components. Entities are queued for drawing by adding a RenderComponent and
	 * adding a bitmap or sprite to the RenderComponent.
	 * 
	 * This class will asynchronously load bitmaps in the future to decrease
	 * the size of the executable.
	 * 
	 * @author James Doverspike
	 */
	public class RenderComponent extends Component
	{
		private var camera:Camera;

		private var sprite:Sprite;
		
		public function RenderComponent() 
		{
			super("RenderComponent");
			
			this.sprite = new Sprite();
			
			World.GetInstance().AddRenderComponent(this);
		}
		/*
		public function set Bitmap(bitmap:Bitmap):void
		{	
			if (sprite.numChildren > 0)
				sprite.removeChildren(0, sprite.numChildren-1);
			sprite.addChild(bitmap);
		}
		*/
		public function GetSprite():Sprite
		{
			return sprite;
		}
		
		public function set Position(position:Point):void
		{
			sprite.x = position.x;
			sprite.y = position.y;
		}
		
		public function get Position():Point
		{
			return new Point(sprite.x, sprite.y);
		}
		
		/*
		private function onComplete(e:Event):void
		{
			var info:LoaderInfo = e.target as LoaderInfo;
			bitmap = info.content as Bitmap;
			bitmapData = bitmap.bitmapData;
			
			shape = new Rectangle(0, 0, bitmap.width, bitmap.height);
			position = new Point(0, 0);
		}
		public function load(filename:String):void
		{
			//TODO: Error checking on the filename
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest(filename));
		}
		*/	
	}
}