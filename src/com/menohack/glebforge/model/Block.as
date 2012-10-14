package com.menohack.glebforge.model 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Block extends Bitmap
	{
		private var xSlot:uint;
		private var ySlot:uint;
		
		public function Block(bitmapData:BitmapData, x:int, y:int) 
		{
			super(bitmapData);
			this.x = Map.TILE_WIDTH * Map.BLOCK_DIM * x;
			this.y = Map.TILE_HEIGHT * Map.BLOCK_DIM * y;
			xSlot = x;
			ySlot = y;
		}
		
		public function isSamePosition(x:int, y:int):Boolean
		{
			if (x != xSlot || y != ySlot)
				return false;
			else 
				return true;
		}
		
	}

}