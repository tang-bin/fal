/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 ******************************************/
package org.finalbug.core.net
{
	import org.finalbug.core.data.DataModel;
	import org.finalbug.core.events.LoadEvent;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.*;
	import flash.net.URLRequest;
	
	/**
	 * This class is used to load a image file.
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	old version
	 */	
	public class BitmapLoader extends DataModel
	{
		private var loader:Loader;
		private var _loaded:Boolean = false;
		private var _failed:Boolean = false;
		private var _percent:Number = 0;
		
		/**
		 * File is loaded or not.
		 */		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		/**
		 * Load file failed or not.
		 */		
		public function get failed():Boolean
		{
			return _failed;
		}
		
		/**
		 * Loaded percent.
		 */		
		public function get percent():Number
		{
			return _percent;
		}
		
		/**
		 * Loaded bitmap.
		 */		
		public function get bitmap():Bitmap
		{
			if(_loaded)
			{
				return new Bitmap((loader.content as Bitmap).bitmapData.clone());
			}
			return null;
		}
		
		/**
		 * Create a new BitmapLoader.
		 * 
		 * @param URL Image file URL.
		 */		
		public function BitmapLoader(URL:String)
		{
			if(URL != "")
			{
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadSuccess);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadFailed);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoading);
				loader.load(new URLRequest(URL)); 	
			}	
		}
		
		/**
		 * Change current image file URL and reload.
		 * 
		 * @param URL
		 * 
		 * @throw org.finalbug.fal.errors.Errors Throw URLisEmpty error when URL parameter is "".
		 */		
		public function changeBitmap(URL:String):void
		{
			if(URL != "")
			{
				_loaded = _failed = false;
				_percent = 0;
				loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadSuccess);
				loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onLoadFailed);
				loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onLoading);
				loader.load(new URLRequest(URL)); 
			}
		}
		
		private function onLoadSuccess(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_percent = 1;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			newE.data = this.bitmap;
			this.dispatchEvent(newE);
		}
		
		private function onLoadFailed(e:IOErrorEvent):void
		{
			_loaded = false;
			_failed = true;
			_percent = 0;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			this.dispatchEvent(newE);
		}
		
		private function onLoading(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var newE:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			newE.loadedBytes = e.bytesLoaded;
			newE.totalBytes = e.bytesTotal;
			newE.loadedRate = newE.loadedBytes / newE.totalBytes;
			_percent = newE.loadedRate;
			this.dispatchEvent(newE);
		}
	}
}