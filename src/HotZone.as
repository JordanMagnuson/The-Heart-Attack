package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HotZone extends Entity
	{
		public const FADE_IN_DURATION:Number = 2 * FP.assignedFrameRate;		
		public const FADE_OUT_DURATION:Number = 2 * FP.assignedFrameRate;
		public const MAX_ALPHA:Number = 0.5;	
		
		public var fadeTween:ColorTween;
		public var fading:Boolean = false;
		
		public var heartController:HeartController;
		
		public var image:Image = Image.createRect(Global.HOT_ZONE_WIDTH, FP.halfHeight, Global.HOT_ZONE_COLOR_DEFAULT, 0.5);
		
		public function HotZone(x:Number = 0, y:Number = 0, heartController:HeartController = null) 
		{
			super(x, y, image);
			this.heartController = heartController;
		}
		
		override public function added():void
		{
			fadeTween = new ColorTween();
			fadeTween.alpha = 0;
			fadeIn();
		}
		
		override public function update():void
		{
			super.update();
			image.alpha = fadeTween.alpha;
			
			if (checkActive())
				image.color = Global.HOT_ZONE_COLOR_ACTIVE;
			else
				image.color = Global.HOT_ZONE_COLOR_DEFAULT;
		}
		
		public function fadeIn(duration:Number = 120):void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);				
		}
		
		public function fadeOut(duration:Number = 120):void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, (graphic as Image).alpha, 0);					
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