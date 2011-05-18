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
			else if (Input.pressed(Key.S))
				Global.americanController.startNewPhase();
			else if (Input.pressed(Key.F))
			{
				Global.americanController.endPhase();
			}
		}
		
	}

}