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
		
		// sfx
		[Embed(source = '../assets/sfx.swf', symbol = 'heartbeat_up.wav')] public static const SND_HEARTBEAT_UP:Class;
		[Embed(source = '../assets/sfx.swf', symbol = 'heartbeat_down.wav')] public static const SND_HEARTBEAT_DOWN:Class;
		[Embed(source = '../assets/sfx.swf', symbol = 'missed.wav')] public static const SND_MISSED:Class;
		[Embed(source='../assets/sfx.swf', symbol='flatline.wav')] public static const SND_FLATLINE:Class;
		
	}

}