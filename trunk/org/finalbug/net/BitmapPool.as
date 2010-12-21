/******************************************************
 * [fb-aslib] Finalbug ActionScript Library
 * http://www.finalbug.org
 ******************************************/
package org.finalbug.net
{
	import org.finalbug.data.DataModel;
	import org.finalbug.errors.DataError;
	import org.finalbug.events.LoadEvent;
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
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
		private const checkTimeSpace:Number = 100;
		
		private static var bc:BitmapPool;

		private static var instanceable:Boolean = false;

		private var bitmapList:Object;
		//	bitmapList[bitmap name] = BitmapLoader

		private var checkTimer:Timer;
		
		/**
		 * How many bitmaps now. include loading, loaded, load faield but not delete yet bitmaps.
		 * 
		 * @return
		 */		
		public function get bitmapCount():Number
		{
			var num:Number = 0;
			for each(var v:* in bitmapList)
			{
				num++;
			}
			return num;
		}
		
		/**
		 * If all the bitmaps are loaded successful.
		 * 
		 * @return
		 */		
		public function get allLoaded():Boolean
		{
			for each(var v:* in bitmapList)
			{
				if(!v.loaded)
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
		public function get loadedBytesRate():Number
		{
			var rates:Number = 0;
			var count:Number = 0;
			//
			for each(var v:* in bitmapList)
			{
				rates += v.rate;
				count++;
			}
			return rates / count;
		}
		
		/**
		 * Percent of loaded file number
		 */		
		public function get loadedCountRate():Number
		{
			var loaded:Number = 0;
			var count:Number = 0;
			//
			for each(var v:* in bitmapList)
			{
				if(v.loaded)
				{
					loaded++;
				}
				count++;
			}
			return loaded / count;
		}
		
		public static function get instance():BitmapPool
		{
			if(bc == null)
			{
				instanceable = true;
				bc = new BitmapPool();
				instanceable = false;
			}
			return bc;
		}
		
		/**
		 * @throw errors.Errors Throw canNotInstance error when try to instance this class.
		 */		
		public function BitmapPool()
		{
			if(instanceable)
			{
				bitmapList = new Object();
				return;
			}
			else
			{
				throw new DataError(DataError.SINGLETON);
			}
		}
				
		/**
		 * Add a new image file to load
		 * Image file must be .gif, .jpeg, .jpg, .swf.
		 * If use swf or gif as image file, only the first frame can be changed to bitmap.
		 * 
		 * @param bitmapName Name of bitmap.(not the image file)
		 * @param bitmapURL Image file URL.
		 * 
		 * @throw errors.NameError Throw NAME_EXIST error when the bitmap name already exist.
		 * @throw errors.NameError Throw NAME_INVALID_VAR_NAME when the bitmap name is not level 1 string.
		 * 
		 * @see net.BitmapLoader
		 */		
		public function loadBitmap(bitmapName:String, bitmapURL:String):BitmapLoader
		{
			if(bitmapList[bitmapName] != null)
			{
				throw new DataError(DataError.NAME_EXIST);
			}
			/*
			if(!Charset.checkCharIsNameAvailable(bitmapName))
			{
				throw new DataError(DataError.INVALID_VAR_NAME);
			}
			*/
			bitmapList[bitmapName] = new BitmapLoader(bitmapURL);
			return bitmapList[bitmapName];
		}
		
		/**
		 * Change a exist bitmap in this container.
		 * NOTICE, this change will not take effect on the bitmap datas that is cloned before change.
		 * 
		 * @param bitmapName Name of bitmap which need be changed.
		 * @param bitmapURL New image file URL.
		 * 
		 * @throw errors.NameError Throw NAME_NOT_EXIST error when the bitmap name is not exist in container.
		 */		
		public function changeBitmap(bitmapName:String, bitmapURL:String):BitmapLoader
		{
			if(bitmapList[bitmapName] == null)
			{
				throw new DataError(DataError.NAME_NOT_EXIST);
			}
			bitmapList[bitmapName].changeBitmap(bitmapURL);
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
			if(bitmapList[bitmapName] != null)
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
			if(bitmapList[bitmapName] == null)
			{
				throw new DataError(DataError.NAME_NOT_EXIST);
			}
			if(bitmapList[bitmapName].loaded)
			{
				return bitmapList[bitmapName].bitmap;
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
		public function startCheck(timeout:Number = 300):void
		{
			var totalTime:Number = timeout * 1000;
			var cycCount:Number = Math.floor(totalTime / checkTimeSpace);
			checkTimer = new Timer(checkTimeSpace, cycCount);
			checkTimer.addEventListener(TimerEvent.TIMER, onCheck);
			checkTimer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimeout);
			checkTimer.start();
		}
		
		/**
		 * Remove all bitmap that is not loaded successful.
		 */		
		public function removeFailedBitmap():void
		{
			for(var v:String in bitmapList)
			{
				if(bitmapList[v].failed)
				{
					bitmapList[v] = null;
				}
			}
		}
		
		private function onCheck(e:TimerEvent):void
		{
			for each(var v:* in bitmapList)
			{
				if(!v.loaded)
				{
					return;
				}
			}
			checkTimer.stop();
			checkTimer = null;
			var newEvent:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			this.dispatchEvent(newEvent);
		}
		
		private function onTimeout(e:TimerEvent):void
		{
			checkTimer.stop();
			checkTimer = null;
			var newEvent:LoadEvent = new LoadEvent(LoadEvent.TIMEOUT);
			this.dispatchEvent(newEvent);
		}
	}
}