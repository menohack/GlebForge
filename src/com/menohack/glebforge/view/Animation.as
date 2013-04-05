package com.menohack.glebforge.view 
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/** A collection of sprites for animated units.
	 * 
	 * @author James Doverspike
	 */
	public class Animation 
	{
		private var images:Sprite = new Sprite;
		
		private var delay:Number
		
		private var timer:Timer;
		
		private var frame:uint;
		
		public function Animation(bitmaps:Vector.<Bitmap>, delay:Number) 
		{
			if (bitmaps.length == 0)
				return;
				
			for each (var b:Bitmap in bitmaps)
			{
				b.visible = false;
				this.images.addChild(b);
			}
			
			this.delay = delay;
			
			this.frame = 0;
			images.getChildAt(frame).visible = true;
			
			if (delay < 20.0)
				delay = 20.0;
			timer = new Timer(delay);
			timer.addEventListener(TimerEvent.TIMER, SwitchFrame);
			timer.start();
		}
		
		public function GetSprite():Sprite
		{
			return images;
		}
		
		private function SwitchFrame(event:TimerEvent):void
		{
			//Set old frame invisible
			images.getChildAt(frame).visible = false;
			
			//Check if last frame, reset to 0
			if (++frame >= images.numChildren)
				frame = 0;
			
			//Set new frame visible. All other frames are invisible.
			images.getChildAt(frame).visible = true;
		}
	}

}