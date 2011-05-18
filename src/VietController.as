package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class VietController extends PersonController
	{
		// Phase01 timing
		public const PHASE01_MUSIC_TIME:Number = 40 * FP.assignedFrameRate;
		public const PHASE01_BOY_TO_MAN_TIME:Number = 90 * FP.assignedFrameRate;
		
		// Phase02 timing
		
		public var photoArray01:Array;
		
		public function VietController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.X001, Photos.X002, Photos.X003, Photos.X010, Photos.X020, Photos.X030, Photos.X040, Photos.X050, Photos.X060, Photos.X070, Photos.X080, Photos.X090, Photos.X100, Photos.X105, Photos.X110);
		}
		
		override public function added():void
		{
			trace('viet controller added');
			super.added();
			startNewPhase();
		}
		
		override public function update():void
		{
			//trace('VietController updating');
			super.update();
		}
		
		override public function startNewPhase():void
		{
			super.startNewPhase();
			switch (phaseCounter)
			{
				case 0:
					FP.world.add(personImage = new BoyWalking(Global.PERSON_IMAGE_X, y + FP.halfHeight - 2, direction));
					FP.world.add(photoController = new PhotoController(photoArray01, x, y, 10, 10));
					FP.world.add(musicController = new MusicController(Assets.MUS_VIET01));	
					
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
			trace('phase01music');
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