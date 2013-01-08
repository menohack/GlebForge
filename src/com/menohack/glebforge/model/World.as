package com.menohack.glebforge.model 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class World 
	{
		private static var instance:World;
		
		private var players:Dictionary;
		
		public function World(e:SingletonEnforcer) 
		{
			players = new Dictionary();
		}
		
		public static function GetInstance():World
		{
			if (instance == null)
				instance = new World(new SingletonEnforcer());
				
			return instance;
		}
		
		public function AddPlayer(player:Player):void
		{
			players["fuck"] = player;
		}
	}

}

//Used to keep the contructor from being called externally. It can
//only be called in this file.
class SingletonEnforcer{}