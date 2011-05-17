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
		public static const HOT_ZONE_WIDTH:Number = 20;
		public static const PULSE_COLOR_DEFAULT:uint = Colors.BLACK;
		public static const PULSE_COLOR_HIT:uint = Colors.PLAINS_GREEN;
		public static const PULSE_COLOR_MISSED:uint = Colors.BLOOD_RED;
		public static const HOT_ZONE_1_X:Number = 100;
		
		// Variables
		public static var heartbeatUpWidth;
		public static var heartbeatDownWidth;
		
		// Global entities
		public static var heartController:HeartController;
		public static var hotZone:HotZone;
		public static var inputController:InputController;
		public static var soundController:SoundController;
		public static var photoController:PhotoController;
		
	}

}