package com.menohack.glebforge.model 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public interface Model 
	{
		function Model();
		function update(e:Event):void;
		function onKeyDown(e:KeyboardEvent):void;
		function onKeyUp(e:KeyboardEvent):void;
		function onMouseDown(e:MouseEvent):void;
		function onMouseUp(e:MouseEvent):void;
		function onMouseMove(e:MouseEvent):void;

	}
	
}