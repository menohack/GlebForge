package com.menohack.glebforge.model 
{
	/**
	 * ...
	 * @author James Doverspike
	 */
	
	//Component-based option one:
	//*
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
		//*/
		
	//Component-based option two:
	/*
	public class Player
	{
		private var psc:PrintShitComponent;
		private var pcc:PrintCrapComponent;
		
		public function Player()
		{
			psc = new PrintShitComponent();
			pcc = new PrintCrapComponent();
		}
		
		public function play():void
		{
			psc.print();
			pcc.doit();
		}
	*/
	}

}