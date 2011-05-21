package  
{
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
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

		public var t01p:Point;
		public var t02p:Point;
		public var t03p:Point;
		
		public var text03Alarm:Alarm;
		
		public function Tutorial(personController:PersonController) 
		{
			this.personController = personController;
			this.direction = personController.direction;
			text03Alarm = new Alarm(3 * FP.assignedFrameRate, fadeText03);
			
			if (direction)
			{
				t01p = new Point(181, 31);
				t02p = new Point(161, 147);
				t03p = new Point(161, 212);
			}
			else
			{
				t01p = new Point(199, 274);
				t02p = new Point(214, 379);
				t03p = new Point(214, 455);
			}			
		}
		
		override public function update():void
		{
			//trace('tutorial update');
			// Check to pause heartbeat
			var heartBeats:Array = personController.heartController.getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				if (checkTutorialHotzone(h) && pauseCounter == 0)
				{
					pauseCounter++;
					personController.pause();
					if (direction)
						FP.world.add(text01 = new EntityFader(t01p.x, t01p.y, new Image(Assets.TUT_TEXT_01)));	
					else
						FP.world.add(text01 = new EntityFader(t01p.x, t01p.y, new Image(Assets.TUT_TEXT_01b)));
					text01.fadeIn();
				}
				else if (checkTutorialHotzone(h, Global.heartbeatUpWidth) && pauseCounter == 2)
				{
					pauseCounter++;
					personController.pause();
					if (direction)
						FP.world.add(text02 = new EntityFader(t02p.x, t02p.y, new Image(Assets.TUT_TEXT_02)));
					else
						FP.world.add(text02 = new EntityFader(t02p.x, t02p.y, new Image(Assets.TUT_TEXT_02b)));
					text02.fadeIn();
				}				
			}
			
			// Check for right input pressed
			if (personController.paused && Input.pressed(personController.inputKey) && pauseCounter == 1)
			{
				pauseCounter++;
				personController.unpause();
				text01.fadeOut();
			}
			else if (personController.paused && Input.released(personController.inputKey) && pauseCounter == 3)
			{
				pauseCounter++;
				personController.unpause();
				text02.fadeOut();
				FP.world.add(text03 = new EntityFader(t03p.x, t03p.y, new Image(Assets.TUT_TEXT_03)));
				addTween(text03Alarm, true);
				text03.fadeIn();
				
				// Tween heart rate up after tutorial finishesce
				//if (!Global.CONSTANT_HEART_SOUND)
					//personController.heartController.tweenHeartRate(Global.HEART_RATE_01B, 10 * FP.assignedFrameRate);
			}			
		}
		
		public function fadeText03():void
		{
			text03.fadeOut(3 * FP.assignedFrameRate);
		}
		
		public function checkTutorialHotzone(heartbeat:Heartbeat, distance:Number = 0):Boolean
		{
			if (direction)
			{
				if (heartbeat.x < personController.heartController.hotZone.x - distance)
					return true;
			}
			else 
			{
				if (heartbeat.x > personController.heartController.hotZone.x - Global.HOT_ZONE_WIDTH + distance)
					return true;
			}
			return false;
		}
		
	}

}