package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Tutorial extends Entity
	{
		public var direction:Boolean;
		public var personController:PersonController;
		public var pauseCounter:int = 0;
		
		public var text01:EntityFader;
		public var text02:EntityFader;
		public var text03:EntityFader;
		
		public function Tutorial(personController:PersonController) 
		{
			this.personController = personController;
			this.direction = personController.direction;
		}
		
		override public function update():void
		{
			// Check to pause heartbeat
			var heartBeats:Array = personController.heartController.getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				if (checkTutorialHotzone(h) && pauseCounter == 0)
				{
					pauseCounter++;
					personController.deactivate(false);
					FP.world.add(text01 = new EntityFader(185, 20, new Image(Assets.TUT_TEXT_01)));	
					text01.fadeIn();
				}
				else if (checkTutorialHotzone(h, Global.heartbeatUpWidth) && pauseCounter == 2)
				{
					pauseCounter++;
					personController.deactivate(false);
					FP.world.add(text02 = new EntityFader(155, 140, new Image(Assets.TUT_TEXT_02)));	
					text02.fadeIn();
				}				
			}
			
			// Check for right input pressed
			if (!personController.activated && Input.pressed(personController.inputKey) && pauseCounter == 1)
			{
				pauseCounter++;
				personController.activate();
				text01.fadeOut();
			}
			else if (!personController.activated && Input.released(personController.inputKey) && pauseCounter == 3)
			{
				pauseCounter++;
				personController.activate();
				text02.fadeOut();
				FP.world.add(text03 = new EntityFader(155, 200, new Image(Assets.TUT_TEXT_03)));
				text03.fadeIn();
			}			
		}
		
		public function checkTutorialHotzone(heartbeat:Heartbeat, distance:Number = 0):Boolean
		{
			if (direction)
				if (heartbeat.x < personController.heartController.hotZone.x - distance)
					return true;
			return false;
		}
		
	}

}