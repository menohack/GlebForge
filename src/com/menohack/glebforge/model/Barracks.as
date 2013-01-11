package com.menohack.glebforge.model 
{
	import flash.geom.Vector3D;
	import flash.display.Bitmap;
	
	/**
	 * I extracted all of the old barracks code from Game and put it here.
	 * I am not sure if we will be keeping this class, but I didn't want to
	 * lose the code.
	 * 
	 * @author James Doverspike
	 */
	public class Barracks 
	{
		[Embed(source="../../../../../lib/shittybarracks.png")]
		private var barracksImage:Class;

		private var barracks:Bitmap;
		
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		public static var SPEED:Number = 300.0;
		
		public function Barracks(x:Number, y:Number) 
		{
			barracks = new barracksImage();
			position.x = x - barracks.width/2;
			position.y = y - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
		}
		
		public function Update(delta:Number):void
		{
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
			
		}
		
	}

}