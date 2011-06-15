package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PersonController extends Entity
	{
		public const ACTIVATE_DURATION:Number = 3 * FP.assignedFrameRate;
		public const DEACTIVATE_DURATION:Number = 3 * FP.assignedFrameRate;
	
		// Whether the person should be on top or bottom
		public var isTop:Boolean;
		public var photoFlipped:Boolean;
		public var direction:Boolean;
		public var dead:Boolean = false;
		
		// Controllers for this person
		public var heartController:HeartController;
		public var hotZoneX:Number;
		
		public var inputController:InputController;
		public var inputKey:int;
		
		public var photoController:PhotoController;	
		public var oldPhotoController:PhotoController;
		public var photoArray:Array;
		public var photoArrayNumber:int = 1;
		public var photoDisplayTime:Number;
		public var newPhotoControllerAlarm:Alarm;
		public var loopPhotos:Boolean = false;
		
		public var photoArray01:Array;
		public var photoArray02:Array;
		public var photoArray03:Array;
		
		public var musicController:MusicController;
		public var music:Sfx;
		
		public var personImage:PersonImage;
		
		public var fadingOut:Boolean = false;
		public var fadingIn:Boolean = false;
		public var markedForFadeIn:Boolean = false;
		
		
		// When not active, the person's hearbeat etc. is paused
		public var paused:Boolean = false;
		public var markedForPause:Boolean = false;
		public var darkMask:DarkMask;
		
		
		public function PersonController(isTop:Boolean, inputKey:int) 
		{
			this.inputKey = inputKey;
			this.isTop = isTop;
			this.photoFlipped = !isTop;
			this.direction = isTop;
			if (!isTop) y = FP.halfHeight;
			if (isTop) hotZoneX = Global.HOT_ZONE_X;
			else hotZoneX = FP.width - Global.HOT_ZONE_X - Global.HOT_ZONE_WIDTH;	
		}
		
		override public function added():void
		{
			FP.world.add(heartController = new HeartController(this, x, y, hotZoneX, isTop, Global.HEART_RATE_01, Global.PULSE_SPEED_01));
			FP.world.add(inputController = new InputController(inputKey, heartController));
			//FP.world.add(new Tutorial(this));
		}
		
		override public function update():void
		{
			//trace('person controller update');
			if (markedForPause)
			{
				//heartController.hotZone.fadeTween.alpha = 0;
				//heartController.hotZone.image.alpha = 0;
				pause(true);
				active = false;
				markedForPause = false;
			}
			super.update();
		}
		
		public function pause(makeDark:Boolean = false):void
		{
			if (!paused)
			{
				trace('pause');
				if (makeDark)
				{
					FP.world.add(darkMask = new DarkMask(x, y, false));
				}
				heartController.pause();
				//photoController.pause();
				if (personImage) personImage.pause();	
				paused = true;
				active = false;
			}
		}
		
		public function unpause():void
		{	
			if (paused)
			{
				trace('unpause');				
				if (darkMask)
				{
					FP.world.remove(darkMask);		
					darkMask = null;
				}
				heartController.unpause();
				photoController.unpause();
				if (personImage) personImage.unpause();
				paused = false;	
				active = true;
			}
		}
		
		public function fadeOut(duration:Number = 180):void
		{
			trace('person controller fading out');
			fadingOut = true;
			inputController.active = false;
			heartController.fadeOut(duration);
			if (personImage) personImage.pause();
			FP.world.add(darkMask = new DarkMask(x, y, true, duration, duration));
			this.heartController.hotZone.fadeOut(duration);
			var fadeOutCompleteAlarm:Alarm = new Alarm(duration, fadeOutComplete);
			addTween(fadeOutCompleteAlarm, true);			
		}		
		
		public function fadeOutComplete():void
		{
			trace('fade out complete');
			fadingOut = false;
			pause();
			heartController.reset();
			if (markedForFadeIn)
			{
				markedForFadeIn = false;
				fadeIn();
			}
		}
		
		public function fadeIn():void
		{
			//if (fadingOut)
			//{
				//markedForFadeIn = true;
				//return;
			//}
			fadingIn = true;
			trace('person controller fade in');
			active = true; 									// Need to set active to true here, otherwise newPhaseAlarm won't update to unpause
			inputController.active = true;
			this.heartController.hotZone.fadeIn(ACTIVATE_DURATION);
			if (darkMask)
			{	
				var newPhaseReadyAlarm:Alarm = new Alarm(ACTIVATE_DURATION, fadeInComplete);
				addTween(newPhaseReadyAlarm, true);
				darkMask.fadeOut(ACTIVATE_DURATION);
			}
			else
			{
				trace('startNewPhase = unpause');
				unpause();
			}
		}
		
		public function fadeInComplete():void
		{
			fadingIn = false;
			trace('fade in complete');
			//if (oldPhotoController) oldPhotoController.destroy();
			unpause();
			heartController.beat();
		}
		
		public function replacePhotoController():void
		{
			oldPhotoController = photoController;
			FP.world.add(photoController = new PhotoController(photoArray, x, y, photoDisplayTime, photoDisplayTime, loopPhotos, true, Global.PHOTO_MAX_ALPHA, photoFlipped));			
		}
		
	}

}