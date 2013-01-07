package com.menohack.glebforge.model.network 
{
	import com.menohack.glebforge.model.NetworkComponent;
	import flash.geom.Point;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class PositionState extends BaseState
	{	
		private var otherPlayers:Vector.<Point>;
		private var me:Point = new Point(550.0, 233.0);
		private var readNumPlayers:Boolean = false;
		
		public function PositionState(network:NetworkComponent)
		{
			super(network);
			
			WritePosition()
		}
		override public function Receive():void
		{
			try
			{
				if (!readNumPlayers)
				{
					var players:uint = ReadNumPlayers();
					readNumPlayers = true;
				}
				ReadPosition(players);
				WritePosition();
			}
			catch (e:String)
			{
				trace(e);
			}
		}
		
		private function ReadNumPlayers():uint
		{
			if (network.bytesAvailable < 4)
				throw "Bytes not available in ReadNumPlayers()";
			
			buffer.clear();
			buffer.length = 4;
			network.readBytes(buffer, 0, 4);
			var numNearbyPlayers:uint = buffer.readInt();
			return numNearbyPlayers;
		}
		
		private function ReadPosition(numNearbyPlayers:uint):void
		{
			//trace("Reading position with " + network.bytesAvailable + " bytes available and " + network.bytesPending + " bytes pending");
			if (network.bytesAvailable < numNearbyPlayers * 8)
				throw "Bytes not available in ReadPosition()";
			
			buffer.clear();
			buffer.length = numNearbyPlayers * 8;
			network.readBytes(buffer, 0, buffer.length);
			
			otherPlayers = new Vector.<Point>;
			for (var i:int = 0; i < numNearbyPlayers; i++)
			{
				var point:Point = new Point(buffer.readFloat(), buffer.readFloat());
				otherPlayers.push(point);
				trace     ("read " + point);
			}
			//No callback to draw the players for now
			//loadOtherPlayers(otherPlayers);
		}
		
		private function WritePosition():void
		{
			buffer.clear();
			buffer.writeFloat(me.x);
			buffer.writeFloat(me.y);
			network.writeBytes(buffer, 0, 8);
			network.flush();
		}
	}

}