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
		public var pairedHeartbeatDown:HeartbeatDown;
		
		public function HeartbeatUp(x:Number = 0, y:Number = 0) 
		{
			image = new Image(Assets.HEARTBEAT_UP);
			super(x, y, image);
			Global.heartbeatUpWidth = width;			
		}
		
		override public function update():void
		{
			super.update();
			
			// Missed
			if (checkMissed())
			{
				missed = true;
				image.color = Global.PULSE_COLOR_MISSED;
				Global.soundController.missed.play(heartController.health * 0.1);				
				heartController.loseHealth();
				
				if (Global.COMBINE_UP_DOWN_BEATS)
					pairedHeartbeatDown.image.color = Global.PULSE_COLOR_MISSED;	
			}
		}
		
		override public function reset():void
		{
			super.reset();
			if (direction)
			{
				image.flipped = false;
				x = FP.width;	
			}
			else
			{
				image.flipped = true;
				x = 0 - Global.heartbeatUpWidth;	
			}
		}
	}
}