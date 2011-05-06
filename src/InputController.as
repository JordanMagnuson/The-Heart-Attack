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
		
		public function InputController() 
		{
			Input.define('X', Key.SPACE);
		}
		
		override public function update():void
		{			
			if (Input.pressed('X'))
			{
				trace('input pressed');
				var heartbeatUpList:Array = [];
				world.getClass(HeartbeatUp, heartbeatUpList);
				for each (var u:HeartbeatUp in heartbeatUpList)
				{
					if (u.checkOverlapHotZone())
					{
						u.hit = true;
						u.image.color = Global.PULSE_COLOR_HIT;
					}
				}
			}
			else if (Input.released('X'))
			{
				trace('input released');
				var heartbeatDownList:Array = [];
				world.getClass(HeartbeatDown, heartbeatDownList);
				for each (var d:HeartbeatDown in heartbeatDownList)
				{
					if (d.checkOverlapHotZone())
					{
						d.hit = true;
						d.image.color = Global.PULSE_COLOR_HIT;
					}
				}				
			}
			
			super.update();
		}
		
	}

}