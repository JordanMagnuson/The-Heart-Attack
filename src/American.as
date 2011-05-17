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
	public class American extends Entity
	{
		public const ACTIVATE_DURATION:Number = 1 * FP.assignedFrameRate;
		public const DEACTIVATE_DURATION:Number = 1 * FP.assignedFrameRate;
		
		public var completeActivationAlarm:Alarm = new Alarm(ACTIVATE_DURATION, completeActivation);
		public var activated:Boolean = true;
		
		
		// Whether the American should be on top or bottom
		public var isTop:Boolean;
		
		public var heartController:HeartController;
		public var inputController:InputController;
		public var darkMask:DarkMask;
		
		public var photoController:PhotoController;
		public var photoArray01:Array;
		
		public function American(top:Boolean) 
		{
			if (!top) y = FP.halfHeight;
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
		}
		
		override public function added():void
		{
			FP.world.add(heartController = new HeartController(113, !isTop));
			FP.world.add(inputController = new InputController(Key.S, heartController));
			FP.world.add(photoController = new PhotoController(photoArray01, 10, 2));
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