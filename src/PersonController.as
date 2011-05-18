package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class PersonController extends Entity
	{
		public const ACTIVATE_DURATION:Number = 1 * FP.assignedFrameRate;
		public const DEACTIVATE_DURATION:Number = 1 * FP.assignedFrameRate;
	
		// Whether the person should be on top or bottom
		public var isTop:Boolean;
		public var direction:Boolean;
		
		// Controllers for this person
		public var hotZoneX:Number;
		public var heartController:HeartController;
		public var inputKey:int;
		public var inputController:InputController;
		public var photoController:PhotoController;		
		public var musicController:MusicController;
		public var personImage:PersonImage;
		
		// When not active, the person's hearbeat etc. is paused
		public var paused:Boolean = false;
		public var phaseCounter:int = 0;
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
			FP.world.add(heartController = new HeartController(x, y, hotZoneX, isTop));
			FP.world.add(inputController = new InputController(inputKey, heartController));
			//FP.world.add(new Tutorial(this));
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function pause():void
		{
			if (!paused)
			{
				trace('pause');
				heartController.deactivate();
				photoController.deactivate();
				inputController.active = false;
				personImage.deactivate();
				active = false;		
				paused = true;
			}
		}
		
		public function unpause():void
		{	
			if (paused)
			{
				trace('unpause');
				heartController.activate();
				photoController.activate();
				personImage.activate();
				inputController.active = true;
				darkMask = null;
				paused = false;
				active = true;			
			}
		}
		
		public function startNewPhase():void
		{
			trace('start new phase');
			if (darkMask && !darkMask.fadeTween.active)
			{	
				active = true;				// Need to set active to true here, otherwise newPhaseAlarm won't update to unpause
				trace('should be working');
				trace('active: ' + active);
				var newPhaseReadyAlarm:Alarm = new Alarm(ACTIVATE_DURATION, unpause);
				addTween(newPhaseReadyAlarm, true);
				darkMask.fadeOut();
			}
			else
			{
				unpause();
			}
		}
		
		public function endPhase():void
		{
			if (!darkMask && active)
			{
				trace('ending phase');
				phaseCounter++;
				FP.world.add(darkMask = new DarkMask(x, y, DEACTIVATE_DURATION, ACTIVATE_DURATION));
				musicController.fader.fadeTo(0, DEACTIVATE_DURATION);
				pause();
			}
		}
		
	}

}