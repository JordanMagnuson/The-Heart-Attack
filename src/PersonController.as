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
		public var direction:Boolean;
		
		// Controllers for this person
		public var heartController:HeartController;
		public var hotZoneX:Number;
		
		public var inputController:InputController;
		public var inputKey:int;
		
		public var photoController:PhotoController;	
		public var photoArray:Array;
		public var photoDisplayTime:Number;
		public var newPhotoControllerAlarm:Alarm;
		public var loopPhotos = false;
		
		public var musicController:MusicController;
		public var music:Sfx;
		
		public var personImage:PersonImage;
		
		
		// When not active, the person's hearbeat etc. is paused
		public var paused:Boolean = false;
		public var markedForPause:Boolean = false;
		public var darkMask:DarkMask;
		
		
		public function PersonController(isTop:Boolean, inputKey:int) 
		{
			this.inputKey = inputKey;
			this.isTop = isTop;
			this.direction = isTop;
			if (!isTop) y = FP.halfHeight;
			if (isTop) hotZoneX = Global.HOT_ZONE_X;
			else hotZoneX = FP.width - Global.HOT_ZONE_X;	
		}
		
		override public function added():void
		{
			FP.world.add(heartController = new HeartController(this, x, y, hotZoneX, isTop));
			FP.world.add(inputController = new InputController(inputKey, heartController));
			//FP.world.add(new Tutorial(this));
		}
		
		override public function update():void
		{
			//trace('person controller update');
			if (markedForPause)
			{
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
				photoController.pause();
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
		
		public function fadeOut():void
		{
			trace('person controller fading out');
			inputController.active = false;
			heartController.fadeOut(DEACTIVATE_DURATION);
			if (personImage) personImage.pause();
			FP.world.add(darkMask = new DarkMask(x, y, true, DEACTIVATE_DURATION, ACTIVATE_DURATION));
			var fadeOutCompleteAlarm:Alarm = new Alarm(DEACTIVATE_DURATION, fadeOutComplete);
			addTween(fadeOutCompleteAlarm, true);			
		}		
		
		public function fadeOutComplete():void
		{
			trace('fade out complete');
			pause();
		}
		
		public function fadeIn():void
		{
			trace('person controller fade in');
			active = true; 									// Need to set active to true here, otherwise newPhaseAlarm won't update to unpause
			inputController.active = true;
			if (darkMask)
			{	
				if (!darkMask.fadeTween.active)
				{
					var newPhaseReadyAlarm:Alarm = new Alarm(ACTIVATE_DURATION, fadeInComplete);
					addTween(newPhaseReadyAlarm, true);
					darkMask.fadeOut(ACTIVATE_DURATION);
				}
			}
			else
			{
				trace('startNewPhase = unpause');
				unpause();
			}
		}
		
		public function fadeInComplete():void
		{
			trace('fade in complete');
			unpause();
			heartController.reset();
		}
		
		public function replacePhotoController():void
		{
				photoController.fadeOut();
				FP.world.add(photoController = new PhotoController(photoArray, x, y, photoDisplayTime, 0, loopPhotos));			
		}
		
	}

}