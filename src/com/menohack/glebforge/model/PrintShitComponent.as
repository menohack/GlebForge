package com.menohack.glebforge.model 
{
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class PrintShitComponent extends Component
	{
		
		public function PrintShitComponent()
		{
			super("PrintShitComponent");
		}
		
		public function print():void
		{
			trace("SHIT!");
		}
		
	}

}