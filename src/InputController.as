package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class InputController extends Entity
	{
		public var heartController:HeartController;
		public var personController:PersonController;
		public var inputKeyString:String;
		public var lastPressCounter:Number = 0;
		
		public function InputController(inputKey:int, heartController:HeartController) 
		{
			this.heartController = heartController;
			this.personController = heartController.personController;
			this.inputKeyString = String(inputKey);
			Input.define(inputKeyString, inputKey);
		}
		
		override public function update():void
		{			
			lastPressCounter += FP.elapsed;
			
			if (Input.pressed(inputKeyString))
			{
				trace ('input controller last press: ' + lastPressCounter);
				//trace(inputKeyString + ' pressed');
				//trace('input pressed');
				var heartbeatUpList:Array = [];
				world.getClass(HeartbeatUp, heartbeatUpList);
				for each (var u:HeartbeatUp in heartbeatUpList)
				{
					if (u.heartController == this.heartController && u.checkOverlapHotZone())
					{
						if (u.missed)
						{
							return;
						}
						else if (!u.hit)
						{
							// Next photo
							this.personController.photoController.nextPhoto();
							if (this.personController.oldPhotoController) this.personController.oldPhotoController.fadeOut();
							
							u.hitAction();
								
							lastPressCounter = 0;
						}
						else
						{
							// Double presses on one heartbeat count as miss, so that you can't just pound keys
							u.missedAction();
						}
					}
				}
			}
			else if (Input.released(inputKeyString))
			{
				if (!Global.COMBINE_UP_DOWN_BEATS)
				{
					//trace('input released');
					var heartbeatDownList:Array = [];
					world.getClass(HeartbeatDown, heartbeatDownList);
					for each (var d:HeartbeatDown in heartbeatDownList)
					{
						if (d.heartController == this.heartController && d.checkOverlapHotZone())
						{
							//Global.soundController.heartbeatDown.play();
							d.hit = true;
							d.image.color = Global.PULSE_COLOR_HIT;
						}
					}	
				}
			}
			
			super.update();
		}
		
	}

}