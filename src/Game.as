package  
{
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Game extends World
	{
		public var deactivateAlarm:Alarm = new Alarm(5 * FP.assignedFrameRate, deactivateAmerican);
		
		public function Game() 
		{
		}
		
		override public function begin():void
		{
			//addTween(deactivateAlarm, true);
			add(new Ground);
			add(Global.cheater = new Cheater);
			add(Global.soundController = new SoundController);
			add(Global.american = new American(true));
			
		//	add(Global.photoController = new PhotoController);
		}
		
		public function deactivateAmerican():void
		{
			trace('deactivate american');
			Global.american.deactivate();
		}
		
	}

}