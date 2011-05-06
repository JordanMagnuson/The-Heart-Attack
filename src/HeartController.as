package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	import Math
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartController extends Entity
	{
		public var beatAlarm:Alarm = new Alarm(Global.heartRate, beat);
		
		public function HeartController() 
		{
		}
		
		override public function added():void
		{
			addTween(beatAlarm);
			beat();
			//addTween(beatAlarm, true);
			
		}
		
		public function beat():void
		{
			trace('beat');
			//Global.heartRate *= 0.75;
			
			// Heartbeat up
			var u:HeartbeatUp = FP.world.create(HeartbeatUp) as HeartbeatUp;
			u.reset();
			
			// Heartbeat down
			var d:HeartbeatDown = FP.world.create(HeartbeatDown) as HeartbeatDown;
			d.reset();	
			
			// Flat Line
			var f:FlatLine = FP.world.create(FlatLine) as FlatLine;
			f.reset();					
			
			beatAlarm.reset(Global.heartRate);
		}
		
		public function loseHealth():void
		{
			Global.health -= 0.1;
			
			// Shrink beats
			var heartbeatList:Array = [];
			world.getClass(Heartbeat, heartbeatList);
			for each (var h:Heartbeat in heartbeatList)
			{
				h.shrink();
			}					
		}
		
	}

}