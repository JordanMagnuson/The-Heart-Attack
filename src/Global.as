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
		public static const INPUT_KEY_TOP:int = Key.X;
		public static const INPUT_KEY_BOTTOM:int = Key.M;
		public static const HOT_ZONE_WIDTH:Number = 20;
		public static const HOT_ZONE_X:Number = 113;
		public static const PERSON_IMAGE_X:Number = 200;
		public static const STARTING_HEART_RATE:Number = 184;	//180	//97.5
		public static const STARTING_PULSE_SPEED:Number = 2;	//2
		public static const HOT_ZONE_COLOR:uint = Colors.PLAINS_GREEN;
		public static const PULSE_COLOR_DEFAULT:uint = Colors.BLACK;
		public static const PULSE_COLOR_HIT:uint = Colors.PLAINS_GREEN;
		public static const PULSE_COLOR_MISSED:uint = Colors.BLOOD_RED;
		
		// Variables
		public static var heartbeatUpWidth;
		public static var heartbeatDownWidth;
		public static var phase:int = 0;				// 1. American born, 2. Viet born, 3. American to war, 4. Both at war
		
		// Global entities
		public static var cheater:Cheater;
		public static var americanController:AmericanController;
		public static var vietController:VietController;
		public static var soundController:SoundController;
		
		// American constants

		
	}

}