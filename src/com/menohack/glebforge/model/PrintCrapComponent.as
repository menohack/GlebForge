package com.menohack.glebforge.model 
{
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class PrintCrapComponent extends Component
	{
		
		public function PrintCrapComponent()
		{
			super("PrintCrapComponent");
		}
		
		public function doit():void
		{
			trace("CRAP!");
		}
	}

}