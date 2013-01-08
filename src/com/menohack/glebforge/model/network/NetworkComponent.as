package com.menohack.glebforge.model.network 
{
	import com.menohack.glebforge.model.network.AuthenticationState;
	import com.menohack.glebforge.model.network.BaseState;
	import com.menohack.glebforge.model.network.UsernameAndPasswordState;
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.net.Socket;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	import com.menohack.glebforge.model.World;

	public class NetworkComponent extends flash.net.Socket {
		//private var me:Point;

		//private var loadOtherPlayers:Function;
		
		//The current state of network communication
		private var state:BaseState;
		
		public function NetworkComponent (networkAdapter:NetworkAdapter, host:String = null, port:uint = 0) {
			super();
			
			//this.me = me;
			//this.loadOtherPlayers = loadOtherPlayers;
			
			state = new AuthenticationState(this);
			var world:World = World.GetInstance();
			
			configureListeners();
			if (host && port)  {
				super.connect(host, port);
			}
		}
		
		public function SetState(newState:BaseState):void
		{
			state = newState;
		}

		private function configureListeners():void {
			addEventListener(Event.CLOSE, closeHandler);
			addEventListener(Event.CONNECT, connectHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
			//No listener for OutputProgressEvent.OUTPUT_PROGRESS
		}
		
		private function socketDataHandler(event:ProgressEvent):void {
			//trace("socketDataHandler: " + event);
			state.Receive();
		}

		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
			state.Close();
		}

		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
			state.Connect();
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
			state.Exception();
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
			state.Exception();
		}
	}
}