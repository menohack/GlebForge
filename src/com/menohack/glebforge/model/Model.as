package com.menohack.glebforge.model 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public interface Model
	{
		function Update(delta:Number):void;
		//function onKeyDown(e:KeyboardEvent):void;
		//function onKeyUp(e:KeyboardEvent):void;
		//function onMouseDown(e:MouseEvent):void;
		//function onMouseUp(e:MouseEvent):void;
		//function onMouseMove(e:MouseEvent):void;
		//function SelectArea(topLeft:Point, bottomRight:Point):void;
		function GetSprites():Vector.<Sprite>;
		function Click(point:Point):void;

	}
	
}