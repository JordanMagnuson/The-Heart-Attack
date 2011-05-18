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
		public var inputKeyString:String;
		
		public function InputController(inputKey:int, heartController:HeartController) 
		{
			this.heartController = heartController;
			this.inputKeyString = String(inputKey);
			Input.define(inputKeyString, inputKey);
		}
		
		override public function update():void
		{			
			if (Input.pressed(inputKeyString))
			{
				trace(inputKeyString + ' pressed');
				//trace('input pressed');
				var heartbeatUpList:Array = [];
				world.getClass(HeartbeatUp, heartbeatUpList);
				for each (var u:HeartbeatUp in heartbeatUpList)
				{
					if (u.heartController == this.heartController && u.checkOverlapHotZone())
					{
						Global.soundController.heartbeatUp.play();
						u.hit = true;
						u.image.color = Global.PULSE_COLOR_HIT;
					}
				}
			}
			else if (Input.released(inputKeyString))
			{
				//trace('input released');
				var heartbeatDownList:Array = [];
				world.getClass(HeartbeatDown, heartbeatDownList);
				for each (var d:HeartbeatDown in heartbeatDownList)
				{
					if (d.heartController == this.heartController && d.checkOverlapHotZone())
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