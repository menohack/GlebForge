package com.menohack.glebforge.test 
{
	import com.menohack.glebforge.model.Entity;
	import com.menohack.glebforge.view.RenderComponent;
	import com.menohack.glebforge.model.Component;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	internal class EntityTest extends Entity
	{
		
		public function EntityTest()
		{
		}
		
		public function AddComponentTest():void
		{
			AddComponent(new RenderComponent());
			trace(GetClass(new RenderComponent()));
		}
	}

}