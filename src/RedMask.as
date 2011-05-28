package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class RedMask extends Entity
	{
		public const FADE_IN_DURATION:Number = 0.1 * FP.assignedFrameRate;		
		public const FADE_OUT_DURATION:Number = 1 * FP.assignedFrameRate;
		public const LIVE_DURATION:Number = 0.5 * FP.assignedFrameRate;
		public const MAX_ALPHA:Number = 0.6;	
		
		public var shouldFadeIn:Boolean;
		public var fadeInDuration:Number;
		public var fadeOutDuration:Number;
		public var liveDuration:Number;
		public var maxAlpha:Number;
		
		//public var image:Image = Image.createRect(FP.width, FP.halfHeight, Colors.BLOOD_RED, 1);
		public var image:Image;
		public var fadeTween:ColorTween;
		
		public var stayConstantAlarm:Alarm;
		
		public function RedMask(x:Number = 0, y:Number = 0, shouldFadeIn:Boolean = true, fadeInDuration:Number = 0, fadeOutDuration:Number = 0, liveDuration:Number = 0, maxAlpha:Number = 0.6, pixelated:Boolean = false, color:uint = Colors.BLOOD_RED) 
		{
			if (color == Colors.BLACK)
			{
				image = new Image(Assets.BLOCK_MASK_BLACK);
			}
			else if (!pixelated)
			{
				image = Image.createRect(FP.width, FP.halfHeight, Colors.BLOOD_RED, 1);
			}
			else
			{
				image = new Image(Assets.BLOCK_MASK);
				image.color = Colors.BLOOD_RED;
			}
			super(x, y, image);
			layer = -100;
			graphic.scrollX = 0;
			graphic.scrollY = 0;		
			
			this.shouldFadeIn = shouldFadeIn;
			if (shouldFadeIn)
				image.alpha = 0;
			else 
				image.alpha = maxAlpha;
				
			if (fadeInDuration == 0) this.fadeInDuration = FADE_IN_DURATION;
			else this.fadeInDuration = fadeInDuration;
			
			if (fadeOutDuration == 0) this.fadeOutDuration = FADE_OUT_DURATION;
			else this.fadeOutDuration = fadeOutDuration;
			
			if (liveDuration == 0) this.liveDuration = LIVE_DURATION;
			else this.liveDuration = liveDuration;
			
			stayConstantAlarm = new Alarm(this.liveDuration, fadeOut);
			
			this.maxAlpha = maxAlpha;
		}
		
		override public function added():void
		{
			if (shouldFadeIn)
			{
				fadeIn();
			}
			else
			{
				fadeTween = new ColorTween();
				fadeTween.alpha = maxAlpha;
				addTween(fadeTween);				
			}
			
		}
	
		override public function update():void
		{
			//trace('red mask updating');
			image.alpha = fadeTween.alpha;
			super.update();
		}		
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween(stayConstant);
			addTween(fadeTween);		
			fadeTween.tween(fadeInDuration, Colors.WHITE, Colors.WHITE, 0, maxAlpha);			
		}
		
		public function stayConstant():void
		{
			addTween(stayConstantAlarm, true);
		}
		
		public function fadeOut():void
		{
			//trace('red mask fade out');
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(fadeOutDuration, Colors.WHITE, Colors.WHITE, (graphic as Image).alpha, 0);				
		}		
		
		public function destroy():void
		{
			//trace('destroy red mask');
			FP.world.remove(this);
		}		
		
	}

}