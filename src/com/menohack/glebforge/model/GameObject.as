package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.View;
	import flash.display.Sprite;
	
	
	/**
	 * ...
	 * @author Gleb Vorobjev
	 */
	public class GameObject extends Sprite //Base class. Right now I have no idea what should be put in here.
	{
		
		public function GameObject() 
		{
			
		}
		
		public function SetVisible(view:View):void
		{
			view.AddSprite(this);
		}
		
	}

}