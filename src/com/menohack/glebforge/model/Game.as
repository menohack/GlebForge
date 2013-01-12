package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.controller.Controller;
	import com.menohack.glebforge.controller.Input;
	import com.menohack.glebforge.model.network.NetworkAdapter;
	import com.menohack.glebforge.model.network.NetworkComponent;
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.RenderComponent;
	import com.menohack.glebforge.view.View;
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	
	/**
	 * The Game class implements the Model interface and represents the logic of the game.
	 * It exposes functions by which the View may access it. The Controller is part of the
	 * model, and implemented by the Controller interface of the Input class.
	 * 
	 * @author James Doverspike
	 */
	public class Game implements Model
	{
		/**
		 * The 2D map on which players move.
		 */
		private var map:Map;
		
		//Still needs some refactoring
		private var networkComponent:NetworkComponent;
		private var networkAdapter:NetworkAdapter;
		
		/**
		 * The current player.
		 */
		public var player1:Player;	
		
		/**
		 * The View object.
		 */
		public var display:View;
		
		/**
		 * The Controller object.
		 */
		private var input:Controller;
		
		private var selectArea:SelectArea;

		/**
		 * Default constructor.
		 */
		public function Game() 
		{
			selectArea = new SelectArea();
			input = new Input(selectArea);
			
			//Make a 10x10 block map, centered at (0,0)
			map = new Map();
			for (var bx:int = -5; bx < 5; bx++)
				for (var by:int = -5; by < 5; by++)
					map.addBlock(bx, by);
			
			
			//acm main: 128.220.251.35
			//var ip:String = "128.220.251.35";
			//acm http: 128.220.70.65
			//var ip:String = "128.220.70.65";
			//localhost: 127.0.0.1
			var ip:String = "127.0.0.1";

			networkAdapter = new NetworkAdapter();
			networkComponent = new NetworkComponent(networkAdapter, ip, 11000);
			
			new Music();
		}
		
		/**
		 * Temporary until I come up with a better solution. Need the view to do
		 * this stuff but the view needs the model for contruction.
		 */
		private function DoStuff():void
		{
			player1 = new Player(display.Width / 2 + 200, display.Height / 2);
			var player2:Player = new Player(display.Width / 2, display.Height / 2 - 100);
		}
		
		/**
		 * Sets the View.
		 * @param	view The View.
		 */
		public function SetView(view:View):void
		{
			display = view;
			input.SetView(view);
			DoStuff();
		}
		
		/**
		 * Gets the Controller from the Model.
		 * @return The Controller.
		 */
		public function GetController():Controller
		{
			return input;
		}
		
		/**
		 * Updates the game.
		 * @param	delta The time in milliseconds since the last update.
		 */
		public function Update(delta:Number):void
		{			
			player1.update(delta);
			
			input.Update(delta);
		}
		
		/**
		 * Gets a vector containing all of the sprites that should be drawn for the given frame.
		 * @param	delta The change in milliseconds since the last frame.
		 * @return	Returns a vector containing the sprites.
		 */
		public function GetSprites():Vector.<Sprite>
		{
			for each(var s:SelectableComponent in World.GetInstance().SelectableComponents)
			{
				//TODO: Error checking on this
				var rc:RenderComponent = s.Parent.GetComponent(RenderComponent) as RenderComponent;
				if (s.Selected)
					rc.Select();
				else
					rc.Deselect();
			}
			
			var sprites:Vector.<Sprite> = new Vector.<Sprite>();
			for each (var r:RenderComponent in World.GetInstance().RenderComponents)
				sprites.push(r.GetSprite());
			


			return sprites;
		}
		
		

	}

}