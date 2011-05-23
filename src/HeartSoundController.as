package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.sound.SfxFader;
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartSoundController extends Entity
	{	
		public var heartController:HeartController;
		public var beatLoop:Sfx = new Sfx(Assets.SND_BEAT_LOOP);
		public var fader:SfxFader;
		public var delayAlarm:Alarm;
		
		public var sndMissed:Sfx = new Sfx(Assets.SND_MISSED);
		public var sndBeat:Sfx = new Sfx(Assets.SND_BEAT_LOOP);
		
		public function HeartSoundController(heartController:HeartController) 
		{
			this.heartController = heartController;
		}
		
		override public function added():void
		{
			if (Global.CONSTANT_HEART_SOUND)
				reset();
		}
		
		public function reset():void
		{
			delayAlarm = new Alarm(20, fadeIn);
			addTween(delayAlarm, true);
		}
		
		override public function update():void
		{
			//trace('heart sound controller update');
			super.update();
		}
		
		public function updateVolume(newVolume:Number = 1):void
		{
			if (Global.CONSTANT_HEART_SOUND)
				beatLoop.volume = newVolume;
		}
		
		public function fadeIn(duration:Number = 180):void
		{
			if (Global.CONSTANT_HEART_SOUND)
			{
				beatLoop.loop(0);
				fader = new SfxFader(beatLoop);
				fader.fadeTo(1, duration);
				addTween(fader, true);
			}
		}
		
		public function fadeOut(duration:Number = 180):void
		{
			trace('sound controller fade out');
			fader = new SfxFader(beatLoop);
			fader.fadeTo(0, duration);	
			addTween(fader, true);	
		}
		
	}

}