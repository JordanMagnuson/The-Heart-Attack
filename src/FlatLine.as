package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class FlatLine extends Entity
	{
		public var heartController:HeartController;
		public var image:Image = new Image(Assets.WHITE_PIXEL);
		
		public function FlatLine(heartController:HeartController, x:Number = 0, y:Number = 0) 
		{
			this.heartController = heartController;
			graphic = image;
			image.color = Global.PULSE_COLOR_DEFAULT;
			image.scaleY = 2;
			image.scaleX = FP.width;
		}
		
		override public function added():void
		{
			y = heartController.y + 1;
		}
		
	}

}