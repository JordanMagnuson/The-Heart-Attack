package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartbeatFlat extends Entity
	{
		public var image:Image = new Image(Assets.WHITE_PIXEL);
		
		public function HeartbeatFlat(x:Number = 0, y:Number = 0) 
		{
			graphic = image;
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
			image.scaleX = FP.width;
		}
		
		override public function added():void
		{
			y = Global.HEARTBEAT_Y + 1;
		}
		
	}

}