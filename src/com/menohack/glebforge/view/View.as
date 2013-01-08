package com.menohack.glebforge.view 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public interface View 
	{
		function AddSprite(sprite:Sprite):void
		function drawSelectArea(end:Point):void
	}
	
}