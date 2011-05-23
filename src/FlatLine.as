package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.ColorTween;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FlatLine extends EntityFader
	{
		public var heartController:HeartController;
		public var image:Image = new Image(Assets.WHITE_PIXEL);
		
		public function FlatLine(heartController:HeartController, x:Number = 0, y:Number = 0) 
		{
			this.heartController = heartController;
			super(x, y, image);
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
			image.scaleX = FP.width;
			fadeTween.alpha = 1;
		}
		
		override public function added():void
		{
			y = heartController.y + FP.halfHeight / 2 + 1;
		}
		
		override public function update():void
		{
			super.update();
		}		
	}

}