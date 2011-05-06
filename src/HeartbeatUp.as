package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartbeatUp extends Heartbeat
	{		
		public function HeartbeatUp(x:Number = 0, y:Number = 0) 
		{
			image = new Image(Assets.HEARTBEAT_UP);
			super(x, y, image);
			Global.heartbeatUpWidth = width;			
		}
		
		override public function reset():void
		{
			x = FP.width;
			super.reset();
		}
	}
}