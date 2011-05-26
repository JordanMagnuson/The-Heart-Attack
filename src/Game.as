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
		public function Game() 
		{
		}
		
		override public function begin():void
		{
			add(new Ground);
			add(Global.cheater = new Cheater);
			add(Global.soundController = new SoundController);
			
			//Global.soundController.flatline.loop(0.5);
			
			// Choose randomly who to put on top
			//if (FP.random > 0.5)
			if (true)
			{
				trace('American on top');
				add(Global.americanController = new AmericanController(true, Global.INPUT_KEY_TOP));
				add(Global.vietController = new VietController(false, Global.INPUT_KEY_BOTTOM));
			}
			else
			{
				trace('Viet on top');
				add(Global.vietController = new VietController(true, Global.INPUT_KEY_TOP));
				add(Global.americanController = new AmericanController(false, Global.INPUT_KEY_BOTTOM));
			}	
			Global.vietController.markedForPause = true;
			
			
			//Global.americanController.markedForPause = true;
			FP.world.add(new Tutorial(Global.americanController));
			FP.world.add(new Tutorial(Global.vietController));
		}
		
		override public function update():void
		{
			//trace(Global.phase);
		
			// Deal with death
			if (Global.americanController.dead || Global.vietController.dead)
			{
				if (!Global.gameOver)
				{
					Global.gameOver = true;
					if (Global.dieTogether && Math.abs(Global.americanController.heartController.health - Global.vietController.heartController.health) <= Global.HEALTH_DIF_TO_DIE_TOGETHER)
						Global.bothDead = true;
					if (Global.americanController.dead)
						add(new GameOverSequence(Global.americanController, Global.vietController));
					else 
						add(new GameOverSequence(Global.vietController, Global.americanController));
				}
			}
			
			// Deal with phases
			switch (Global.phase)
			{
				case 0:
				case 2:
					if (Global.americanController.photoController.finished)
					{
						//Global.americanController.photoController.finished = false;
						Global.americanController.fadeOut();
						Global.vietController.fadeIn();
						Global.phase++;
					}				
					break;
				case 1:
				case 3:
					if (Global.vietController.photoController.finished)
					{
						//Global.vietController.photoController.finished = false;
						Global.vietController.fadeOut();
						Global.americanController.fadeIn();
						Global.phase++;
					}			
					break;
				case 4:
					if (Global.americanController.heartController.beatAlarm.percent <= 0.05)
					{
						Global.vietController.fadeIn();
						Global.phase++;
						Global.dieTogether = true;
					}
					//trace(Global.americanController.heartController.beatAlarm.percent);
					//if (Global.americanController.heartController.beatAlarm.percent <= 0.10)
					//{
						//Global.vietController.fadeIn();
						//Global.phase++;
					//}					
					break;
					
				default:
					break;
			}
			
			super.update();
		}
		
	}

}