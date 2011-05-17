package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class InputController extends Entity
	{
		public var heartController:HeartController;
		
		public function InputController(inputKey:int, heartController:HeartController) 
		{
			this.heartController = heartController;
			Input.define('X', inputKey);
		}
		
		override public function update():void
		{			
			if (Input.pressed('X'))
			{
				//trace('input pressed');
				var heartbeatUpList:Array = [];
				world.getClass(HeartbeatUp, heartbeatUpList);
				for each (var u:HeartbeatUp in heartbeatUpList)
				{
					if (u.checkOverlapHotZone())
					{
						Global.soundController.heartbeatUp.play();
						u.hit = true;
						u.image.color = Global.PULSE_COLOR_HIT;
					}
				}
			}
			else if (Input.released('X'))
			{
				//trace('input released');
				var heartbeatDownList:Array = [];
				world.getClass(HeartbeatDown, heartbeatDownList);
				for each (var d:HeartbeatDown in heartbeatDownList)
				{
					if (d.checkOverlapHotZone())
					{
						Global.soundController.heartbeatDown.play();
						d.hit = true;
						d.image.color = Global.PULSE_COLOR_HIT;
					}
				}				
			}
			
			super.update();
		}
		
	}

}