package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.controller.Controller;
	import com.menohack.glebforge.view.View;
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
		function GetSprites():Vector.<Sprite>;
		function GetController():Controller;
		function SetView(view:View):void;
	}
	
}