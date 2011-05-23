package  
{
	import adobe.utils.CustomActions;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class GameOverSequence extends Entity
	{
		public const MUSIC_DURATION:Number = 183 * FP.assignedFrameRate;
		
		public const RED_MASK_IN_DURATION:Number = 0.01 * FP.assignedFrameRate;		// 0.1
		public const RED_MASK_STAY_DURATION:Number = 10 * FP.assignedFrameRate;		// 10
		public const RED_MASK_OUT_DURATION:Number = 10 * FP.assignedFrameRate;		// 10
		public const FLAT_LINE_OUT_DURATION:Number = 5 * FP.assignedFrameRate;		// 5
		public const HOT_ZONE_OUT_DURATION:Number = 5 * FP.assignedFrameRate;		// 5
		public const SOUND_OUT_DURATION:Number = 8 * FP.assignedFrameRate;			// 8
		public const MUSIC_START_TIME:Number = 15 * FP.assignedFrameRate;			// 15
		public const MUSIC_IN_DURATION:Number = 20 * FP.assignedFrameRate;			// 20
		//public const SLIDE_SHOW_START_TIME:Number = 20 * FP.assignedFrameRate;		// 30
		
		public var dead:PersonController;
		public var notDead:PersonController;
		
		public var sndFlatline:Sfx = new Sfx(Assets.SND_FLATLINE);
		public var sfxFader:SfxFader = new SfxFader(sndFlatline);
		
		//public var startSlideshowAlarm:Alarm = new Alarm(SLIDE_SHOW_START_TIME, startSlideshow);
		public var startMusicAlarm:Alarm = new Alarm(MUSIC_START_TIME, startMusic);
		public var music:Sfx = new Sfx(Assets.MUS_BONES_SKIN);
		public var musicFader:SfxFader = new SfxFader(music);
		
		public var photoArray:Array;
		public var photoController:TimedPhotoController;
		
		public function GameOverSequence(dead:PersonController, notDead:PersonController) 
		{
			this.dead = dead;
			this.notDead = notDead;
		}
		
		override public function added():void
		{
			FP.frameRate = 10;
			// Pause everything
			//Global.americanController.pause();
			//Global.vietController.pause();
			
			// Play flatline sound
			sndFlatline.play(0.2);
			sfxFader.fadeTo(0, SOUND_OUT_DURATION);
			addTween(sfxFader, true);
			
			// cue alarms
			addTween(startMusicAlarm, true);
			//addTween(startSlideshowAlarm, true);
			
			// generate slideshow
			generateSlideshow();
			if (dead.photoController) dead.photoController.destroy();
			if (dead.oldPhotoController) dead.oldPhotoController.destroy();
			FP.world.add(photoController);
			trace('slideshow added');
			
			// Fade everything in/out
			notDead.fadeOut();
			dead.pause();
			dead.heartController.hotZone.active = true;
			dead.heartController.hotZone.fadeOut();
			dead.heartController.flatLine.fadeOut(FLAT_LINE_OUT_DURATION);
			FP.world.add(new RedMask(dead.x, dead.y, true, RED_MASK_IN_DURATION, RED_MASK_OUT_DURATION, RED_MASK_STAY_DURATION, 1));
			
		}
		
		public function startMusic():void
		{
			trace('start music');
			music.play(0);
			addTween(musicFader, true);
			musicFader.fadeTo(0.75, MUSIC_IN_DURATION);
		}
		
		public function generateSlideshow():void
		{
			photoArray = [];
			trace('global phase: ' + Global.phase);
			trace('current index: ' + dead.photoController.currentIndex);
			trace('finished: ' + dead.photoController.finished);
			
			// Pack first array
			//photoArray = dead.photoArray01
			
			var i:int;
			if (dead.photoArrayNumber == 1)
			{
				trace('yes array = 1');
				for (i = 0; i < dead.photoController.currentIndex; i++)
				{
					trace('phot: ' + dead.photoArray01[i]);
					photoArray.push(dead.photoArray01[i]);
				}
			}
			else if (dead.photoArrayNumber == 2)
			{
				photoArray = dead.photoArray01;
				for (i = 0; i < dead.photoController.currentIndex; i++)
				{
					trace('phot: ' + dead.photoArray02[i]);
					photoArray.push(dead.photoArray02[i]);
				}				
			}
			else if (dead.photoArrayNumber == 3)
			{
				// Stuff the first two arrays
				photoArray = dead.photoArray01.concat(dead.photoArray02)
				
				// Check for looping
				if (true)
				{
					for (i = 0; i < dead.photoController.currentIndex; i++)
					{
						trace('phot: ' + dead.photoArray03[i]);
						photoArray.push(dead.photoArray03[i]);
					}	
				}
			}			
			
			// Reverse the array
			photoArray.reverse();
			
			// Determine timing
			var displayTime:Number = (MUSIC_DURATION + MUSIC_START_TIME) / (photoArray.length);
			var fadeDuratoin:Number = displayTime / 2;
			
			// Create controller
			photoController = new TimedPhotoController(photoArray, dead.x, dead.y, displayTime, displayTime, fadeDuratoin);
		
		}
		
		public function startSlideshow():void
		{
			trace('start slideshow');
			//dead.photoController.unpause();
			//if (dead.oldPhotoController) dead.oldPhotoController.fadeOut();
			//FP.world.add(photoController);
		}
		
	}

}