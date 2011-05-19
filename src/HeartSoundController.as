package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
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
		
		public function HeartSoundController(heartController:HeartController) 
		{
			this.heartController = heartController;
		}
		
		override public function added():void
		{
			beatLoop.loop();
			trace('beat loop length:' + beatLoop.length);
			super.added();
		}
		
		public function fadeIn():void
		{
			
		}
		
		public function fadeOut():void
		{
			
		}
		
	}

}