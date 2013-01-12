package com.menohack.glebforge.model 
{
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Component 
	{
		private var name:String;
		
		private var parent:Entity;
		
		public function Component(name:String, parent:Entity) 
		{
			this.name = name;
			this.parent = parent;
		}
		
		public function get Parent():Entity
		{
			return parent;
		}
		
		public function set Parent(entity:Entity):void
		{
			parent = entity;
		}
	}

}