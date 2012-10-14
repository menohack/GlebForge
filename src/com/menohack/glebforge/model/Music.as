package com.menohack.glebforge.model 
{
	import flash.media.Sound;
	import flash.media.SoundTransform;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Music 
	{
		[Embed(source="../../../../../lib/terran1.mp3")]
		public var terran1:Class;

		[Embed(source="../../../../../lib/terran2.mp3")]
		public var terran2:Class;

		[Embed(source="../../../../../lib/terran3.mp3")]
		public var terran3:Class;
		
		public function Music() 
		{
			var music:Array = new Array(terran1, terran2, terran3);
			//FlxG.playMusic(music[(uint)(FlxG.random() * 3)]);
			var sound:Sound = new music[(uint)(Math.random() * 3)];
			var soundTransform:SoundTransform = new SoundTransform(0.50);
			sound.play(0, 0, soundTransform);
		}
		
	}

}