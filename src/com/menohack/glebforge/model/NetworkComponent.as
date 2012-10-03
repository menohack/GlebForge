package com.menohack.glebforge.model 
{
	import flash.errors.*;
	import flash.events.*;
	import flash.geom.Point;
	import flash.net.Socket;
	import flash.net.XMLSocket;
	import flash.utils.Endian;
	import flash.utils.ByteArray;
	import flash.display.Bitmap;

	public class NetworkComponent extends flash.net.Socket {
		
		private static var AUTHENTICATION_CLIENT_VALUE:int = 390458;
		private static var AUTHENTICATION_SERVER_VALUE:int = -283947;
		
		private var authenticated:Boolean = false;
		
		private var buffer:ByteArray = new ByteArray();
		
		private var otherPlayer:Point;
		
		private var me:Point;

		public function NetworkComponent (otherPlayer:Point, me:Point, host:String = null, port:uint = 0) {
			super();
			buffer.endian = Endian.LITTLE_ENDIAN;
			this.otherPlayer = otherPlayer;
			this.me = me;
			
			configureListeners();
			if (host && port)  {
				super.connect(host, port);
			}
		}

		private function configureListeners():void {
			addEventListener(Event.CLOSE, closeHandler);
			addEventListener(Event.CONNECT, connectHandler);
			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);
			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);
		}
		
		private function socketDataHandler(event:ProgressEvent):void {
			//trace("socketDataHandler: " + event);
			
			if (!authenticated)
			{
				buffer.clear();
				readBytes(buffer, 0, 4);
				
				var response:int = buffer.readInt();
				if (response != AUTHENTICATION_SERVER_VALUE)
				{
					trace("Server gave incorrect authentication value " + response);
					this.close();
					return;
				}
				
				
				trace("Authentication successful!");
				authenticated = true;
				writePosition();
				return;
			}
			else
			{
				readPosition();
				writePosition();
			}
			
		}
		
		private function readPosition():void
		{
			buffer.clear();
			buffer.length = 8;
			readBytes(buffer, 0, 8);
			otherPlayer.x = buffer.readFloat();
			otherPlayer.y = buffer.readFloat();
		}
		
		private function writePosition():void
		{
			buffer.clear();
			buffer.writeFloat(me.x);
			buffer.writeFloat(me.y);
			writeBytes(buffer, 0, 8);
			flush();
		}

		private function authenticate():void {
			trace("Authenticating...");
			var buffer:ByteArray = new ByteArray();
			buffer.endian = Endian.LITTLE_ENDIAN;
			buffer.writeInt(AUTHENTICATION_CLIENT_VALUE);
			writeBytes(buffer,0,4);
			flush();
		}

		private function closeHandler(event:Event):void {
			trace("closeHandler: " + event);
		}

		private function connectHandler(event:Event):void {
			trace("connectHandler: " + event);
			authenticate();
		}

		private function ioErrorHandler(event:IOErrorEvent):void {
			trace("ioErrorHandler: " + event);
		}

		private function securityErrorHandler(event:SecurityErrorEvent):void {
			trace("securityErrorHandler: " + event);
		}
	}
}