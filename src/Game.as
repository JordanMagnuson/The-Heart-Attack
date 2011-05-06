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
			add(Global.heartController = new HeartController);
			add(Global.hotZone = new HotZone(100, 0));
			add(Global.inputController = new InputController);
		}
		
	}

}