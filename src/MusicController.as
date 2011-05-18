package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class MusicController extends Entity
	{	
		public var music:Sfx;
		public var fader:SfxFader;
		
		public function MusicController(source:*) 
		{
			music = new Sfx(source);
		}
		
		override public function added():void
		{
		}
		
		public function fadeIn(duration:Number, volume:Number = 1):void
		{
			fader = new SfxFader(music);
			fader.fadeTo(1, duration);
			addTween(fader, true);			
		}
		
		public function fadeOut(duration:Number):void
		{	
			fader = new SfxFader(music, destroy);
			fader.fadeTo(0, duration);
			addTween(fader, true);
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}