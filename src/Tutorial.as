package  
{
	import net.flashpunk.Entity;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Tutorial extends Entity
	{
		public var direction:Boolean;
		
		public function Tutorial(heartController:HeartController) 
		{
			direction = heartController.direction;
		}
		
		override public function update():void
		{
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				if (h.checkOverlapHotZone)
				{
					
				}
			}
		}
		
	}

}