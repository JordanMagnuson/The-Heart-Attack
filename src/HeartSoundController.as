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
			fadeIn();
			trace('beat loop length:' + beatLoop.length);
			super.added();
		}
		
		public function updateVolume(newVolume:Number = 1):void
		{
			beatLoop.volume = newVolume;
		}
		
		public function fadeIn():void
		{
			beatLoop.loop(0);
			fader = new SfxFader(beatLoop);
			fader.fadeTo(1, this.heartController.personController.ACTIVATE_DURATION);
			addTween(fader, true);
		}
		
		public function fadeOut():void
		{
			
		}
		
	}

}