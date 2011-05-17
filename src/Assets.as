package  
{
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class Assets 
	{
		// gfx
		[Embed(source='../assets/white_pixel.png')] public static const WHITE_PIXEL:Class;
		[Embed(source = '../assets/hearbeat_up.png')] public static const HEARTBEAT_UP:Class;
		[Embed(source = '../assets/heartbeat_down.png')] public static const HEARTBEAT_DOWN:Class;
		[Embed(source = '../assets/ground.png')] public static const GROUND:Class;
		[Embed(source = '../assets/tutorial_text_01.png')] public static const TUT_TEXT_01:Class;
		[Embed(source = '../assets/tutorial_text_02.png')] public static const TUT_TEXT_02:Class;
		[Embed(source = '../assets/tutorial_text_03.png')] public static const TUT_TEXT_03:Class;
		
		// sfx
		[Embed(source = '../assets/sfx.swf', symbol = 'heartbeat_up.wav')] public static const SND_HEARTBEAT_UP:Class;
		[Embed(source = '../assets/sfx.swf', symbol = 'heartbeat_down.wav')] public static const SND_HEARTBEAT_DOWN:Class;
		[Embed(source = '../assets/sfx.swf', symbol = 'missed.wav')] public static const SND_MISSED:Class;
		[Embed(source = '../assets/sfx.swf', symbol = 'flatline.wav')] public static const SND_FLATLINE:Class;
	}

}