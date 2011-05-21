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
			//FP.world.add(new Tutorial(Global.americanController));
			//FP.world.add(new Tutorial(Global.vietController));
		}
		
		override public function update():void
		{
			switch (Global.phase)
			{
				case 0:
				case 2:
					if (Global.americanController.photoController.finished)
					{
						Global.americanController.fadeOut();
						Global.vietController.fadeIn();
						Global.phase++;
					}				
					break;
				case 1:
				case 3:
					if (Global.vietController.photoController.finished)
					{
						Global.vietController.fadeOut();
						Global.americanController.fadeIn();
						Global.phase++;
					}			
					break;
				case 4:
					if (Global.americanController.photoController.finished)
					{
						Global.vietController.fadeIn();
						Global.phase++;
					}						
					
				default:
					break;
			}
			
			super.update();
		}
		
	}

}