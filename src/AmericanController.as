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
		//public const PHASE01_MUSIC_TIME:Number = 40 * FP.assignedFrameRate;			// 40
		//public const PHASE01_BOY_TO_MAN_TIME:Number = 90 * FP.assignedFrameRate;	// 90
		
		public function AmericanController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
			photoArray02 = new Array(Photos.B010, Photos.B020, Photos.B030, Photos.B040, Photos.B045, Photos.B050, Photos.B060, Photos.B070, Photos.B080, Photos.B090, Photos.B100, Photos.B110, Photos.B115, Photos.B120);
			photoArray03 = new Array(Photos.C010, Photos.C015, Photos.C020, Photos.C025, Photos.C030, Photos.C040, Photos.C045, Photos.C050, Photos.C060, Photos.C070, Photos.C090, Photos.C100, Photos.C110, Photos.C115, Photos.C120, Photos.C130, Photos.C140);
			
			//photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03);		// FIX ME - DELETE
			//photoArray02 = new Array(Photos.B010, Photos.B020, Photos.B030);		// FIX ME - DELETE
			//photoArray03 = new Array(Photos.Z010, Photos.Z015, Photos.Z020);	// FIX ME - DELETE
			
			this.type = 'american';
		}
		
		override public function added():void
		{
			trace('american controller added');
			super.added();
			
			photoArray = photoArray01;
			photoDisplayTime = Global.PHOTO_DISPLAY_TIME_01;
			FP.world.add(photoController = new PhotoController(photoArray, x, y, photoDisplayTime, photoDisplayTime, false, false));	// FIX ME 10, 10
			photoController.nextPhoto(false);
			heartController.hotZone.fadeIn();
			
			//var tweenTime:Number = heartController.heartRate * photoArray.length;
			heartController.tweenHeartRate(Global.HEART_RATE_02, heartController.heartRate * photoArray.length);
			heartController.tweenPulseSpeed(Global.PULSE_SPEED_02, heartController.heartRate * photoArray.length);
		}
		
		override public function update():void
		{
			//trace('AmericanController');
			//trace('American beat alarm percent: ' + heartController.beatAlarm.percent);
			//trace('american heart rate: ' + this.heartController.heartRate);
			super.update();
		}
		
		override public function fadeIn():void
		{
			super.fadeIn();
			trace('americancontroller phase: ' + Global.phase);
			switch (Global.phase)
			{
				case 1:				
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_02;
					photoArray = photoArray02;
					photoArrayNumber = 2;
					replacePhotoController();
					this.heartController.setHeartRatePulseSpeed(Global.HEART_RATE_02, Global.PULSE_SPEED_02);
					heartController.tweenHeartRate(Global.HEART_RATE_03, heartController.heartRate * photoArray.length);
					heartController.tweenPulseSpeed(Global.PULSE_SPEED_03, heartController.heartRate * photoArray.length);					
					//addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
					break;
				case 3:
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_03;
					photoArray = photoArray03;
					photoArrayNumber = 3;
					loopPhotos = true;
					replacePhotoController();				
					this.heartController.setHeartRatePulseSpeed(Global.HEART_RATE_03, Global.PULSE_SPEED_03);
					trace('heart rate: ' + heartController.heartRate);
					trace('pulse speed: ' + heartController.pulseSpeed);
					//addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
					break;
				default:
					break;
			}
		}
		
		/**
		 * Phase control alarm functions
		 */
		public function boyAppears():void
		{
		//	musicController.music.loop(0);
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