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
		function DrawSelectArea(end:Point):void;
		function StopDrawingSelectArea():void;
		function StartDrawingSelectArea(start:Point):void;
		function Update(e:Event):void;
		function get Width():uint;
		function set Width(width:uint):void;
		function get Height():uint;
		function set Height(height:uint):void;
		function set Fullscreen(fullscreen:Boolean):void;
		function get Fullscreen():Boolean;

		function moveUp(delta:Number):void;
		function moveDown(delta:Number):void;
		function moveLeft(delta:Number):void;
		function moveRight(delta:Number):void;
	}
}