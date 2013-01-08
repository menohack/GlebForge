package com.menohack.glebforge.model.network 
{
	import com.menohack.glebforge.model.network.NetworkComponent;
	import com.menohack.glebforge.model.network.UsernameAndPasswordState;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class AuthenticationState extends BaseState
	{
		//private var network:NetworkComponent;
		
		private static var AUTHENTICATION_CLIENT_VALUE:int =  390458;
		private static var AUTHENTICATION_SERVER_VALUE:int = -283947;

		public function AuthenticationState(network:NetworkComponent)
		{
			super(network);
		}
		
		private function Send():void
		{
			
			network.SetState(new UsernameAndPasswordState(network));
		}
		
		override public function Receive():void
		{
			buffer.clear();
			network.readBytes(buffer, 0, 4);
			
			var response:int = buffer.readInt();
			if (response != AUTHENTICATION_SERVER_VALUE)
			{
				trace("Server gave incorrect authentication value " + response);
				network.close();
				return;
			}
			
			//authenticated = true;
			trace("Authentication successful!");

			Send();
		}
		override public function Connect():void
		{
			buffer.writeInt(AUTHENTICATION_CLIENT_VALUE);
			buffer.position = 0;
			trace("Authenticating with " + buffer.toString());
			buffer.position = 4;
			network.writeBytes(buffer,0,4);
			network.flush();
		}
	}
}