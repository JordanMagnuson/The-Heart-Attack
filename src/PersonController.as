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
		public var hotZoneX:Number;
		public var heartController:HeartController;
		public var inputKey:int;
		public var inputController:InputController;
		public var photoController:PhotoController;		
		public var musicController:MusicController;
		public var personImage:PersonImage;
		public var music:Sfx;
		
		// When not active, the person's hearbeat etc. is paused
		public var paused:Boolean = false;
		public var markedForPause:Boolean = false;
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
				heartController.deactivate();
				photoController.deactivate();
				personImage.deactivate();	
//				musicController.active = false;
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
					FP.world.remove(darkMask);		
				heartController.activate();
				photoController.activate();
				personImage.activate();
//				musicController.active = true;
				darkMask = null;
				paused = false;	
				active = true;
			}
		}
		
		public function startNewPhase():void
		{
			trace('start new phase');
			active = true; 				// Need to set active to true here, otherwise newPhaseAlarm won't update to unpause
			inputController.active = true;
			if (darkMask && !darkMask.fadeTween.active)
			{	
				trace('startNewPhase = alarm');
				trace('active: ' + active);
				var newPhaseReadyAlarm:Alarm = new Alarm(ACTIVATE_DURATION, unpause);
				addTween(newPhaseReadyAlarm, true);
				darkMask.fadeOut(ACTIVATE_DURATION);
			}
			else
			{
				trace('startNewPhase = unpause');
				unpause();
			}
		}
		
		public function endPhase():void
		{
			active = false;
			inputController.active = false;
			if (!darkMask && !paused)
			{
				trace('ending phase');
				phaseCounter++;
				FP.world.add(darkMask = new DarkMask(x, y, true, DEACTIVATE_DURATION, ACTIVATE_DURATION));
				musicController.fadeOut(DEACTIVATE_DURATION);
				pause();
			}
		}
		
	}

}