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
		public var heartController:HeartController;
		public var direction:Boolean;
		public var image:Image;
		public var hit:Boolean = false;
		public var missed:Boolean = false;
		
		public function Heartbeat(x:Number = 0, y:Number = 0, image:Image = null, direction:Boolean = true) 
		{
			super(x, y, image);
			this.direction = direction;
			this.image = image;			
			image.scaleX = 2;
			image.scaleY = 2;
			image.originX = 0;
			image.originY = image.height / 2;
			image.x = 0;
			image.y = 0;	
			setHitbox(image.scaledWidth, image.scaledHeight, image.originX, image.originY);				
		}
		
		override public function added():void
		{
			reset();
		}
		
		public function reset():void
		{
			direction = heartController.direction;
			hit = false;
			missed = false;
			image.color = Global.PULSE_COLOR_DEFAULT;
			
			// Adjust scale based on health
			shrink();
			
			y = heartController.y;
		}
		
		override public function update():void
		{
			if (direction)
				x -= heartController.pulseSpeed;
			else
				x += heartController.pulseSpeed;
			
			// Missed
			if (direction && (x + width < heartController.hotZone.x) && !hit && !missed)
			{
				missed = true;
				image.color = Global.PULSE_COLOR_MISSED;
				Global.soundController.missed.play(0.5);				
				heartController.loseHealth();
			}
			else if (!direction && (x > heartController.hotZone.x + Global.HOT_ZONE_WIDTH) && !hit && !missed)
			{
				missed = true;
				image.color = Global.PULSE_COLOR_MISSED;
				Global.soundController.missed.play(0.5);				
				heartController.loseHealth();
			}			
			
			// Off screen
			else if (x < (0 - image.scaledWidth * 4) || x > (FP.width + image.scaledWidth * 4))
			{
				offscreenAction();
			}
			
			super.update();
		}
		
		public function shrink():void
		{
			image.scaleX = 2;
			image.scaleY = 2 * heartController.health;
			image.originX = 0;
			image.originY = image.height / 2;
			image.x = 0;
			image.y = 0;	
			setHitbox(image.scaledWidth, image.scaledHeight, image.originX, image.originY);		
		}
		
		public function checkOverlapHotZone():Boolean
		{
			if (x > heartController.hotZone.x + Global.HOT_ZONE_WIDTH)
				return false;
			else if (x + width < heartController.hotZone.x)
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