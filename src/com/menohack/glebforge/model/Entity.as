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