package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Cheater extends Entity
	{
		
		public function Cheater() 
		{
			Input.define('P', Key.P);
			Input.define('R', Key.R);
		}
		
		override public function update():void
		{
			if (Input.pressed('P'))
				Global.americanController.pause();
			else if (Input.pressed('R'))
				Global.americanController.unpause();
			else if (Input.pressed(Key.I))
				Global.americanController.fadeIn();
			else if (Input.pressed(Key.O))
				Global.americanController.fadeOut();				
			else if (Input.pressed(Key.Y))
				Global.americanController.heartController.heartSoundController.fadeOut();	
				
			if (Input.pressed(Key.F2))
			{
				Global.americanController.heartController.tweenHeartRate(61, 1200);
				Global.vietController.heartController.tweenHeartRate(61, 1200);
			}
			
			if (Input.pressed(Key.F4))
			{
				Global.americanController.heartController.tweenHeartRate(60, 5 * FP.assignedFrameRate);
				Global.vietController.heartController.tweenHeartRate(60, 5 * FP.assignedFrameRate);				
				//Global.americanController.heartController.tweenPulseSpeed(2, 5 * FP.assignedFrameRate);
				//Global.vietController.heartController.tweenPulseSpeed(2, 5 * FP.assignedFrameRate);
			}			
			//if (Input.pressed(Key.F12))
			//{
				//Global.americanController.photoArray01 = new Array(Photos.A04, Photos.A05);		
			//}
			if (Input.pressed(Key.F1))
			{
				FP.world = new Game;
			}			
			
			if (Input.pressed(Key.F10))
			{
				Global.americanController.heartController.health = 0.2
				Global.vietController.heartController.health = 0.2
			}
			
			if (Input.pressed(Key.F11))
			{
				Global.phase = 2;
				Global.americanController.fadeOut();
				Global.vietController.fadeIn();
				Global.phase++;						
			}
			
			if (Input.pressed(Key.F12))
			{
				trace('cheater phase: ' + Global.phase);
				switch (Global.phase)
				{
					case 0:
					case 2:
						trace('cheater going to Viet');
						Global.americanController.fadeOut();
						Global.vietController.fadeIn();
						Global.phase++;			
						break;
					case 1:
					case 3:
						trace('cheater going to American');
						Global.vietController.fadeOut();
						Global.americanController.fadeIn();
						Global.phase++;		
						break;
					//case 4:
						//Global.vietController.fadeIn();
						//Global.phase++;
						//break;
					default:
						break;
				}					
			}
		
		}
		
	}

}