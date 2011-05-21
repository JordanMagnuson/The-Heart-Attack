package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.ColorTween;
	
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
		
		public var fading:Boolean = false;
		public var fadeTween:ColorTween;
		
		public var paused:Boolean = false;
		
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
			image.alpha = 1;
			fading = false;
			paused = false;
			
			// Adjust scale based on health
			shrink();
			
			y = heartController.y + FP.halfHeight / 2
		}
		
		override public function update():void
		{
			//trace('heartbeat update');
			if (!paused)
			{
				if (direction)
					x -= heartController.pulseSpeed;
				else
					x += heartController.pulseSpeed;
			}	
			
			// Off screen
			if (x < (0 - image.scaledWidth * 4) || x > (FP.width + image.scaledWidth * 4))
			{
				offscreenAction();
			}
			
			// Fade out?
			if (fading)
				image.alpha = fadeTween.alpha;
			
			super.update();
		}
		
		public function checkMissed():Boolean
		{
			if (hit || missed)
				return false;
			else if (direction && (x + width < heartController.hotZone.x))
				return true;
			else if (!direction && (x > heartController.hotZone.x + Global.HOT_ZONE_WIDTH))
				return true;
			else
				return false;
		}
		
		public function pause():void
		{
			this.paused = true;
		}
		
		public function unpause():void
		{
			this.paused = false;
		}
		
		public function fadeOut(duration:Number):void
		{
			trace('heartbeat fade out');
			fading = true;
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween, true);
			fadeTween.tween(duration, Colors.WHITE, Colors.WHITE, 1, 0);
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
			trace('heart beat offscreen action');
			FP.world.recycle(this);
		}
		
		public function destroy():void
		{
			FP.world.recycle(this);
		}
	}

}