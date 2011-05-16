package  
{
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	
	public class Main extends Engine
	{
		public function Main() 
		{
			// Initiate the game with a 640x480 screen.
			super(640, 480, Global.FRAME_RATE, true);
			//FP.screen.color = Colors.WHITE;
			
			// Console for debugging
			FP.console.enable();					
			
			FP.world = new Game;
			
			//Mouse.hide();
			//Mouse.cursor
		}
		
		override public function init():void
		{
			super.init();
		}
	}
}