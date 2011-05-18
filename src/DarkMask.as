package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class DarkMask extends Entity
	{
		public const FADE_IN_DURATION:Number = 2 * FP.assignedFrameRate;		
		public const FADE_OUT_DURATION:Number = 2 * FP.assignedFrameRate;
		public const MAX_ALPHA:Number = 0.8;	
		
		public var shouldFadeIn:Boolean;
		public var fadeInDuration:Number;
		public var fadeOutDuration:Number;
		
		public var image:Image = Image.createRect(FP.width, FP.halfHeight, Colors.BLACK, 1);
		public var fadeTween:ColorTween;
		
		public function DarkMask(x:Number = 0, y:Number = 0, shouldFadeIn:Boolean = true, fadeInDuration:Number = 2, fadeOutDuration:Number = 2) 
		{
			super(x, y, image);
			layer = -100;
			graphic.scrollX = 0;
			graphic.scrollY = 0;		
			
			this.shouldFadeIn = shouldFadeIn;
			if (shouldFadeIn)
				image.alpha = 0;
			else 
				image.alpha = MAX_ALPHA;
				
			this.fadeInDuration = fadeInDuration;
			this.fadeOutDuration = fadeOutDuration;
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
				fadeTween.alpha = MAX_ALPHA;
				addTween(fadeTween);				
			}
			
		}
	
		override public function update():void
		{
			image.alpha = fadeTween.alpha;
			super.update();
		}		
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(fadeInDuration, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);			
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(fadeOutDuration, Colors.WHITE, Colors.WHITE, (graphic as Image).alpha, 0);				
		}		
		
		public function destroy():void
		{
			FP.world.remove(this);
		}		
		
	}

}