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
	public class PhotoController extends Entity
	{
		// How long to wait before starting the "slide show"
		public var startDelay:Number;
		
		// How long to display each photo
		public var displayTime:Number;
	
		/**
		 * Other vars
		 */
		public var photoArray:Array;
		public var currentIndex:int = 0;
		
		public var currentPhoto:PhotoBackdrop;
		public var lastPhoto:PhotoBackdrop;
		
		public var nextPhotoAlarm:Alarm;
		
		public var startAlarm:Alarm;
		
		public function PhotoController(photoArray:Array, displayTime:Number = 5, startDelay:Number = 0) 
		{
			this.photoArray = photoArray;
			this.startDelay = FP.assignedFrameRate * startDelay;
			this.displayTime = FP.assignedFrameRate * displayTime;
			if (startDelay > 0)
				startAlarm = new Alarm(this.startDelay, start);
			nextPhotoAlarm = new Alarm(this.displayTime, nextPhoto);
		}
		
		override public function added():void
		{
			if (startDelay > 0)
			{
				addTween(startAlarm, true);
			}
			else 
			{
				start();
			}
		}
		
		public function activate():void
		{
			if (lastPhoto) lastPhoto.active = true;
			if (currentPhoto) currentPhoto.active = true;
			this.active = true;		
		}
		
		public function deactivate():void
		{
			if (lastPhoto) lastPhoto.active = false;
			if (currentPhoto) currentPhoto.active = false;
			this.active = false;
		}
		
		public function start():void
		{
			currentPhoto = new PhotoBackdrop(photoArray[currentIndex]);
			FP.world.add(currentPhoto);
			currentIndex++;
			addTween(nextPhotoAlarm, true);			
		}		
		
		override public function update():void
		{
			super.update();
		}
		
		public function nextPhoto():void
		{
			lastPhoto = currentPhoto;
			currentPhoto = new PhotoBackdrop(photoArray[currentIndex]);
			FP.world.add(currentPhoto);
			if (lastPhoto)
				lastPhoto.fadeOut();
			if (currentIndex < photoArray.length - 1)
				currentIndex++;
			else
				currentIndex = 0;
			nextPhotoAlarm.reset(displayTime);
		}
		
	}

}