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
		public const AMERICAN_MUSIC_DURATION:Number = 183 * FP.assignedFrameRate;
		public const VIET_MUSIC_DURATION:Number = 187 * FP.assignedFrameRate;

		public const MAX_WAR_PHOTOS_TO_SHOW:Number = 7;
		public const SKIP_EVERY_OTHER_BOOTCAMP_PHOTO:Boolean = true;
		
		public const DARK_MASK_IN_DURATION:Number = 8 * FP.assignedFrameRate;		
		public const RED_MASK_IN_DURATION:Number = 3 * FP.assignedFrameRate;		// 1
		public const RED_MASK_STAY_DURATION:Number = 12 * FP.assignedFrameRate;		// 14
		public const RED_MASK_OUT_DURATION:Number = 15 * FP.assignedFrameRate;		// 15
		public const FLAT_LINE_OUT_DURATION:Number = 5 * FP.assignedFrameRate;		// 5
		public const HOT_ZONE_OUT_DURATION:Number = 5 * FP.assignedFrameRate;		// 5
		public const SOUND_OUT_DURATION:Number = 8 * FP.assignedFrameRate;			// 8
		public const MUSIC_START_TIME:Number = 15 * FP.assignedFrameRate;			// 15
		public const MUSIC_IN_DURATION:Number = 20 * FP.assignedFrameRate;			// 20
		public const SLIDE_SHOW_START_TIME:Number = 20 * FP.assignedFrameRate;		// 20
		
		public var dead:PersonController;
		public var notDead:PersonController;
		
		public var sndFlatline:Sfx = new Sfx(Assets.SND_FLATLINE);
		public var sfxFader:SfxFader = new SfxFader(sndFlatline);
		
		public var startSlideshowAlarm:Alarm = new Alarm(SLIDE_SHOW_START_TIME, startSlideshow);
		public var startMusicAlarm:Alarm = new Alarm(MUSIC_START_TIME, startMusic);
		public var music:Sfx;
		public var musicDuration:Number;
		public var musicFader:SfxFader;
		
		public var photoIndex:int;
		
		public var deadPhotocontroller:TimedPhotoController;
		public var notDeadPhotocontroller:TimedPhotoController;
		
		public function GameOverSequence(dead:PersonController, notDead:PersonController) 
		{
			this.dead = dead;
			this.notDead = notDead;
			trace('dead: ' + this.dead.type);
			trace('notdead: ' + this.notDead.type);
		}
		
		override public function added():void
		{
			// Pause everything
			//Global.americanController.pause();
			//Global.vietController.pause();
			photoIndex = dead.photoController.currentIndex;
			Global.photoCellSize = dead.photoController.pixelateCellSize;
			Global.depixelatePerPhoto = Global.photoCellSize / 10;
			Global.startDepixelating = true;
			Global.quake.stop();
			
			// Play flatline sound
			sndFlatline.play(0.2);
			sfxFader.fadeTo(0, SOUND_OUT_DURATION);
			addTween(sfxFader, true);
			
			// Music
			if ((!Global.bothDead && dead.type == 'american') || (Global.bothDead && FP.random > 0.5))
			{
				music = new Sfx(Assets.MUS_BONES_SKIN);
				musicDuration = AMERICAN_MUSIC_DURATION;
			}
			else
			{
				music = new Sfx(Assets.MUS_VIET);
				musicDuration = VIET_MUSIC_DURATION;
			}
			musicFader = new SfxFader(music);
			addTween(startMusicAlarm, true);
			
			// Slideshow alarm
			addTween(startSlideshowAlarm, true);
			
			// Fade everything in/out
			// Die together
			if (Global.bothDead)
			//if (true)
			{
				// Make notdead flatline
				var heartBeats:Array = notDead.heartController.getHeartbeats();
				for each (var h:Heartbeat in heartBeats)
				{
					FP.world.remove(h);
				}					
				FP.world.add(notDead.heartController.flatLine = new FlatLine(notDead.heartController));
				notDead.heartController.flatLine.fadeTween.alpha = 1;
				notDead.heartController.flatLine.image.alpha = 1;
				
				notDead.pause();
				notDead.heartController.hotZone.active = true;
				notDead.heartController.hotZone.fadeOut();
				if (notDead.heartController.flatLine) notDead.heartController.flatLine.fadeOut(FLAT_LINE_OUT_DURATION);	
				FP.world.add(new RedMask(notDead.x, notDead.y, true, RED_MASK_IN_DURATION, RED_MASK_OUT_DURATION, RED_MASK_STAY_DURATION, 1, true));
				notDeadPhotocontroller = generateSlideshow(notDead);
			}
			else if (dead.photoArrayNumber == 3)
			{
				notDead.pause();
				if (notDead.darkMask) notDead.darkMask.fadeOut(RED_MASK_IN_DURATION);
				notDead.heartController.hotZone.active = true;
				notDead.heartController.hotZone.fadeOut();
				if (notDead.heartController.flatLine) notDead.heartController.flatLine.fadeOut(FLAT_LINE_OUT_DURATION);	
				FP.world.add(new RedMask(notDead.x, notDead.y, true, RED_MASK_IN_DURATION, RED_MASK_OUT_DURATION, RED_MASK_STAY_DURATION, 1, true, Colors.BLACK));
				notDeadPhotocontroller = generateSlideshow(notDead);
				notDead.heartController.fadeOut(RED_MASK_IN_DURATION);
			}
			else
			{
				notDead.pause();
				notDead.darkMask.fadeOut(RED_MASK_IN_DURATION);
				notDead.heartController.hotZone.active = true;
				notDead.heartController.hotZone.fadeOut();
				if (notDead.heartController.flatLine) notDead.heartController.flatLine.fadeOut(FLAT_LINE_OUT_DURATION);	
				FP.world.add(new DarkMask(notDead.x, notDead.y, true, RED_MASK_IN_DURATION, RED_MASK_OUT_DURATION, 1, true));
				//notDeadPhotocontroller = generateSlideshow(notDead);
				notDead.heartController.fadeOut(RED_MASK_IN_DURATION);				
			}
			dead.pause();
			dead.heartController.hotZone.active = true;
			dead.heartController.hotZone.fadeOut();
			if (dead.heartController.flatLine) dead.heartController.flatLine.fadeOut(FLAT_LINE_OUT_DURATION);
			FP.world.add(new RedMask(dead.x, dead.y, true, RED_MASK_IN_DURATION, RED_MASK_OUT_DURATION, RED_MASK_STAY_DURATION, 1, true));
			deadPhotocontroller = generateSlideshow(dead);		
		}
		
		public function startMusic():void
		{
			trace('start music');
			music.play(0);
			music.complete = goToGameOver;
			addTween(musicFader, true);
			musicFader.fadeTo(0.75, MUSIC_IN_DURATION);
		}
		
		public function generateSlideshow(person:PersonController):TimedPhotoController
		{
			var photoArray:Array = [];
			trace('global phase: ' + Global.phase);
			trace('current index: ' + photoIndex);
			trace('finished: ' + person.photoController.finished);
			
			// Pack first array
			//photoArray = person.photoArray01
			
			var i:int;
			var j:int = 1;
			// Photo array 1
			if (person.photoArrayNumber == 1)
			{
				trace('yes array = 1');
				for (i = 0; i < photoIndex; i++)
				{
					trace('phot: ' + person.photoArray01[i]);
					photoArray.push(person.photoArray01[i]);
				}
			}
			
			// Photo array 2
			else if (person.photoArrayNumber == 2)
			{
				photoArray = person.photoArray01;
				for (i = 0; i < photoIndex; i++)
				{
					trace('phot: ' + person.photoArray02[i]);
					if (SKIP_EVERY_OTHER_BOOTCAMP_PHOTO)
					{
						if (j > 0)
							photoArray.push(person.photoArray02[i]);
						j *= -1;
					}
					else
					{
						photoArray.push(person.photoArray02[i]);
					}
				}				
			}
			
			//else if (person.photoArrayNumber == 3)
			//{
				//trace('stuff one image');
				//photoArray.push(person.photoArray03[5]);
			//}
			
			// Photo array 3
			else if (person.photoArrayNumber == 3)
			{
				// Stuff the first two arrays
				photoArray = person.photoArray01;
				for (i = 0; i < person.photoArray02.length; i++)
				{
					if (SKIP_EVERY_OTHER_BOOTCAMP_PHOTO)
					{
						if (j > 0)
							photoArray.push(person.photoArray02[i]);
						j *= -1;
					}
					else
					{
						photoArray.push(person.photoArray02[i]);
					}
				}	
				
				// Check for looping
				if (person.photoController.finished)
				{
					for (i = photoIndex; i < person.photoArray03.length; i++)
					{
						trace('phot: ' + person.photoArray03[i]);
						if (photoIndex + i < MAX_WAR_PHOTOS_TO_SHOW)
							photoArray.push(person.photoArray03[i]);
						else	
							break;
					}						
				}
				
				// Push photos up to index
				for (i = 0; i < photoIndex - 1; i++)
				{
					trace('phot: ' + person.photoArray03[i]);
					if (i < MAX_WAR_PHOTOS_TO_SHOW - 1)
						photoArray.push(person.photoArray03[i]);
					else
						break;
				}	
				
				// Push index
				photoArray.push(person.photoArray03[person.photoController.currentIndex - 1]);
			}			
			
			// Reverse the array
			photoArray.reverse();
			
			// Determine timing
			var displayTime:Number = (musicDuration + MUSIC_START_TIME - SLIDE_SHOW_START_TIME) / (photoArray.length);
			var fadeDuration:Number = displayTime / 2;
			
			// Create controller
			return new TimedPhotoController(photoArray, person.x, person.y, displayTime, displayTime, fadeDuration, 0.5, person.photoFlipped, Global.photoCellSize);
		
		}
		
		public function goToGameOver():void
		{
			FP.world = new GameOver;
		}
		
		public function startSlideshow():void
		{
			trace('start slideshow');
			if (notDeadPhotocontroller)
			{
				if (notDead.photoController) notDead.photoController.destroy();
				if (notDead.oldPhotoController) notDead.oldPhotoController.destroy();	
				FP.world.add(notDeadPhotocontroller);
			}
			if (dead.photoController) dead.photoController.destroy();
			if (dead.oldPhotoController) dead.oldPhotoController.destroy();			
			FP.world.add(deadPhotocontroller);
		}
		
	}

}