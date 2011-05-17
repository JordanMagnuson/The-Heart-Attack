package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HotZone extends Entity
	{
		public var image:Image = Image.createRect(Global.HOT_ZONE_WIDTH, FP.height, Colors.PLAINS_GREEN, 0.5);
		
		public function HotZone(x:Number = 0, y:Number = 0) 
		{
			super(x, y, image);
		}
		
	}

}