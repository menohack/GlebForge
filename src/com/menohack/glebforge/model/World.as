package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.RenderComponent;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class World 
	{
		private static var instance:World;
		
		private var renderComponents:Vector.<RenderComponent>;
		
		private var selectableComponents:Vector.<SelectableComponent>;
		
		public function World(e:SingletonEnforcer) 
		{
			renderComponents = new Vector.<RenderComponent>();
			selectableComponents = new Vector.<SelectableComponent>();
		}
		
		/**
		 * Gets the static instance of the World.
		 * @return The instance of the World.
		 */
		public static function GetInstance():World
		{
			if (instance == null)
				instance = new World(new SingletonEnforcer());
				
			return instance;
		}
		
		public function get RenderComponents():Vector.<RenderComponent>
		{
			return renderComponents;
		}
		
		public function AddRenderComponent(renderComponent:RenderComponent):void
		{
			renderComponents.push(renderComponent);
		}
		
		public function get SelectableComponents():Vector.<SelectableComponent>
		{
			return selectableComponents;
		}
		
		public function AddSelectableComponent(selectableComponent:SelectableComponent):void
		{
			selectableComponents.push(selectableComponent);
		}
	}

}

/**
 * Used to keep the contructor from being called externally. It can
 * only be called in this file.
 */
class SingletonEnforcer{}