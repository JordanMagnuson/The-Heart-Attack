package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Ground extends Entity
	{
		public var image:Image = new Image(Assets.GROUND);
		
		public function Ground(x:Number = 0, y:Number = 0, graphic:Graphic = null) 
		{
			super(x, y, image);
			layer = -50;
		}
		
	}

}