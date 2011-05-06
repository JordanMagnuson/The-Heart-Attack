package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartbeatDown extends Heartbeat
	{
		
		public function HeartbeatDown(x:Number = 0, y:Number = 0) 
		{
			image = new Image(Assets.HEARTBEAT_DOWN);
			super(x, y, image);
			Global.heartbeatDownWidth = image.scaledWidth;
		}
		
		override public function reset():void
		{
			x = FP.width + Global.heartbeatUpWidth;
			super.reset();
		}
	}

}