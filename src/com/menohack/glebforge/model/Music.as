package com.menohack.glebforge.model 
{
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.media.Sound;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Music 
	{
		/*
		[Embed(source="../../../../../lib/terran1.mp3")]
		public var terran1:Class;

		[Embed(source="../../../../../lib/terran2.mp3")]
		public var terran2:Class;

		[Embed(source="../../../../../lib/terran3.mp3")]
		public var terran3:Class;
		*/
		
		private var sound:Sound;
		
		private var soundTransform:SoundTransform;
		
		public function Music() 
		{
			var songNumber:String = uint(((uint)(Math.random() * 3) + 1)).toString();
			var url:URLRequest = new URLRequest("http://acm.jhu.edu/~menohack/GlebForge/terran" + songNumber + ".mp3");
			//var url:URLRequest = new URLRequest("../lib/terran" + songNumber + ".mp3");
			sound = new Sound();
			sound.addEventListener(Event.COMPLETE, onLoadComplete);
			sound.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			sound.addEventListener(ProgressEvent.PROGRESS, onLoadProgress);
			sound.load(url);
			
			soundTransform = new SoundTransform(0.50);
			
			/*
			var music:Array = new Array(terran1, terran2, terran3);
			//FlxG.playMusic(music[(uint)(FlxG.random() * 3)]);
			var sound:Sound = new music[(uint)(Math.random() * 3)];
			var soundTransform:SoundTransform = new SoundTransform(0.50);
			sound.play(0, 0, soundTransform);
			*/
		}
		
		private function onLoadComplete(event:Event):void
		{
			sound.play(0, 0, soundTransform);
		}
		
		private function onIOError(event:IOErrorEvent):void
		{
			trace("IOError: " + event);
		}
		
		private function onLoadProgress(event:ProgressEvent):void
		{
			var loadedPct:uint = Math.round(100 * (event.bytesLoaded / event.bytesTotal)); 
			//trace("The sound is " + loadedPct + "% loaded."); 
		}
		
	}

}