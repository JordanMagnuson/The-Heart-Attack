package  
{
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Global 
	{
		// Constants
		public static const FRAME_RATE:Number = 60;
		public static const HOT_ZONE_WIDTH:Number = 20;
		public static const HOT_ZONE_X:Number = 113;
		public static const STARTING_HEART_RATE:Number = 180;
		public static const STARTING_PULSE_SPEED:Number = 2;
		public static const PULSE_COLOR_DEFAULT:uint = Colors.BLACK;
		public static const PULSE_COLOR_HIT:uint = Colors.PLAINS_GREEN;
		public static const PULSE_COLOR_MISSED:uint = Colors.BLOOD_RED;
		
		// Variables
		public static var heartbeatUpWidth;
		public static var heartbeatDownWidth;
		public static var phase;				// 1. American born, 2. Viet born, 3. American to war, 4. Both at war
		
		// Global entities
		public static var cheater:Cheater;
		public static var americanController:AmericanController;
		public static var soundController:SoundController;
		
		// American constants

		
	}

}