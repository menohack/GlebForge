package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.RenderComponent;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getDefinitionByName;
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
		
		/**
		 * Adds a component to an entity as long as the entity has no components of this type.
		 * @param	component The component to add
		 * @return
		 */
		protected function AddComponent(component:Component):Boolean
		{
			if (HasComponent(GetClass(component)))
				return false;
				
			components.push(component);
			return true;
		}
		
		protected function RemoveComponent(component:Component):Boolean
		{
			if (!HasComponent(GetClass(component)))
				return false;
				
			throw "Not done";
		}
		
		/**
		 * Gets a component from an entity, if it exists.
		 * @param	component The component for which to search.
		 * @return Returns the first component with the same type.
		 */
		protected function GetComponent(component:Class):Component
		{
			//We should check that component is a derived class of Component, not sure how.
			
			for each (var c:Component in components)
				if (c is component)
					return c;
			return null;
		}
		
		/**
		 * Searches for one instance of a given component.
		 * @param	component The component for which to search.
		 * @return Returns true if the component was found, false otherwise.
		 */
		protected function HasComponent(component:Class):Boolean
		{
			//We should check that component is a derived class of Component, not sure how.
				
			for each (var c:Component in components)
				if (c is component)
					return true;
					
			return false;
		}
		
		/**
		 * Gets the Class of an object.
		 * @param	object The object.
		 * @return Returns the class of the object.
		 */
		public static function GetClass(object:Object):Class
		{
			return Class(getDefinitionByName(getQualifiedClassName(object)));
		}
	}
}