package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SoundController extends Entity
	{
		public var heartbeatUp:Sfx = new Sfx(Assets.SND_HEARTBEAT_UP);
		public var heartbeatDown:Sfx = new Sfx(Assets.SND_HEARTBEAT_DOWN);
		public var heartbeatFull:Sfx = new Sfx(Assets.SND_BEAT_LOOP);
		public var missed:Sfx = new Sfx(Assets.SND_MISSED);
		public var flatline:Sfx = new Sfx(Assets.SND_FLATLINE);
		
		public function SoundController() 
		{
			
		}
		
		override public function added():void
		{
		}
		
	}

}