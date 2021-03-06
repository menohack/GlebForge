package com.menohack.glebforge.model 
{
	import com.menohack.glebforge.view.RenderComponent;
	import com.yyztom.test.ui.SpriteTile;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author James Doverspike
	 */
	public class Map extends Entity
	{
		[Embed(source = "../../../../../lib/grasstiles.png")]
		private var grassTiles:Class;
		
		private static var tiles:Vector.<BitmapData>;
		
		private var blocks:Vector.<Block>;
		
		public static var TILE_WIDTH:uint = 31;
		public static var TILE_HEIGHT:uint = 31;
		
		public static var BLOCK_DIM:uint = 32;
		
		private var grids:Sprite = new Sprite();
		
		public function Map() 
		{
			var render:RenderComponent = new RenderComponent(this);
			AddComponent(render);
			
			blocks = new Vector.<Block>();
			
			grids.visible = false;
			render.GetSprite().addChild(grids);
		}
		
		/**
		 * Attempts to add a block at the specified slot.
		 * @param	x The x slot.
		 * @param	y The y slot.
		 * @return True if the block was added, false otherwise.
		 */
		public function addBlock(x:int, y:int):Boolean
		{
			var block:Bitmap = makeBlock(x, y);
			
			return block != null;
		}
		
		private function loadTiles():void
		{
			var bitmap:Bitmap = new grassTiles() as Bitmap;
			
			var numTiles:uint = bitmap.width / TILE_WIDTH;
			
			tiles = new Vector.<BitmapData>();
			for (var i:int = 0; i*TILE_WIDTH < bitmap.width; i++)
			{
				var temp:BitmapData = new BitmapData(TILE_WIDTH, TILE_WIDTH);
				temp.copyPixels(bitmap.bitmapData, new Rectangle(i * TILE_WIDTH, 0, TILE_WIDTH, TILE_WIDTH), new Point(0, 0));
				tiles.push(temp);
			}
		}
		
		private function makeBlock(x:int, y:int):Block
		{
			for (var b:uint = 0; b < blocks.length; b++)
				if (blocks[b].isSamePosition(x, y))
					return null;
			
			if (tiles == null)
				loadTiles();
			
			//var horizontalTiles:uint = Math.ceil(width / TILE_WIDTH);
			//var verticalTiles:uint = Math.ceil(height / TILE_HEIGHT);
			
			var mapWidth:uint =  BLOCK_DIM * TILE_WIDTH;
			var mapHeight:uint = BLOCK_DIM * TILE_HEIGHT;
			
			var bitmap:BitmapData = new BitmapData(mapWidth, mapHeight);
			
			for (var i:int = 0; i < BLOCK_DIM; i++)
				for (var j:int = 0; j < BLOCK_DIM; j++)
					bitmap.copyPixels(tiles[uint(Math.random() * tiles.length)] as BitmapData, new Rectangle(0, 0, TILE_WIDTH, TILE_HEIGHT), new Point(i * TILE_WIDTH, j * TILE_HEIGHT));
			
			var block:Block = new Block(bitmap, x, y);
			blocks.push(block);
			
			var render:RenderComponent = GetComponent(RenderComponent) as RenderComponent;
			if (render != null)
			{
				//Add the block
				render.GetSprite().addChild(block);
				
				render.GetSprite().removeChild(grids);
				//Add a grid to outline the tiles
				var grid:Sprite = new Sprite();
				grid.graphics.lineStyle(1, 0x00FF00);
				grid.x = block.x;
				grid.y = block.y;
				
				for (var c:int = 0; c < BLOCK_DIM; c++)
					for (var d:int = 0; d < BLOCK_DIM; d++)
						grid.graphics.drawRect(c * TILE_WIDTH, d * TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT);
				
				grid.visible = true;
				grids.addChild(grid);
				
				render.GetSprite().addChild(grids);
			}
			
			return block;
		}
		
		public function ShowGrid():void
		{
			grids.visible = true;
		}
		
		public function HideGrid():void
		{
			grids.visible = false;
		}
		
	}

}