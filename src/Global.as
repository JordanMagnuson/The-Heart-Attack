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
		
		public static const PHOTO_MAX_ALPHA = 0.5;
		public static const PHOTO_MAX_ALPHA_END_SLIDESHOW = 1;
		
		
		// Constants - heart controller
		public static const STARTING_HEALTH:Number = 1;
		public static const LOSE_HEALTH_AMOUNT:Number = 0.1;			// 0.1
		public static const HEALTH_DIF_TO_DIE_TOGETHER:Number = 0.3;
		
		public static const HEART_RATE_01:Number = 2 * FRAME_RATE;	// 5
		public static const PULSE_SPEED_01:Number = 2;					// 1
		
		public static const HEART_RATE_02:Number = 2 * FRAME_RATE;		// 3
		public static const PULSE_SPEED_02:Number = 2;				// 1.5
		
		public static const HEART_RATE_03:Number = 2 * FRAME_RATE;		// 2
		public static const PULSE_SPEED_03:Number = 2;					// 2
		
		public static const FINAL_HEART_RATE_TWEEN_DURATION:Number = 60 * FRAME_RATE;
		public static const HEART_RATE_04:Number = 0.2 * FRAME_RATE;
		public static const PULSE_SPEED_04:Number = 8;			
		
		// Photo display times - no longer used.
		public static const PHOTO_DISPLAY_TIME_01:Number = 3 * FRAME_RATE;	// 7
		public static const PHOTO_DISPLAY_TIME_02:Number = 3 * FRAME_RATE; 	// 5
		public static const PHOTO_DISPLAY_TIME_03:Number = 3 * FRAME_RATE; 	// 3		
		
		
		// Variables
		public static var heartbeatUpWidth;
		public static var heartbeatDownWidth;
		public static var phase:int = 0;				// 1. American born, 2. Viet born, 3. American to war, 4. Both at war

		// Game over
		public static var gameOver:Boolean = false;
		public static var dieTogether:Boolean = false;
		public static var bothDead:Boolean = false;		
		public static var increaseAlphaAmount:Number = 0.05;		
		
		// Photo pixelation
		public static var startPixelating:Boolean = false;
		public static var startDepixelating:Boolean = false;
		public static var pixelatePerPhoto:Number = 0.25;		// 0.3 Once startPixelating is true, how much to increase pixelation with each photo?
		public static var depixelatePerPhoto:Number = 0.5;
		public static var photoCellSize:Number = 1;
		public static var alphaIncreasing:Boolean = false;
		
		// Screen quake
		public static var quakeScreenOnBeat:Boolean = false;
		public static var quakeDuration:Number = 0.01;
		public static var quakeIntensity:Number = 0.01;		
		public static var quakeDurationIncreaseBy:Number = 0.01;
		public static var quakeIntensityIncreaseBy:Number = 0.01;
		
		// Global entities
		public static var cheater:Cheater;
		public static var quake:Quake;
		public static var americanController:AmericanController;
		public static var vietController:VietController;
		public static var soundController:SoundController;
		
		// American constants

		
	}

}