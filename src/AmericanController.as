package  
{
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class AmericanController extends PersonController
	{
		public var photoArray01:Array;
		
		public function AmericanController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
		}
		
		override public function added():void
		{
			super.added();
			FP.world.add(photoController = new PhotoController(photoArray01, 10, 2));
		}
		
	}

}