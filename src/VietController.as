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
		public var photoArray02:Array;
		public var photoArray03:Array;
		
		public function VietController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.X001, Photos.X002, Photos.X003, Photos.X010, Photos.X020, Photos.X030, Photos.X040, Photos.X050, Photos.X060, Photos.X070, Photos.X080, Photos.X090, Photos.X100, Photos.X105, Photos.X110);
			photoArray02 = new Array(Photos.Y005, Photos.Y010, Photos.Y020, Photos.Y025, Photos.Y030, Photos.Y035, Photos.Y040, Photos.Y050, Photos.Y060, Photos.Y070, Photos.Y080, Photos.Y090, Photos.Y100, Photos.Y110);
			photoArray03 = new Array(Photos.Z010, Photos.Z015, Photos.Z020, Photos.Z025, Photos.Z030, Photos.Z040, Photos.Z045, Photos.Z050, Photos.Z060, Photos.Z070, Photos.Z090, Photos.Z100, Photos.Z110, Photos.Z115, Photos.Z120, Photos.Z130, Photos.Z140);
			
			//photoArray01 = new Array(Photos.X001, Photos.X002, Photos.X003);	// FIX ME - DELETE
			//photoArray02 = new Array(Photos.X003, Photos.Y005, Photos.Y010);	// FIX ME - DELETE
			
			
		}
		
		override public function added():void
		{
			trace('viet controller added');
			super.added();

			photoArray = photoArray01;
			photoDisplayTime = Global.PHOTO_DISPLAY_TIME_01;
			FP.world.add(photoController = new PhotoController(photoArray, x, y, photoDisplayTime, photoDisplayTime, false, false));	// FIX ME 10, 10
		
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
				case 2:				
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_02;
					photoArray = photoArray02;
					addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
					break;
				case 4:
					photoDisplayTime = Global.PHOTO_DISPLAY_TIME_03;
					photoArray = photoArray03;
					loopPhotos = true;
					addTween(newPhotoControllerAlarm = new Alarm(photoDisplayTime, replacePhotoController), true);
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