package  
{
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class AmericanController extends PersonController
	{
		public var photoArray01:Array;
		
		public var music:Sfx;
		public var playMusicAlarm:Alarm;
		
		public var personImage:PersonImage;
		
		public function AmericanController(isTop:Boolean, inputKey:int) 
		{
			super(isTop, inputKey);
			photoArray01 = new Array(Photos.A01, Photos.A02, Photos.A03, Photos.A04, Photos.A05, Photos.A06, Photos.A07, Photos.A08, Photos.A09, Photos.A10, Photos.A11, Photos.A12, Photos.A13, Photos.A14, Photos.A15);
			photoController = new PhotoController(photoArray01, 10, 10);
			musicController = new MusicController(Assets.MUS_AMERICAN01);
			playMusicAlarm = new Alarm(10 * FP.assignedFrameRate, playMusic);
		}
		
		override public function added():void
		{
			super.added();
			FP.world.add(photoController);
			FP.world.add(musicController);
			
			
			
			addTween(playMusicAlarm, true);
			FP.world.add(personImage = new ManWalking(200, y + FP.halfHeight - 2, direction));
			personImage.fadeIn(5 * FP.assignedFrameRate);
			
		}
		
		public function playMusic():void
		{
			musicController.music.loop(0);
			musicController.fader.fadeTo(1, 6 * FP.assignedFrameRate);
		}
		
	}

}