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
		public var inputController:InputController;
		public var direction:Boolean;					// Controlls wither the heartbeat pulses travel left or right. True = left.
		public var heartRate:Number = 2 * FP.assignedFrameRate;	// How frequently the heart beats.
		public var pulseSpeed:Number = 3;				// Number of pixels the heartbeat images move forward every frame.
		
		public var health:Number = 1;							// 0 - 1, determines the amplitude of the heart beats... if 0, heart attack
		
		public var hotZone:HotZone;
		
		public var beatAlarm:Alarm = new Alarm(heartRate, beat);
		
		public function HeartController(hotZoneX:Number, direction:Boolean = true) 
		{
			this.direction = direction;
			y = 100;
			hotZone = new HotZone(hotZoneX, 0);
		}
		
		override public function added():void
		{
			FP.world.add(hotZone);
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
			u.heartController = this;
			u.reset();
			
			// Heartbeat down
			var d:HeartbeatDown = FP.world.create(HeartbeatDown) as HeartbeatDown;
			d.heartController = this;
			d.reset();	
			
			// Flat line between beats
			var f:HeartbeatFlat = FP.world.create(HeartbeatFlat) as HeartbeatFlat;
			f.heartController = this;
			f.reset();					
			
			beatAlarm.reset(heartRate);
		}
		
		public function getHeartbeats():Array
		{
			var heartbeatList:Array = [];
			var myHeartbeats:Array = [];
			FP.world.getClass(Heartbeat, heartbeatList);				
			for each (var h:Heartbeat in heartbeatList)
			{
				if (h.heartController == this)
					myHeartbeats.push(h);
			}	
			return myHeartbeats;	
		}
		
		public function deactivate():void
		{
			// Stop heartbeats moving
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				h.active = false;
			}			
			
			// Deactivate controller
			this.active = false;
		}
		
		public function activate():void
		{
			// Start heartbeats moving
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				h.active = true;
			}			
			
			// Activate controller
			this.active = true;			
		}
		
		public function loseHealth():void
		{
			health -= 0.1;
			
			// Die
			var heartbeatList:Array = getHeartbeats();			
			if (health <= 0.1)
			{
				// Add solid white line
				FP.world.add(new FlatLine(this));
				
				// Remove everything else
				for each (var h:Heartbeat in heartbeatList)
				{
					FP.world.remove(h);
				}	
				FP.world.remove(this);
			}
			// Shrink
			else
			{
				for each (h in heartbeatList)
				{
					h.shrink();
				}					
			}	
		}
		
	}

}