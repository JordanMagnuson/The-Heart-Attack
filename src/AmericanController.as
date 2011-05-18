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
		public const PHASE01_MUSIC_TIME:Number = 40 * FP.assignedFrameRate;
		public const PHASE01_BOY_TO_MAN_TIME:Number = 90 * FP.assignedFrameRate;
		
		public var photoArray01:Array;
		
		public function AmericanController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
		}
		
		override public function added():void
		{
			trace('american controller added');
			super.added();
			startNewPhase();
		}
		
		override public function startNewPhase():void
		{
			super.startNewPhase();
			switch (phaseCounter)
			{
				case 0:
					FP.world.add(personImage = new BoyWalking(Global.PERSON_IMAGE_X, y + FP.halfHeight - 2, direction));
					FP.world.add(photoController = new PhotoController(photoArray01, x, y, 10, 10));
					FP.world.add(musicController = new MusicController(Assets.MUS_AMERICAN01));	
					
					var musicAlarm:Alarm = new Alarm(PHASE01_MUSIC_TIME, phase01Music);
					addTween(musicAlarm, true);
					
					var boyToManAlarm:Alarm = new Alarm(PHASE01_BOY_TO_MAN_TIME, boyToMan);
					addTween(boyToManAlarm, true);					
					break;
				default:
					break;
			}
		}
		
		/**
		 * Phase control alarm functions
		 */
		public function phase01Music():void
		{
			musicController.music.loop(0);
			musicController.fader.fadeTo(1, 10 * FP.assignedFrameRate);
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