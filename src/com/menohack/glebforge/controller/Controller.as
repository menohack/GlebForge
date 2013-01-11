package com.menohack.glebforge.controller 
{
	import com.menohack.glebforge.model.Model;
	import com.menohack.glebforge.view.View;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public interface Controller
	{
		function onKeyDown(e:KeyboardEvent):void;
		function onKeyUp(e:KeyboardEvent):void;
		function onMouseDown(e:MouseEvent):void;
		function onMouseUp(e:MouseEvent):void;
		function onMouseMove(e:MouseEvent):void;
		function SetView(view:View):void;
		function Update(delta:Number):void;
	}
	
}