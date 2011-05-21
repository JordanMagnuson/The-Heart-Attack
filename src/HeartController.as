package  
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.Tweener;
	import net.flashpunk.tweens.misc.Alarm;
	import Math
	import net.flashpunk.tweens.misc.ColorTween;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.tweens.motion.LinearMotion;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class HeartController extends Entity
	{
		public var personController:PersonController;
		public var heartSoundController:HeartSoundController;
		public var direction:Boolean;					// Controlls wither the heartbeat pulses travel left or right. True = left.
		public var heartRate:Number;	// How frequently the heart beats.
		public var pulseSpeed:Number;			// Number of pixels the heartbeat images move forward every frame.
		
		public var health:Number = 1;							// 0 - 1, determines the amplitude of the heart beats... if 0, heart attack
		
		public var hotZone:HotZone;
		
		public var beatAlarm:Alarm = new Alarm(heartRate, beat);
		
		public var beatCount:int = 0;
		
		public var heartRateTween:NumTween = new NumTween(finishedTweeningHeartRate);
		public var tweening:Boolean = false;
		
		public function HeartController(personController:PersonController, x:Number = 0, y:Number = 0, hotZoneX:Number = 100, direction:Boolean = true) 
		{
			super(x, y);
			this.personController = personController;
			this.direction = direction;
			hotZone = new HotZone(hotZoneX, y);
			heartSoundController = new HeartSoundController(this);
			heartRate = Global.HEART_RATE_01A;
			pulseSpeed = Global.PULSE_SPEED_01A;
		}
		
		override public function added():void
		{
			FP.world.add(hotZone);
			addTween(beatAlarm);
			if (!this.personController.markedForPause)
				beat();
			//addTween(beatAlarm, true);
		}
		
		public function reset():void
		{
			trace('heartcontroller reset');
			heartSoundController.reset();
			beatCount = 0;
			beat();
		}
		
		override public function update():void
		{
			super.update();
			
			if (tweening)
			{
				trace('heartcontroller tween value: ' + heartRateTween.value);
				heartRate = heartRateTween.value;
			}
			//trace('heart controller updating');
		}
		
		public function beat():void
		{
			trace('beat');
			// Start sound on first beat
			if (beatCount == 0)
			{
				FP.world.add(heartSoundController);
			}
			
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
			
			beatCount++;
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
		
		public function pause():void
		{
			// Stop sound
			//heartSoundController.active = false;
			heartSoundController.beatLoop.stop();
			
			// Stop heartbeats moving
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				h.pause();
			}			
			
			// Deactivate controller (so that the beat alarm stops)
			this.active = false;
		}
		
		public function unpause():void
		{
			// Activate controller	
			this.active = true;
			
			// Resume sound
			//heartSoundController.active = true;
			if (!heartSoundController.beatLoop.playing) heartSoundController.beatLoop.resume();			
			
			// Start heartbeats moving
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				h.unpause();
			}			
		}
		
		public function fadeOut(duration:Number):void
		{
			trace('heart controller fade out');
			
			// Fade beats
			var heartBeats:Array = getHeartbeats();
			for each (var h:Heartbeat in heartBeats)
			{
				if (h.heartController == this)
				{
					h.pause();
					h.fadeOut(duration);
				}
			}			
			
			// Fade sound controller
			heartSoundController.fadeOut()
			
			this.active = false					// Deactivate this controller, so that beatAlarm stops going
		}
		
		public function tweenHeartRate(targetHeartRate:Number, duration:Number):void
		{
			trace('heartController.tweenHeartRate');
			tweening = true;
			heartRateTween.tween(heartRate, targetHeartRate, duration);
			addTween(heartRateTween, true);
		}
		
		public function finishedTweeningHeartRate():void
		{
			removeTween(heartRateTween)
			tweening = false;
		}
		
		public function setHeartRate(heartRate:Number):void
		{
			this.heartRate = heartRate;
			
			//var flatHeartBeatsList:Array = [];
			//FP.world.getClass(HeartbeatFlat, flatHeartBeatsList);				
			//for each (var h:HeartbeatFlat in flatHeartBeatsList)
			//{
				//if (h.heartController == this)
				//{
					//trace('heartcontroller sending update length command');
					//h.updateLength();
				//}
			//}				
		}
		
		public function loseHealth():void
		{
			health -= 0.1;
			
			// Update sound volume
			heartSoundController.updateVolume(health);
			
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