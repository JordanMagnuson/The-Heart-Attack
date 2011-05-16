package  
{
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Game extends World
	{
		
		public function Game() 
		{
		}
		
		override public function begin():void
		{
			//add(Global.hotZone = new HotZone(100, 0));
			add(Global.heartController = new HeartController(false));
			add(Global.inputController = new InputController);
			add(Global.soundController = new SoundController);
		//	add(Global.photoController = new PhotoController);
		}
		
	}

}