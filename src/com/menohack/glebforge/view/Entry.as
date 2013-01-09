package com.menohack.glebforge.view
{
	import com.menohack.glebforge.controller.Controller;
	import com.menohack.glebforge.controller.Input;
	import com.menohack.glebforge.model.Game;
	import com.menohack.glebforge.model.Model;
	import com.menohack.glebforge.model.Test;
	import com.menohack.glebforge.model.TestModel;
	
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
	[SWF(width="640", height="480")]
	public class Entry extends Sprite 
	{
		private var game:Model;
		private var controller:Controller;
		private var view:View;
		
		public function Entry():void 
		{
			var testing:Boolean = false;
			
			if (testing)
			{
				//if (stage) test();
				//else addEventListener(Event.ADDED_TO_STAGE, test);
			}
			else
			{
				if (stage) init();
				else addEventListener(Event.ADDED_TO_STAGE, init);
			}
		}
		/*
		private function test(e:Event = null):void
		{
			//var test:Test = new Test(stage);
			
			var model:Model = new TestModel();
			var view:View = new TestView(model, stage);
			
			var controller:Controller = model.GetController();
			
			//Disable right click
			stage.addEventListener(MouseEvent.RIGHT_CLICK, function(e:Event):void { } );
			
			stage.frameRate = 60;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, controller.onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, controller.onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, controller.onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, controller.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, controller.onKeyUp);
			
			addEventListener(Event.ENTER_FRAME, view.Update);
		}
		*/
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			game = new Game(stage);
			view = new UI(game, stage);
			game.SetView(view);
			controller = game.GetController();
			
			var camera:Camera;
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, controller.onMouseMove);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, controller.onMouseDown);
			stage.addEventListener(MouseEvent.MOUSE_UP, controller.onMouseUp);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, controller.onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, controller.onKeyUp);
			
			//Disable right click
			stage.addEventListener(MouseEvent.RIGHT_CLICK, function(e:Event):void { } );
			
			stage.frameRate = 120;
			
			
			
			//Change this to view.Update and remove the create function when you can
			addEventListener(Event.ENTER_FRAME, create);
		}
		
		private function create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, create);
			
			
			addEventListener(Event.ENTER_FRAME, view.Update);
		}
	}
	
}