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
		
		private var otherPlayers:Vector.<Point>;
		
		private var me:Point;

		private var loadOtherPlayers:Function;
		
		public function NetworkComponent (otherPlayer:Point, me:Point, loadOtherPlayers:Function, host:String = null, port:uint = 0) {
			super();
			buffer.endian = Endian.LITTLE_ENDIAN;
			this.otherPlayers = new Vector.<Point>;
			this.me = me;
			this.loadOtherPlayers = loadOtherPlayers;
			
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
				
				authenticated = true;
				trace("Authentication successful!");
				
				var ba:ByteArray = new ByteArray();
				//var name:String = "James";
				var name:String = "Gleb";
				ba.writeMultiByte(name, "us-ascii");
				
				buffer.clear();
				buffer.length = 4;
				buffer.writeInt(ba.length);
				writeBytes(buffer, 0, 4);
				flush();
				
				writeBytes(ba, 0, ba.length);
				flush();
				
				
				writePosition();
				return;
			}
			else
			{
				
				readPosition();
				if (!reading)
					writePosition();
			}
			
		}
		
		private var reading:Boolean = false;
		private var numNearbyPlayers:int;
		
		private function readPosition():void
		{
			if (!reading)
			{
				buffer.clear();
				buffer.length = 4;
				readBytes(buffer, 0, 4);
				numNearbyPlayers = buffer.readInt();
				reading = true;
				return;
			}
			reading = false;
			
			buffer.clear();
			buffer.length = numNearbyPlayers * 8;
			readBytes(buffer, 0, buffer.length);
			
			otherPlayers = new Vector.<Point>;
			for (var i:int = 0; i < numNearbyPlayers; i++)
			{
				var point:Point = new Point(buffer.readFloat(), buffer.readFloat());
				otherPlayers.push(point);
			}
			loadOtherPlayers(otherPlayers);
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
			var buffer:ByteArray = new ByteArray();
			buffer.endian = Endian.LITTLE_ENDIAN;
			buffer.writeInt(AUTHENTICATION_CLIENT_VALUE);
			var test:ByteArray = new ByteArray();
			buffer.position = 0;
			trace("Authenticating with " + buffer.toString());
			buffer.position = 4;
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