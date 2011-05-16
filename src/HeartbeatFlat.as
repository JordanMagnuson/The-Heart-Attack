package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartbeatFlat extends Entity
	{
		public var heartController:HeartController;
		public var direction:Boolean;
		public var image:Image = new Image(Assets.WHITE_PIXEL);
		
		public function HeartbeatFlat(x:Number = 0, y:Number = 0) 
		{
			super(x, y, image);
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
		}
		
		override public function added():void
		{
			reset();
		}
		
		public function reset():void
		{
			direction = heartController.direction;
			image.scaleX = (heartController.pulseSpeed * heartController.heartRate) - Global.heartbeatUpWidth - Global.heartbeatDownWidth;
			//trace('line width: ' + image.scaledWidth);
			if (direction)
				x = FP.width + Global.heartbeatUpWidth + Global.heartbeatDownWidth;
			else
				x = 0 - Global.heartbeatUpWidth - Global.heartbeatDownWidth - image.scaledWidth;
			y = heartController.y;
		}
		
		override public function update():void
		{
			if (direction)
				x -= heartController.pulseSpeed;
			else
				x += heartController.pulseSpeed;
			
			// Off screen
			if (x < (0 - image.scaledWidth * 2) || x > (FP.width + image.scaledWidth * 2))
			{
				offscreenAction();
			}
			
			super.update();
		}
		
		public function offscreenAction():void
		{
			FP.world.recycle(this);
		}		
		
	}

}