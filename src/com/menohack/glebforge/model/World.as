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
		
		private var players:Dictionary;
		
		private var renderComponents:Vector.<RenderComponent>;
		
		public function World(e:SingletonEnforcer) 
		{
			players = new Dictionary();
			
			renderComponents = new Vector.<RenderComponent>();
		}
		
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
		
	}

}

//Used to keep the contructor from being called externally. It can
//only be called in this file.
class SingletonEnforcer{}