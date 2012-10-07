package com.menohack.glebforge.model 
{
	import flash.net.Socket;
	/**
	 * This class contains the socket uses it to communicate with the server.
	 * @author James Doverspike
	 */
	public class NetworkAdapter 
	{
		//The Socket connection to the server
		private var socket:Socket;
		
		private var networkComponents:Vector.<NetworkComponent>;
		
		public function NetworkAdapter() 
		{
			networkComponents = new Vector.<NetworkComponent>();
		}
		
		public function addComponent(component:NetworkComponent):void
		{
			networkComponents.push(component);
		}
		
	}

}