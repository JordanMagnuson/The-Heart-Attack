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
		//public const PHASE01_MUSIC_TIME:Number = 40 * FP.assignedFrameRate;
		//public const PHASE01_BOY_TO_MAN_TIME:Number = 90 * FP.assignedFrameRate;

		public function VietController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.X010, Photos.X020, Photos.X030, Photos.X040, Photos.X060, Photos.X065, Photos.X070, Photos.X080, Photos.X090, Photos.X100, Photos.X105, Photos.X110);
			photoArray02 = new Array(Photos.Y01, Photos.Y02, Photos.Y03, Photos.Y04, Photos.Y05, Photos.Y06, Photos.Y07, Photos.Y08, Photos.Y09, Photos.Y10, Photos.Y11, Photos.Y12, Photos.Y13, Photos.Y14);
			photoArray03 = new Array(Photos.Z010, Photos.Z015, Photos.Z020, Photos.Z025, Photos.Z030, Photos.Z040, Photos.Z045, Photos.Z050, Photos.Z060, Photos.Z070, Photos.Z090, Photos.Z100, Photos.Z110, Photos.Z115, Photos.Z120, Photos.Z130, Photos.Z140);
			photoArray03 = new Array(Photos.Z050, Photos.Z060, Photos.Z070, Photos.Z090, Photos.Z100, Photos.Z110, Photos.Z115, Photos.Z120, Photos.Z130, Photos.Z140, Photos.Z010, Photos.Z015, Photos.Z020, Photos.Z025, Photos.Z030, Photos.Z040, Photos.Z045);
			
			
			//photoArray01 = new Array(Photos.X001, Photos.X002, Photos.X003);	// FIX ME - DELETE
			//photoArray02 = new Array(Photos.Y005, Photos.Y010, Photos.Y020);	// FIX ME - DELETE
			//photoArray03 = new Array(Photos.Z010, Photos.Z015, Photos.Z020);	// FIX ME - DELETE
			
			this.type = 'viet'
		}
		
		override public function added():void
		{
			trace('viet controller added');
			super.added();

			photoArray = photoArray01;
			photoDisplayTime = Global.PHOTO_DISPLAY_TIME_01;
			FP.world.add(photoController = new PhotoController(photoArray, x, y, photoDisplayTime, photoDisplayTime, false, false, Global.PHOTO_MAX_ALPHA, photoFlipped));	// FIX ME 10, 10
			photoController.nextPhoto(false);		
		}
		
		override public function update():void
		{
			super.update();
		}
		
		override public function fadeIn():void
		{
			super.fadeIn();
			trace('vietcontroller phase: ' + Global.phase);
			switch (Global.phase)
			{
				case 0:
					//heartController.unpause();
					heartController.tweenHeartRate(Global.HEART_RATE_02, heartController.heartRate * photoArray.length);
					heartController.tweenPulseSpeed(Global.PULSE_SPEED_02, heartController.heartRate * photoArray.length);	
					break;
				case 2:			
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_02;
					photoArray = photoArray02;
					photoArrayNumber = 2;
					replacePhotoController();
					this.heartController.setHeartRatePulseSpeed(Global.HEART_RATE_02, Global.PULSE_SPEED_02);
					heartController.tweenHeartRate(Global.HEART_RATE_03, heartController.heartRate * photoArray.length);
					heartController.tweenPulseSpeed(Global.PULSE_SPEED_03, heartController.heartRate * photoArray.length);					
					//addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
					break;
				case 4:
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_03;
					photoArray = photoArray03;
					photoArrayNumber = 3;
					loopPhotos = true;
					replacePhotoController();
					this.heartController.setHeartRatePulseSpeed(Global.HEART_RATE_03, Global.PULSE_SPEED_03);
					//Global.americanController.heartController.setHeartRatePulseSpeed(Global.HEART_RATE_03, Global.PULSE_SPEED_03);
				default:
					break;
			}
		}
		
		override public function fadeInComplete():void
		{
			super.fadeInComplete();
			trace('vietcontroller fade in phase: ' + Global.phase);
			switch (Global.phase)
			{
				case 5:
					trace('yeppers');
					this.heartController.tweenHeartRate(Global.HEART_RATE_04, Global.FINAL_HEART_RATE_TWEEN_DURATION);
					this.heartController.tweenPulseSpeed(Global.PULSE_SPEED_04, Global.FINAL_HEART_RATE_TWEEN_DURATION);	
					Global.americanController.heartController.tweenHeartRate(Global.HEART_RATE_04, Global.FINAL_HEART_RATE_TWEEN_DURATION);
					Global.americanController.heartController.tweenPulseSpeed(Global.PULSE_SPEED_04, Global.FINAL_HEART_RATE_TWEEN_DURATION);						
					//addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
					Global.phase++;
					break;		
			}
		}		
		
		/**
		 * Phase control alarm functions
		 */
		public function boyAppears():void
		{
			trace('phase01music');
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