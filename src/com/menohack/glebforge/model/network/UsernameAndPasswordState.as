package com.menohack.glebforge.model.network 
{
	import com.menohack.glebforge.model.NetworkComponent;
	import com.menohack.glebforge.model.network.PositionState;
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class UsernameAndPasswordState extends BaseState
	{
		private static var LOGIN_SUCCESSFUL_VALUE:int = 1337;
		
		public function UsernameAndPasswordState(network:NetworkComponent) 
		{
			super(network);
			
			Send();
		}
		
		private function Send():void
		{
			var ba:ByteArray = new ByteArray();
			
			//var name:String = "James";
			var name:String = "Gleb";
			ba.writeMultiByte(name, "us-ascii");
				
			//var buffer:ByteArray = new ByteArray();
			buffer.clear();
			buffer.length = 4;
			buffer.writeInt(ba.length);
			network.writeBytes(buffer, 0, 4);
			network.flush();
			
			network.writeBytes(ba, 0, ba.length);
			network.flush();
			
			//Write the password
			ba = new ByteArray();
			ba.length = 128;
			ba.writeMultiByte("glebpass", "us-ascii");
			for (var i:uint = ba.position; i < 128; i++)
				ba.writeMultiByte(" ", "us-ascii");
			network.writeBytes(ba, 0, 128);
			network.flush();
			
			network.SetState(new PositionState(network));
		}
		
		override public function Receive():void
		{
			buffer.clear();
			network.readBytes(buffer, 0, 4);
			
			var response:int = buffer.readInt();
			if (response != LOGIN_SUCCESSFUL_VALUE)
			{
				trace("Login failure");
			}
			else
			{
				trace("Logged in successfully!");
				network.SetState(new PositionState(network));
			}
		}
	}

}