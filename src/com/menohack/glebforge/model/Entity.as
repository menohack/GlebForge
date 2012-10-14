package com.menohack.glebforge.model 
{
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Entity 
	{
		private var components:Vector.<Component>;
		
		public function Entity() 
		{
			components = new Vector.<Component>();
		}
		
		protected function addComponent(c:Component):void
		{
			components.push(c);
		}
		
		protected function getComponent(name:String):Component
		{
			for each (var derp:Component in components)
				if (derp.name == name)
					return derp;
			return null;
		}
		
	}

}

	//Component-based option one:
	/*
	public class Player extends Entity
	{

		public function Player()
		{
			addComponent(Component(new PrintCrapComponent()));
			addComponent(Component(new PrintShitComponent()));
		}
		
		public function play():void
		{
			var derp:PrintShitComponent = getComponent("PrintShitComponent") as PrintShitComponent;
			if (derp != null)
				derp.print();
			
			var herp:PrintCrapComponent = getComponent("PrintCrapComponent") as PrintCrapComponent;
			if (herp != null)
				herp.doit();
		}
	}
	*/