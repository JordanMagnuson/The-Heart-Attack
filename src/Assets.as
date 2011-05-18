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
		[Embed(source = '../assets/tutorial_text_01b.png')] public static const TUT_TEXT_01b:Class;
		[Embed(source = '../assets/tutorial_text_02b.png')] public static const TUT_TEXT_02b:Class;		
		[Embed(source = '../assets/tutorial_text_03.png')] public static const TUT_TEXT_03:Class;
		[Embed(source = '../assets/man_walking.png')] public static const MAN_WALKING:Class;
		[Embed(source = '../assets/boy_walking.png')] public static const BOY_WALKING:Class;
		
		// sfx
		[Embed(source = '../assets/sfx01.swf', symbol = 'heartbeat_up.wav')] public static const SND_HEARTBEAT_UP:Class;
		[Embed(source = '../assets/sfx01.swf', symbol = 'heartbeat_down.wav')] public static const SND_HEARTBEAT_DOWN:Class;
		[Embed(source = '../assets/sfx01.swf', symbol = 'missed.wav')] public static const SND_MISSED:Class;
		[Embed(source = '../assets/sfx01.swf', symbol = 'flatline.wav')] public static const SND_FLATLINE:Class;
		
		// music
		[Embed(source = '../assets/Montego.mp3')] public static const MUS_AMERICAN01:Class;
		[Embed(source='../assets/music.swf', symbol='viet01_NgayDoXaRoi')] public static const MUS_VIET01:Class;
	}

}