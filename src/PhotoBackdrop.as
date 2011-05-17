package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.ColorTween;
	import Colors;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PhotoBackdrop extends Entity
	{
		public static const FADE_IN_DURATION:Number = 2 * FP.assignedFrameRate;		
		public static const FADE_OUT_DURATION:Number = 2 * FP.assignedFrameRate;
		public static const MAX_ALPHA:Number = 0.5;
		
		public var backdrop:Backdrop;
		public var fadeTween:ColorTween;
		
		public function PhotoBackdrop(source:*) 
		{
			backdrop = new Backdrop(source, false, false);
			graphic = backdrop;
			layer = 100;
			graphic.scrollX = 0;
			graphic.scrollY = 0;		
			backdrop.alpha = 0;	
		}
		
		override public function added():void
		{
			fadeIn();
		}
		
		public function reset(source:*):void
		{
			backdrop = new Backdrop(source);
			backdrop.alpha = 0;		
			fadeIn();
		}
		
		override public function update():void
		{
			backdrop.alpha = fadeTween.alpha;
			super.update();
		}
		
		public function fadeIn():void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(FADE_IN_DURATION, Colors.WHITE, Colors.WHITE, 0, MAX_ALPHA);			
		}
		
		public function fadeOut():void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(FADE_OUT_DURATION, Colors.WHITE, Colors.WHITE, (graphic as Backdrop).alpha, 0);				
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
		override public function render():void
		{
			super.render();
		}		
		
	}

}