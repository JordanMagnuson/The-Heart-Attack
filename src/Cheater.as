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
				
			if (Input.pressed(Key.F1))
				Global.americanController.heartController.setHeartRate(Global.HEART_RATE_01B);		
				
			if (Input.pressed(Key.F2))
			{
				Global.americanController.heartController.tweenHeartRate(61, 1200);
				Global.vietController.heartController.tweenHeartRate(61, 1200);
			}
			
			if (Input.pressed(Key.F4))
			{
				Global.americanController.heartController.tweenPulseSpeed(3, 5 * FP.assignedFrameRate);
				Global.vietController.heartController.tweenPulseSpeed(3, 5 * FP.assignedFrameRate);
			}			
			//if (Input.pressed(Key.F12))
			//{
				//Global.americanController.photoArray01 = new Array(Photos.A04, Photos.A05);		
			//}
			
			
			switch (Global.phase)
			{
				case 0:
				case 2:
					if (Input.pressed(Key.F12))
					{
						trace('cheater going to Viet');
						Global.phase++;
						Global.americanController.fadeOut();
						Global.vietController.fadeIn();
					}				
					break;
				case 1:
				case 3:
					if (Input.pressed(Key.F12))
					{
						trace('cheater going to American');
						Global.phase++;
						Global.vietController.fadeOut();
						Global.americanController.fadeIn();
					}			
					break;
				case 4:
					if (Input.pressed(Key.F12))
					{
						Global.vietController.fadeIn();
						Global.phase++;
					}	
					break;
				default:
					break;
			}			
		}
		
	}

}