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
		// Gameplay Settings
		public static const CONSTANT_HEART_SOUND:Boolean = false;	// FIX ME - get rid of before release
		public static const COMBINE_UP_DOWN_BEATS:Boolean = true;
		
		// Constants
		public static const FRAME_RATE:Number = 60;
		public static const INPUT_KEY_TOP:int = Key.X;
		public static const INPUT_KEY_BOTTOM:int = Key.M;
		public static const HOT_ZONE_WIDTH:Number = 60;
		public static const HOT_ZONE_X:Number = 113;
		public static const PERSON_IMAGE_X:Number = 200;
		public static const HOT_ZONE_COLOR_DEFAULT:uint = Colors.BLACK;
		public static const HOT_ZONE_COLOR_ACTIVE:uint = Colors.WHITE;
		public static const PULSE_COLOR_DEFAULT:uint = Colors.BLACK;
		public static const PULSE_COLOR_HIT:uint = Colors.WHITE;
		public static const PULSE_COLOR_MISSED:uint = Colors.BLOOD_RED;
		
		public static const HEART_RATE_01A:Number = 120;	//183.5	//123	61
		public static const PULSE_SPEED_01A:Number = 2;	//2	
		
		public static const HEART_RATE_01B:Number = 61;	//184	//123	61
		public static const PULSE_SPEED_01B:Number = 2;	//2	
		
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