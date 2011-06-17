package  
{
	import flash.net.URLRequest;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Key;
	import net.flashpunk.utils.Input;
	import flash.net.navigateToURL;
	import flash.ui.Mouse;
	
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOver extends World
	{
		public var gameOverText:EntityFader;
		
		public var request:URLRequest;
		public var learnMoreURL:String = "http://www.gametrekking.com/blog/vietnam-yin-and-yang";
		public var leaveCommentURL:String = "";		
		
		public function GameOver() 
		{
			gameOverText = new EntityFader(0, 0, new Image(Assets.END_SCREEN));
			FP.screen.color = Colors.BLACK;
		}
		
		override public function begin():void
		{
			FP.alarm(3 * FP.assignedFrameRate, fadeIn);
		}
		
		public function fadeIn():void
		{
			add(gameOverText);
			gameOverText.fadeIn(10 * FP.assignedFrameRate);			
		}
		
		override public function update():void
		{
			if (Input.pressed(Key.SPACE))
			{  
				request = new URLRequest(learnMoreURL);
				try {
				  navigateToURL(request, '_blank'); // second argument is target
				} catch (e:Error) {
				  trace("Error occurred!");
				}
			}
			//if (Input.pressed(Key.X))
			//{
				//request = new URLRequest(leaveCommentURL);
				//try {
				  //navigateToURL(request, '_blank'); // second argument is target
				//} catch (e:Error) {
				  //trace("Error occurred!");
				//}
			//}
			super.update();
		}				
		
	}

}