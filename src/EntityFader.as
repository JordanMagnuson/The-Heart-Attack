package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class EntityFader extends Entity
	{
		public var fadeTween:ColorTween;
		
		public function EntityFader(x:Number = 0, y:Number = 0, graphic:Graphic = null) 
		{
			super(x, y, graphic);
			(graphic as Image).alpha = 0;
			fadeTween = new ColorTween;
			fadeTween.alpha = 0;
		}
		
		override public function added():void
		{
			
		}
		
		override public function update():void
		{
			
			(graphic as Image).alpha = fadeTween.alpha;
			super.update();
		}		
		
		public function fadeIn(duration:Number = 60, maxAlpha:Number = 1):void
		{
			fadeTween = new ColorTween();
			addTween(fadeTween);		
			fadeTween.tween(duration, 0xFFFFFFFF, 0xFFFFFFFF, 0, maxAlpha);			
		}
		
		public function fadeOut(duration:Number = 60):void
		{
			fadeTween = new ColorTween(destroy);
			addTween(fadeTween);		
			fadeTween.tween(duration, 0xFFFFFFFF, 0xFFFFFFFF, (graphic as Image).alpha, 0);				
		}
		
		public function destroy():void
		{
			FP.world.remove(this);
		}
		
	}

}