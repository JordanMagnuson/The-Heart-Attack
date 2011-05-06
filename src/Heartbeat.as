package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Heartbeat extends Entity
	{
		public var image:Image;
		public var hit:Boolean = false;
		public var missed:Boolean = false;
		
		public function Heartbeat(x:Number = 0, y:Number = 0, image:Image = null) 
		{
			super(x, y, image);
			this.image = image;
			image.scaleX = 2;
			image.scaleY = 2;
			image.originX = 0;
			image.originY = image.scaledHeight / 2;
			image.x = 0;
			image.y = image.originY;	
			setHitbox(image.scaledWidth, image.scaledHeight, image.originX, image.originY);				
		}
		
		override public function added():void
		{
			reset();
		}
		
		public function reset():void
		{
			hit = false;
			missed = false;
			image.color = Global.PULSE_COLOR_DEFAULT;
			
			// Adjust scale based on health
			//image.scale.y *= 0.9;			
			//image.scaleX = 2;
			//image.scaleY = 2;
			//image.originX = 0;
			//image.originY = image.scaledHeight / 2;
			//image.x = 0;
			//image.y = image.originY;	
			//setHitbox(image.scaledWidth, image.scaledHeight, image.originX, image.originY);	
			trace('scaleY: ' + image.scaleY);
			trace('scaled height: ' + image.scaledHeight);
			trace('originY: ' + image.originY);
			trace('image.y: ' + image.y);
			
			y = Global.HEARTBEAT_Y;
		}
		
		override public function update():void
		{
			x -= Global.pulseSpeed;
			
			if (x + width < Global.hotZone.x && !hit && !missed)
			{
				missed = true;
				image.color = Global.PULSE_COLOR_MISSED;
			}
			else if (x < (0 - width))
			{
				offscreenAction();
			}
			
			super.update();
		}
		
		public function checkOverlapHotZone():Boolean
		{
			if (x > Global.hotZone.x + Global.HOT_ZONE_WIDTH)
				return false;
			else if (x + width < Global.hotZone.x)
				return false;
			else
				return true;
		}
		
		public function offscreenAction():void
		{
			FP.world.recycle(this);
		}
	}

}