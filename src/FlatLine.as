package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FlatLine extends Entity
	{
		public var image:Image = new Image(Assets.WHITE_PIXEL);
		
		public function FlatLine() 
		{
			graphic = image;
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
		}
		
		override public function added():void
		{
			reset();
		}
		
		public function reset():void
		{
			image.scaleX = (Global.pulseSpeed * Global.heartRate) - Global.heartbeatUpWidth - Global.heartbeatDownWidth;
			x = FP.width + Global.heartbeatUpWidth + Global.heartbeatDownWidth;
			y = Global.HEARTBEAT_Y + 1;
		}
		
		override public function update():void
		{
			x -= Global.pulseSpeed;
			
			if (x < (0 - image.scaledWidth))
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