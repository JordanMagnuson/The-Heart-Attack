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
	public class TimedPhotoController extends PhotoController
	{
		
		public function TimedPhotoController(photoArray:Array, x:Number = 0, y:Number = 0, displayTime:Number = 300, startDelay:Number = 300, fadeDuration:Number = 120, maxAlpha:Number = 1, flipped:Boolean = false, pixelateCellSize:Number = 1 ) 
		{
			super(photoArray, x, y, displayTime, startDelay, loop, fadeIn, maxAlpha, flipped);
			this.fadeInDuration = fadeDuration;
			this.fadeOutDuration = fadeDuration;
			this.pixelateCellSize = pixelateCellSize;
			currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, false, fadeInDuration, fadeOutDuration, maxAlpha, flipped, Math.floor(pixelateCellSize));
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
				//trace('timed photo setting start alarm for ' + startDelay)
				addTween(startAlarm, true);
			}
			else 
			{
				//trace('timed photo starting right away')
				start();
			}
		}
		
		override public function start():void
		{
			//trace('slideshow started!');
			addTween(nextPhotoAlarm, true);	
			nextPhoto();
		}		
		
		override public function nextPhoto(fadeIn:Boolean = true):void
		{
			if (Global.startDepixelating && pixelateCellSize > 1)
				pixelateCellSize -= Global.depixelatePerPhoto;
			
			if (pixelateCellSize < 0)
				pixelateCellSize = 1;
				
			if (maxAlpha < 1)
				maxAlpha += Global.increaseAlphaAmount;
			
			if (finished && !loop)
			{
				return;
			}
				
			if (currentIndex < photoArray.length)
			{
				lastPhoto = currentPhoto;
				lastPhoto.fadeOut();
				FP.world.add(currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, fadeIn, fadeInDuration, fadeOutDuration, maxAlpha, flipped, Math.floor(pixelateCellSize)));
			}
			else
			{
				finished = true;
				currentIndex = 0;
				if (loop)
				{
					lastPhoto = currentPhoto;
					lastPhoto.fadeOut();
					FP.world.add(currentPhoto = new PhotoBackdrop(photoArray[currentIndex], x, y, fadeIn, fadeInDuration, fadeOutDuration, maxAlpha, flipped, Math.floor(pixelateCellSize)));
					//nextPhotoAlarm.reset(displayTime);
				}				
			}
			currentIndex++;
			nextPhotoAlarm.reset(displayTime);
		}
		
	}

}