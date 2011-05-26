package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.FP;
	import net.flashpunk.tweens.misc.Alarm;
	
	/**
	 * ...
	 * @author Jordan Magnuson
	 */
	public class TimedPhotoController extends Entity
	{
		// How long to wait before starting the "slide show"
		public var startDelay:Number;
		
		// How long to display each photo - includes fade in time
		public var displayTime:Number;
	
		/**
		 * Other vars
		 */
		public var photoArray:Array;
		public var currentIndex:int = 0;
		public var loop:Boolean = false;
		public var finished:Boolean = false;
		
		public var currentPhoto:PhotoBackdrop;
		public var lastPhoto:PhotoBackdrop;
		
		public var nextPhotoAlarm:Alarm;
		
		public var startAlarm:Alarm;
		
		public var fadeIn:Boolean;
		
		public var fadeInDuration:Number = 120;
		public var fadeOutDuration:Number = 120;
		public var maxAlpha:Number;
		
		public function TimedPhotoController(photoArray:Array, x:Number = 0, y:Number = 0, displayTime:Number = 300, startDelay:Number = 300, fadeDuration:Number = 120, maxAlpha:Number = 1) 
		{
			super(x, y);
			this.fadeIn = fadeIn;
			this.photoArray = photoArray;
			this.startDelay = startDelay;
			this.displayTime = displayTime;
			this.fadeInDuration = fadeDuration;
			this.fadeOutDuration = fadeDuration;
			this.maxAlpha = maxAlpha;
			this.loop = loop;
			currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, false, fadeInDuration, fadeOutDuration);
			startAlarm = new Alarm(startDelay, start);
			nextPhotoAlarm = new Alarm(displayTime, nextPhoto);
			//nextPhotoAlarm = new Alarm(this.displayTime, nextPhoto);
		}
		
		override public function added():void
		{
			FP.world.add(currentPhoto);
			currentIndex++;
			if (startDelay > 0) 
			{
				trace('timed photo setting start alarm for ' + startDelay)
				addTween(startAlarm, true);
			}
			else 
			{
				trace('timed photo starting right away')
				start();
			}
		}
		
		public function unpause():void
		{
			if (lastPhoto) lastPhoto.active = true;
			if (currentPhoto) currentPhoto.active = true;
			this.active = true;		
		}
		
		public function pause():void
		{
			if (lastPhoto) lastPhoto.active = false;
			if (currentPhoto) currentPhoto.active = false;
			this.active = false;
		}
		
		public function start():void
		{
			trace('slideshow started!');
			addTween(nextPhotoAlarm, true);	
			nextPhoto();
		}		
		
		override public function update():void
		{
			super.update();
		}
		
		public function nextPhoto(fadeIn:Boolean = true):void
		{
			if (finished && !loop)
			{
				return;
			}
				
			if (currentIndex < photoArray.length)
			{
				lastPhoto = currentPhoto;
				lastPhoto.fadeOut();
				FP.world.add(currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, fadeIn, fadeInDuration, fadeOutDuration, maxAlpha));
			}
			else
			{
				finished = true;
				currentIndex = 0;
				if (loop)
				{
					lastPhoto = currentPhoto;
					lastPhoto.fadeOut();
					FP.world.add(currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, fadeIn, fadeInDuration, fadeOutDuration, maxAlpha));
					//nextPhotoAlarm.reset(displayTime);
				}				
			}
			currentIndex++;
			nextPhotoAlarm.reset(displayTime);
		}
		
		public function fadeOut():void
		{
			unpause();
			if (lastPhoto) lastPhoto.fadeOut();
			if (currentPhoto) currentPhoto.fadeOut();
			FP.world.remove(this);			
		}
		
		public function destroy():void
		{
			if (lastPhoto) FP.world.remove(lastPhoto);
			if (currentPhoto) FP.world.remove(currentPhoto);
			FP.world.remove(this);
		}
		
	}

}