package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	
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
				Global.americanController.deactivate(false);
			else if (Input.pressed('R'))
				Global.americanController.activate();
		}
		
	}

}