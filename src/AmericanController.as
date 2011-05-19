package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class AmericanController extends PersonController
	{
		// Phase01 timing
		public const PHASE01_MUSIC_TIME:Number = 40 * FP.assignedFrameRate;			// 40
		public const PHASE01_BOY_TO_MAN_TIME:Number = 90 * FP.assignedFrameRate;	// 90
		
		public var photoArray01:Array;
		public var photoArray02:Array;
		
		public function AmericanController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			//photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
			photoArray02 = new Array(Photos.A15, Photos.B010, Photos.B020, Photos.B030, Photos.B040, Photos.B045, Photos.B050, Photos.B060, Photos.B070, Photos.B080, Photos.B090, Photos.B100, Photos.B110, Photos.B115, Photos.B120);
			photoArray01 = new Array(Photos.A04, Photos.A05);
		}
		
		override public function added():void
		{
			trace('american controller added');
			super.added();
			
			FP.world.add(personImage = new BoyWalking(Global.PERSON_IMAGE_X, y + FP.halfHeight - 2, direction));
			FP.world.add(photoController = new PhotoController(photoArray01, x, y, 10, 10));	// FIX ME 10, 10
			FP.world.add(musicController = new MusicController(Assets.MUS_AMERICAN01));	
			
			var musicAlarm:Alarm = new Alarm(PHASE01_MUSIC_TIME, phase01Music);
			addTween(musicAlarm, true);
			
			var boyToManAlarm:Alarm = new Alarm(PHASE01_BOY_TO_MAN_TIME, boyToMan);
			addTween(boyToManAlarm, true);	
		}
		
		override public function update():void
		{
		//	trace('AmericanController updating');
			super.update();
		}
		
		override public function fadeIn():void
		{
			super.fadeIn();
			switch (phaseCounter)
			{
				case 1:				
					photoController.destroy();
					FP.world.add(photoController = new PhotoController(photoArray02, x, y, 5, 5));
					heartController.updateSpeed(92, 2);
					break;
				default:
					break;
			}
			phaseCounter++;
		}
		
		override public function fadeOut():void
		{
			trace('american ending phase');
			super.fadeOut();
		}
		
		/**
		 * Phase control alarm functions
		 */
		public function phase01Music():void
		{
			//musicController.music.loop(0);
			//musicController.fadeIn(10 * FP.assignedFrameRate);
			personImage.fadeIn(10 * FP.assignedFrameRate);
		}
		
		public function boyToMan():void
		{
			personImage.fadeOut(10 * FP.assignedFrameRate);
			FP.world.add(personImage = new ManWalking(200, y + FP.halfHeight - 2, direction));
			personImage.fadeIn(10 * FP.assignedFrameRate);
		}		
		
	}

}