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
				missedAction();	
			}
		}
		
		override public function hitAction():void
		{
			// Play sound
			if (!Global.CONSTANT_HEART_SOUND) 
				this.heartController.heartSoundController.playHeartbeat(heartController.health);
				//Global.soundController.heartbeatFull.play(heartController.health);
			
			// Change beat color
			hit = true;
			image.color = Global.PULSE_COLOR_HIT;
									
			if (Global.COMBINE_UP_DOWN_BEATS)
				pairedHeartbeatDown.image.color = Global.PULSE_COLOR_HIT;				
		}
		
		override public function missedAction():void
		{
			missed = true;		
			heartController.loseHealth();
			image.color = Global.PULSE_COLOR_MISSED;	
			
			// Sound
			this.heartController.heartSoundController.stopHeartbeat();
			this.heartController.heartSoundController.sndMissed.play((1 - heartController.health + 0.1) * 0.2);	
			
			// Red mask
			FP.world.add(new RedMask(this.heartController.x, this.heartController.y));
			
			if (Global.COMBINE_UP_DOWN_BEATS)
				pairedHeartbeatDown.image.color = Global.PULSE_COLOR_MISSED;	
				
			// Die together?
			if (Global.dieTogether)
			{
				if (this.heartController.personController.type == 'american')
					Global.vietController.heartController.loseHealth();
				else
					Global.americanController.heartController.loseHealth();
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