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
			add(new Ground);
			add(Global.heartController = new HeartController);
			add(Global.inputController = new InputController);
			add(Global.soundController = new SoundController);
			var photoArray:Array = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
			add(Global.photoController = new PhotoController(photoArray, 5, 100));
			
		//	add(Global.photoController = new PhotoController);
		}
		
	}

}