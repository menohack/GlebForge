package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.View;
	import flash.geom.Point;
	
	/**
	 * The SelectArea class represents a player's rectangular selection of units.
	 * 
	 * @author James Doverspike
	 */
	public class SelectArea 
	{
		private var topLeft:Point;
		private var bottomRight:Point;
		
		public function SelectArea()
		{
			topLeft = new Point();
			bottomRight = new Point();
		}
		
		public function set TopLeft(topLeft:Point):void
		{
			this.topLeft = topLeft;
		}
		
		public function get TopLeft():Point
		{
			return topLeft;
		}
		
		public function set BottomRight(bottomRight:Point):void
		{
			this.bottomRight = bottomRight;
		}
		
		public function get BottomRight():Point
		{
			return bottomRight;
		}
		
		/**
		 * Select the current units between topLeft and bottomRight.
		 * @param	view The View. We should find a better way to access this.
		 */
		public function Select():void
		{
			if (topLeft == null || bottomRight == null)
				return;
			
			for each(var sc:SelectableComponent in World.GetInstance().SelectableComponents)
			{
				var p:Point = sc.Position;
				
				var left:Point = p.subtract(topLeft);
				var right:Point = bottomRight.subtract(p);
				if (left.x < 0 || left.y < 0 || right.x < 0 || right.y < 0)
				{
					sc.Selected = false;
					continue;
				}
				
				//This object was selected
				sc.Selected = true;
			}
			
			
		}
	}

}