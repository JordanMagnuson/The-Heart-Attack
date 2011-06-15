package  
{
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class MosaicImage extends Image
	{
		public var cellSize:int;
		
		public function MosaicImage(source:*, clipRect:Rectangle = null, cellSize:int = 1, cache = false) 
		{
			if (cache) 
			{
				super(source, clipRect);
			}
			else
			{
				// Override FP's default caching, by getting the bitmap data ourselves, rather than relying on FP.getBitmap
				var bitmapData:BitmapData = getBitmap(source);
				super(source, clipRect);
			}
			this.cellSize = cellSize;
			smooth = false;
			//this.cellSize = 2.5;
			
			if (this.cellSize > 1)
			{
				fitCellSize();
				downScale();
				upScale();
			}
			updateBuffer();
		}

		public static function getBitmap(source:Class):BitmapData
		{
			return (new source).bitmapData;
		}		
		
		public function fitCellSize():void
		{
			while (width % cellSize != 0 || height % cellSize != 0)
			{
				cellSize -= 1;
				if (cellSize == 2)
					return;
			}
		}
		
		public function downScale():void
		{
			var scaledBitmapData:BitmapData = new BitmapData(width / cellSize, height / cellSize);
			var matrix:Matrix = FP.matrix;
			
			matrix.b = matrix.c = 0;
			matrix.a = 1 / cellSize;
			matrix.d = 1 / cellSize;
			matrix.tx = -originX * matrix.a;
			matrix.ty = -originY * matrix.d;
			matrix.tx += originX + _point.x;
			matrix.ty += originY + _point.y;
			scaledBitmapData.draw(_source, matrix, null, blend, null, smooth);
			
			_source = scaledBitmapData;
		}
		
		public function upScale():void
		{
			var scaledBitmapData:BitmapData = new BitmapData(width, height);
			var matrix:Matrix = FP.matrix;
			
			matrix.b = matrix.c = 0;
			matrix.a = cellSize;
			matrix.d = cellSize;
			matrix.tx = -originX * matrix.a;
			matrix.ty = -originY * matrix.d;
			matrix.tx += originX + _point.x;
			matrix.ty += originY + _point.y;
			scaledBitmapData.draw(_source, matrix, null, blend, null, smooth);
			
			_source = scaledBitmapData;
		}		
	}
}