package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Global 
	{
		// Constants
		public static const FRAME_RATE:Number = 60;
		public static const HEARTBEAT_Y:Number = 200;		// Y value for the middle of the heart-beat pulse animation
		public static const HOT_ZONE_WIDTH:Number = 20;
		public static const PULSE_COLOR_DEFAULT:uint = Colors.WHITE;
		public static const PULSE_COLOR_HIT:uint = Colors.PLAINS_GREEN;
		public static const PULSE_COLOR_MISSED:uint = Colors.BLOOD_RED;
		
		// Variables
		public static var health:Number = 1; 					// 0 - 1, determines the amplitude of the heart beats... if 0, heart attack
		public static var heartRate:Number = 0.5 * FRAME_RATE;	// How frequently the heart beats
		public static var pulseSpeed:Number = 6;				// Number of pixels the heartbeat images move forward every frame
		public static var heartbeatUpWidth;
		public static var heartbeatDownWidth;
		
		// Global entities
		public static var heartController:HeartController;
		public static var hotZone:HotZone;
		public static var inputController:InputController;
		public static var soundController:SoundController;
		
	}

}