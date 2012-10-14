package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.RenderComponent;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class SelectableComponent 
	{
		private var render:RenderComponent;
		
		public function SelectableComponent(render:RenderComponent) 
		{
			this.render = render;
			render.addEventListener(MouseEvent.CLICK, onSelect);
		}
		
		private function onSelect(event:MouseEvent):void
		{
			
		}
	
		
	}

}