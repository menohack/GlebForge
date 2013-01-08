package com.menohack.glebforge.view 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public interface View 
	{
		function AddSprite(sprite:Sprite):void;
		function DrawSelectArea(end:Point):void;
		function StopDrawingSelectArea():void;
		function StartDrawingSelectArea(start:Point):void;
		//Not sure if I want to keep this, maybe the view should update the model
		function Update(e:Event):void;
	}
	
}