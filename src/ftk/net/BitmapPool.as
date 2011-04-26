// **********************************************************
// * __________.__              .__ ___.
// * \_  _____/|__| ____ _____  |  |\_ |__  __ __  ____
// *  |   __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
// *  |  |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
// *  \__|     |__|___|__(______/____/_____/____/\___  /
// *                                            /_____/
// * Flex ToolKits by Finalbug
// * http://www.finalbug.org/projects/ftk
// **********************************************************
package ftk.net
{
	import flash.display.Bitmap;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	import ftk.data.DataModel;
	import ftk.errors.DataError;
	import ftk.events.LoadEvent;
	import ftk.utils.DataUtil;

	/**
	 * This class is used to keep images which are loaded from outside of .swf file.
	 * All the images loaded will be changed to bitmap.
	 * This class running in singleton mode.
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class BitmapPool extends DataModel
	{
		/**
		 * @throw errors.Errors Throw canNotInstance error when try to instance this class.
		 */
		public function BitmapPool()
		{
			if (instanceable)
			{
				bitmapList = new Dictionary();
			}
			else
			{
				throw new DataError(DataError.SINGLETON);
			}
		}

		private static var bc:BitmapPool;

		private static var instanceable:Boolean = false;

		/**
		 * 
		 * @return 
		 */
		public static function get instance():BitmapPool
		{
			if (bc == null)
			{
				instanceable = true;
				bc = new BitmapPool();
				instanceable = false;
			}
			return bc;
		}

		private const checkTimeSpace:Number = 100;

		// bitmapList[bitmap name] = BitmapLoader
		private var bitmapList:Dictionary;

		private var checkTimer:Timer;

		/**
		 * How many bitmaps now. include loading, loaded, load faield but not delete yet bitmaps.
		 * 
		 * @return
		 */
		public function get bitmapCount():Number
		{
			return DataUtil.getObjectCount(bitmapList);
		}

		/**
		 * If all the bitmaps are loaded successful.
		 * 
		 * @return
		 */
		public function get allLoaded():Boolean
		{
			for each (var v:BitmapLoader in bitmapList)
			{
				if (!v.loaded)
				{
					return false;
				}
			}
			return true;
		}

		/**
		 * Percent of loaded bytes.
		 * sum of loaded files' bytes / total files' bytes
		 */
		public function get loadedBytesPercent():Number
		{
			var percent:Number = 0;
			var count:Number = 0;
			//
			for each (var v:BitmapLoader in bitmapList)
			{
				percent += v.percent;
				count++;
			}
			return percent / count;
		}

		/**
		 * Percent of loaded file number
		 */
		public function get loadedCountRate():Number
		{
			var loaded:Number = 0;
			var count:Number = 0;
			//
			for each (var v:BitmapLoader in bitmapList)
			{
				if (v.loaded)
				{
					loaded++;
				}
				count++;
			}
			return loaded / count;
		}

		/**
		 * Add a new image file to load
		 * Image file must be .gif, .jpeg, .jpg, .swf.
		 * If use swf or gif as image file, only the first frame can be changed to bitmap.
		 * 
		 * @param bitmapName Name of bitmap.(not the image file)
		 * @param bitmapURL Image file URL.
		 * 
		 * @throws DataError Throw NAME_EXIST error when the bitmap name already exist.
		 * 
		 * @see ftk.net.BitmapLoader
		 */
		public function addBitmap(bitmapName:String, bitmapURL:String):BitmapLoader
		{
			if (bitmapList[bitmapName] != null)
			{
				throw new DataError(DataError.NAME_EXIST);
			}
			bitmapList[bitmapName] = new BitmapLoader(bitmapURL, false);
			return bitmapList[bitmapName];
		}

		/**
		 * Change a exist bitmap in this container.
		 * NOTICE, this change will not take effect on the bitmap data that is cloned before change.
		 * 
		 * @param bitmapName Name of bitmap which need be changed.
		 * @param bitmapURL New image file URL.
		 * 
		 * @throw errors.NameError Throw NAME_NOT_EXIST error when the bitmap name is not exist in container.
		 */
		public function changeBitmap(bitmapName:String, bitmapURL:String):BitmapLoader
		{
			var loader:BitmapLoader = bitmapList[bitmapName] as BitmapLoader;
			if (loader == null)
			{
				throw new DataError(DataError.NAME_NOT_EXIST);
			}
			loader.changeBitmap(bitmapURL);
			return bitmapList[bitmapName];
		}

		/**
		 * Remove a bitmap in container.
		 * NOTICE, the bitmap that already cloned out by getBitmap() method will not be removed.
		 * 
		 * @param bitmapName Removed bitmap name. If not exist, nothing will happen.
		 */
		public function removeBitmap(bitmapName:String):void
		{
			if (bitmapList[bitmapName] != null)
			{
				bitmapList[bitmapName] = null;
			}
		}

		/**
		 * Get a bitmap
		 * A new bitmap will be cloned from container.
		 * 
		 * @param bitmapName
		 * @return
		 * 
		 * @throw errors.NameError Throw NAME_NOT_EXIST error when bitmap name is not found in container.
		 */
		public function getBitmap(bitmapName:String):Bitmap
		{
			var loader:BitmapLoader = bitmapList[bitmapName] as BitmapLoader;
			if (loader == null)
			{
				throw new DataError(DataError.NAME_NOT_EXIST);
			}
			if (loader.loaded)
			{
				return loader.bitmap;
			}
			else
			{
				return null;
			}
		}

		/**
		 * This method make this container start a load check.
		 * 
		 * @param timeout If container cannot load all files in this time(sec.), 
		 * a new Event will be dispathed to broadcast loading timeou.
		 */
		public function startLoad(timeout:Number = 300):void
		{
			var totalTime:Number = timeout * 1000;
			var cycCount:Number = Math.floor(totalTime / checkTimeSpace);
			checkTimer = new Timer(checkTimeSpace, cycCount);
			checkTimer.addEventListener(TimerEvent.TIMER, checkHandler);
			checkTimer.addEventListener(TimerEvent.TIMER_COMPLETE, timeoutHandler);
			checkTimer.start();
			//
			for each (var loader:BitmapLoader in bitmapList)
			{
				loader.load();
			}
		}

		/**
		 * Remove all bitmap that is not loaded successful.
		 */
		public function removeFailedBitmap():void
		{
			for (var v:String in bitmapList)
			{
				if ((bitmapList[v] as BitmapLoader).failed)
				{
					bitmapList[v] = null;
				}
			}
		}

		private function checkHandler(e:TimerEvent):void
		{
			for each (var v:BitmapLoader in bitmapList)
			{
				if (!v.loaded)
				{
					return;
				}
			}
			checkTimer.stop();
			checkTimer = null;
			var newEvent:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			this.dispatchEvent(newEvent);
		}

		private function timeoutHandler(e:TimerEvent):void
		{
			checkTimer.stop();
			checkTimer = null;
			var newEvent:LoadEvent = new LoadEvent(LoadEvent.TIMEOUT);
			this.dispatchEvent(newEvent);
		}
	}
}