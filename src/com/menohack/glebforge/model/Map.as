package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.Camera;
	import com.menohack.glebforge.view.RenderComponent;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Map 
	{
		[Embed(source = "../../../../../lib/grasstiles.png")]
		private var grassTiles:Class;
		
		private var render:RenderComponent;
		
		private var camera:Camera;
		
		public static var TILE_WIDTH:uint = 31;
		public static var TILE_HEIGHT:uint = 31;
		
		public function Map(width:uint, height:uint, camera:Camera) 
		{
			this.camera = camera;
			render = new RenderComponent();
			render.Camera = camera;
			render.Bitmap = makeTiles(width, height);
		}
		
		private function makeTiles(width:uint, height:uint):Bitmap
		{
			var bitmap:Bitmap = new grassTiles() as Bitmap;
			
			var tiles:Array = new Array();
			for (var i:int = 0; i*TILE_WIDTH < bitmap.width; i++)
			{
				var temp:BitmapData = new BitmapData(TILE_WIDTH, TILE_WIDTH);
				temp.copyPixels(bitmap.bitmapData, new Rectangle(i * TILE_WIDTH, 0, TILE_WIDTH, TILE_WIDTH), new Point(0, 0));
				tiles.push(temp);
			}
			
			var horizontalTiles:uint = Math.ceil(width / TILE_WIDTH);
			var verticalTiles:uint = Math.ceil(height / TILE_HEIGHT);
			
			var mapWidth:uint =  horizontalTiles * TILE_WIDTH;
			var mapHeight:uint = verticalTiles * TILE_HEIGHT;
			
			var map:BitmapData = new BitmapData(mapWidth, mapHeight);
			
			for (i = 0; i < horizontalTiles; i++)
				for (var j:int = 0; j < verticalTiles; j++)
					map.copyPixels(tiles[uint(Math.random() * tiles.length)] as BitmapData, new Rectangle(0, 0, TILE_WIDTH, TILE_HEIGHT), new Point(i * TILE_WIDTH, j * TILE_HEIGHT));
			
			return new Bitmap(map);
		}
		
		public function draw():void
		{
			render.draw();
		}
		
	}

}