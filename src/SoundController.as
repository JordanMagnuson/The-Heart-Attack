package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class SoundController extends Entity
	{
		public var heartbeatUp:Sfx = new Sfx(Assets.SND_HEARTBEAT_UP);
		public var heartbeatDown:Sfx = new Sfx(Assets.SND_HEARTBEAT_DOWN);
		
		public function SoundController() 
		{
			
		}
		
		override public function added():void
		{
		}
		
	}

}