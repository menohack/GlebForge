package com.menohack.glebforge.view 
{
	import flash.display.Stage;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class UI 
	{
		[Embed(source = "../../../../../lib/ui.png")]
		private var uiImage:Class;
		
		public function UI(stage:Stage) 
		{
			stage.addChild(new uiImage());
		}
		
	}

}