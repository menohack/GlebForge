package com.menohack.glebforge.model 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class SelectableComponent extends Component
	{
		private var position:Point;
		
		private var selected:Boolean = false;
		
		public function SelectableComponent(parent:Entity) 
		{
			super("SelectableComponent", parent);
			World.GetInstance().AddSelectableComponent(this);
		}
	
		public function set Position(position:Point):void
		{
			this.position = position;
		}
		
		public function get Position():Point
		{
			return position;
		}
	
		public function set Selected(selected:Boolean):void
		{
			this.selected = selected;
		}
		
		public function get Selected():Boolean
		{
			return selected;
		}
	}

}