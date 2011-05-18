package  
{
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Game extends World
	{
		//public var deactivateAlarm:Alarm = new Alarm(5 * FP.assignedFrameRate, deactivateAmerican);
		
		public function Game() 
		{
		}
		
		override public function begin():void
		{
			//addTween(deactivateAlarm, true);
			add(new Ground);
			add(Global.cheater = new Cheater);
			add(Global.soundController = new SoundController);
			add(Global.americanController = new AmericanController(false, Key.X));
			if (true)
			{
				//Global.americanController.phaseCounter++;
				//Global.americanController.newPhaseTrigger();
			}
			
		//	add(Global.photoController = new PhotoController);
		}
		
	}

}