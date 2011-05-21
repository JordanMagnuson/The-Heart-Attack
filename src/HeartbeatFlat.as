package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartbeatFlat extends Heartbeat
	{
		public function HeartbeatFlat(x:Number = 0, y:Number = 0) 
		{
			image = new Image(Assets.WHITE_PIXEL);
			super(x, y, image);
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
			
		}
		
		override public function added():void
		{
			reset();
		}
		
		override public function shrink():void
		{
			return;
		}
		
		override public function reset():void
		{
			//trace('heartbeatflat reset');
			direction = heartController.direction;
			//trace('heartbeatflat direction: ' + direction);
			image.scaleX = FP.width;
			//trace('line width: ' + image.scaledWidth);
			if (direction)
				x = FP.width + Global.heartbeatUpWidth + Global.heartbeatDownWidth;
			else
				x = 0 - Global.heartbeatUpWidth - Global.heartbeatDownWidth - image.scaledWidth;
			y = heartController.y + FP.halfHeight / 2 + 2;
			
			image.alpha = 1;
			fading = false;
			paused = false;			
		}
		
		public function updateLength():void
		{
			//trace('HeartbeatFlat update length');
			//image.scaleX = 2;
			//image.scaleX = (heartController.pulseSpeed * heartController.heartRate) - Global.heartbeatUpWidth - Global.heartbeatDownWidth;
			if (direction)
				image.scaleX = (FP.width - x);
			else
			{
				image.scaleX = (FP.width + x);
				x = 0;
			}
			//graphic = image;
		}
		
		override public function update():void
		{
			if (!paused)
			{			
				//trace('heartbeatflat not paused');
				if (direction)
					x -= heartController.pulseSpeed;
				else
					x += heartController.pulseSpeed;
			}
			
			// Off screen
			if (x < (0 - image.scaledWidth * 3) || x > (FP.width + image.scaledWidth * 2))
			{
				offscreenAction();
			}
			
			// Fade out?
			if (fading)
				image.alpha = fadeTween.alpha;			
		}
		
	}

}