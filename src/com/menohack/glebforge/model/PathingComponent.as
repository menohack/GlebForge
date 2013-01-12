package com.menohack.glebforge.model 
{
	import flash.geom.Point;
	import com.menohack.glebforge.view.RenderComponent;
	
	/**
	 * The PathingComponent contains the logic for pathfinding.
	 * 
	 * @author James Doverspike
	 */
	public class PathingComponent extends Component 
	{
		private var position:Point;
		
		private var end:Point;
		
		private var moving:Boolean;
		
		public function PathingComponent(parent:Entity) 
		{
			super("PathingComponent", parent);
			position = new Point();
			end = new Point();
			moving = false;
			
			World.GetInstance().AddPathingComponent(this);
		}
		
		public function get Position():Point
		{
			return position;
		}
		
		public function set Position(position:Point):void
		{
			this.position = position;
		}
		
		public function MoveTo(point:Point):void
		{
			var rc:RenderComponent = Parent.GetComponent(RenderComponent) as RenderComponent
			if (rc == null)
				return;
			var start:Point = rc.Position;
			position = start;
			end = point;
			if (end.subtract(position).length > 0.0)
				moving = true;
			
			//trace("Moving from " + start + " to " + point + " and moving is " + moving);
		}
		
		private function ComputePath(point:Point):void
		{
			
		}
		
		private var SPEED:Number = 100;
		
		public function Update(delta:Number):void
		{
			if (!moving)
				return;
			
			var direction:Point = end.subtract(position);
			if (direction.length > SPEED * delta / 1000.0)
				direction.normalize(SPEED*delta/1000.0);
			position = position.add(direction);
		}
		
	}

}