package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PersonImage extends EntityFader
	{
		public var direction:Boolean;
		public var image:Spritemap;
		
		public function PersonImage(x:Number = 0, y:Number = 0, image:Image = null, direction:Boolean = true) 
		{
			super(x, y, image);	
			this.direction = direction;
			
			image.scaleX = 2;
			image.scaleY = 2;
			image.originX = 0;
			image.originY = image.scaledHeight;
			image.x = 0;
			image.y = image.originY;	
			setHitbox(image.scaledWidth, image.scaledHeight, image.originX, image.originY);					
		}
		
		public function deactivate():void
		{
			image.active = false;
			active = false;
		}
		
		public function activate():void
		{
			image.active = true;
			active = true;
		}
		
		override public function added():void
		{
		}
		
	}

}