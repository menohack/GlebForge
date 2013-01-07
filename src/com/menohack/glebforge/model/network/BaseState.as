package com.menohack.glebforge.model.network 
{
	import com.menohack.glebforge.model.NetworkComponent;
	import flash.utils.ByteArray;
	import flash.utils.getQualifiedClassName;
	import flash.utils.Endian;
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class BaseState 
	{
		protected var network:NetworkComponent;
		
		protected var buffer:ByteArray;
		
		public function BaseState(network:NetworkComponent) 
		{
			this.network = network;
			buffer = new ByteArray();
			buffer.endian = Endian.LITTLE_ENDIAN;
		}
		
		public function Receive():void
		{
			trace("Data received")
		}
		
		public function Connect():void
		{
			trace("Connected");
		}
		
		public function Close():void
		{
			trace("Connection closed");
		}
		
		public function Exception():void
		{
			trace("Error in " + getQualifiedClassName(this));
		}
	}

}