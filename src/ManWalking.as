package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class ManWalking extends PersonImage
	{
		public const ANIM_SPEED:Number = 0.15;
		
		public function ManWalking(x:Number = 0, y:Number = 0, direction:Boolean = true) 
		{
			image = new Spritemap(Assets.MAN_WALKING, 8, 17);
			super(x, y, image, direction);	
			
			image.add('walk', [0, 1, 2, 3], ANIM_SPEED, true);				
		}
		
		override public function added():void
		{
			image.play('walk');
		}
		
	}

}