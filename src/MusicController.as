package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
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
			fader = new SfxFader(music);
		}
		
		override public function added():void
		{
			addTween(fader);
		}
		
		public function fadeIn(duration:Number):void
		{
		}
		
		public function fadeOut(duration:Number):void
		{	
		}
		
	}

}