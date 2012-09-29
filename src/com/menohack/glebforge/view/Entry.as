package com.menohack.glebforge.view
{
	import com.menohack.glebforge.model.Game;
	import com.menohack.glebforge.model.Model;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	import flash.ui.Mouse;
	import flash.ui.Keyboard;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	// Gary Oak was here. You cannot ignore his girth. This comment is just a test.
	public class Entry extends Sprite 
	{
		private var game:Model;
		
		public function Entry():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			game = new Game(stage);
			
			var camera:Camera;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, game.onMouseMove);
			stage.addEventListener(MouseEvent.CLICK, game.onMouseClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, game.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, game.onKeyUp);
			stage.frameRate = 120;
			//Mouse.hide();
			
			
			
			addEventListener(Event.ENTER_FRAME, create);
		}
		
		private function create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, create);
			
			
			addEventListener(Event.ENTER_FRAME, game.update);
		}
		
		

		
	}
	
}