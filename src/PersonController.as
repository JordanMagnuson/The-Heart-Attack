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
		
		// When not activated, the person's hearbeat etc. is paused
		public var completeActivationAlarm:Alarm = new Alarm(ACTIVATE_DURATION, completeActivation);
		public var activated:Boolean = true;		
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
			FP.world.add(heartController = new HeartController(hotZoneX, isTop));
			FP.world.add(inputController = new InputController(inputKey, heartController));
			FP.world.add(new Tutorial(this));
		}
		
		override public function update():void
		{
			super.update();
		}
		
		public function activate():void
		{
			if (darkMask && !darkMask.fadeTween.active)
			{
				trace('start activation');
				darkMask.fadeOut();
				addTween(completeActivationAlarm, true);
				activated = true;
			}
			else if (!activated)
			{
				trace('start activation');
				heartController.activate();
				photoController.activate();
				inputController.active = true;
				darkMask = null;				
				activated = true;
			}
		}
		
		public function completeActivation():void
		{
			removeTween(completeActivationAlarm);
			heartController.activate();
			photoController.activate();
			inputController.active = true;
			darkMask = null;
		}
		
		public function deactivate(shouldFade:Boolean = true):void
		{
			if (!darkMask && activated)
			{
				trace('deactivating');
				if (shouldFade)
				{
					FP.world.add(darkMask = new DarkMask(x, y, DEACTIVATE_DURATION, ACTIVATE_DURATION));
				}
				this.heartController.deactivate();
				this.photoController.deactivate();
				this.inputController.active = false;
				activated = false;
			}
		}
		
	}

}