package GlebForge
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import flash.geom.Vector3D;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	// Gary Oak was here. You cannot ignore his girth. This comment is just a test.
	public class Main extends Sprite 
	{
		[Embed(source = '../../lib/barracks.png')]
		private var barracksImage:Class;
		
		private var barracks:Bitmap;
		
		private var time:uint = 0;
		
		private var endX:uint;
		private var endY:uint;
		private var end:Vector3D = new Vector3D;
		
		private var position:Vector3D = new Vector3D;
		
		private static var SPEED:Number = 300.0;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.addEventListener(MouseEvent.CLICK, onMouseClick);
			stage.frameRate = 120;
			
			addChild(barracks = new barracksImage());
			position.x = stage.stageWidth / 2 - barracks.width/2;
			position.y = stage.stageHeight / 2 - barracks.height / 2;
			barracks.x = position.x;
			barracks.y = position.y;
			end = position;
			
			addEventListener(Event.ENTER_FRAME, create);
			//while (true)
			//	gameLoop();
		}
		
		private function create(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, create);
			
			
			addEventListener(Event.ENTER_FRAME, update);
		}
		
		private function update(e:Event):void
		{
			var newTime:uint = getTimer();
			var delta:uint = newTime - time;
			
			position.x = barracks.x;
			position.y = barracks.y;
			var direction:Vector3D = end.subtract(position);
			
			direction.normalize();
			direction.scaleBy(SPEED * delta / 1000);
				
			if (direction.x > 0)
			{
				if (barracks.x + direction.x > end.x)
					barracks.x = end.x;
				else
					barracks.x += direction.x;
			}
			else
			{
				if (barracks.x + direction.x < end.x)
					barracks.x = end.x;
				else
					barracks.x += direction.x;
			}
				
			if (direction.y > 0)
			{
				if (barracks.y + direction.y > end.y)
					barracks.y = end.y;
				else
					barracks.y += direction.y;
			}
			else
			{
				if (barracks.y + direction.y < end.y)
					barracks.y = end.y;
				else
					barracks.y += direction.y;
			}
			

			time = newTime;
		}
		
		private function onMouseClick(e:MouseEvent):void
		{
			end = new Vector3D(e.localX, e.localY, 0);
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			//barracks.x = e.localX;
			//barracks.y = e.localY;
		}
		
	}
	
}