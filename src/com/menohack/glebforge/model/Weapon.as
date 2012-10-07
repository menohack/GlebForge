package com.menohack.glebforge.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	
	
	/**
	 * ...
	 * @author Gleb Vorobjev
	 */
	public class Weapon extends GameObject //wepon!
	{
		//embed weapon images
		[Embed(source = "../../../../../lib/ironaxe.png")]
		private var axeImage:Class;
		private var axeSprite:Bitmap = new axeImage();
		
		
		//public for now
		public var attack:uint;
		public var toHit:uint;
		public var critical:Number;
		
		public var chopsTrees:Boolean;
		public var minesOre:Boolean;
		
		public var pickedUp:Boolean;
		
		
		public function Weapon(input:String) 
		{
			switch(input) {
				case 'sword':
					attack = 3;
					toHit = 1;
					critical = 0.0;
					chopsTrees = false;
					minesOre = false;
					pickedUp = false;
					
					trace("A sword was made");
					break;
					
				case 'axe':
					attack = 1;
					toHit = 1;
					critical = 0.0;
					chopsTrees = true;
					minesOre = false;
					pickedUp = false;
					
					this.addChild(axeSprite);
					
					trace("A wood axe was made");
					break;
					
				case 'pickaxe':
					attack = 1;
					toHit = 1;
					critical = 0.0;
					chopsTrees = false;
					minesOre = true;
					pickedUp = false;
					
					trace("A pickaxe was made");
					break;
				
				default:
					trace("No such weapon exists");
			}
			
			this.addEventListener(MouseEvent.CLICK, pickUp);
		}
		
		
		public function pickUp(e:MouseEvent):void
		{
			stage.removeChild(this);
			trace("deleted!");
		}
	}

}