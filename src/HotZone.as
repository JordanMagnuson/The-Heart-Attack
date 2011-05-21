package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HotZone extends Entity
	{
		public var heartController:HeartController;
		
		public var image:Image = Image.createRect(Global.HOT_ZONE_WIDTH, FP.halfHeight, Global.HOT_ZONE_COLOR_DEFAULT, 0.5);
		
		public function HotZone(x:Number = 0, y:Number = 0, heartController:HeartController = null) 
		{
			super(x, y, image);
			this.heartController = heartController;
		}
		
		override public function update():void
		{
			super.update();
			if (checkActive())
				image.color = Global.HOT_ZONE_COLOR_ACTIVE;
			else
				image.color = Global.HOT_ZONE_COLOR_DEFAULT;
		}
		
		public function checkActive():Boolean
		{
			var heartBeats:Array = heartController.getHeartbeats(true, false, false);
			for each (var h:Heartbeat in heartBeats)
			{
				if (h.checkOverlapHotZone())
					return true;
			}				
			return false;
		}
	}

}