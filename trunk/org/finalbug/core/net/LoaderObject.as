package org.finalbug.core.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import org.finalbug.events.LoadEvent;
	
	/**
	 * This class is the super class for class which is used to load file(s).
	 * 
	 * @author	Tang Bin (tangbin@finalbug.org)
	 */
	public class LoaderObject
	{
		protected var _loaded:Boolean = false;
		protected var _failed:Boolean = false;
		protected var _loadrate:Number = 0;
		protected var dispatcher:EventDispatcher = new EventDispatcher();
		
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		public function get failed():Boolean
		{
			return _failed;
		}
		
		public function get rate():Number
		{
			return _loadrate;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		protected function dispatchEvent(target:*):void
		{
			target.addEventListener(Event.COMPLETE, onLoadSuccess);
			target.addEventListener(ProgressEvent.PROGRESS, onLoading);
			target.addEventListener(IOErrorEvent.IO_ERROR, onLoadFailed);
		}
		
		protected function onLoadSuccess(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_loadrate = 1;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			dispatcher.dispatchEvent(ee);
		}
		
		protected function onLoading(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			ee.loadedBytes = e.bytesLoaded;
			ee.totalBytes = e.bytesTotal;
			ee.loadedRate = ee.loadedBytes / ee.totalBytes;
			_loadrate = ee.loadedRate;
			dispatcher.dispatchEvent(ee);
		}
		
		protected function onLoadFailed(e:IOErrorEvent):void
		{
			_loaded = false;
			_failed = true;
			_loadrate = 0;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			dispatcher.dispatchEvent(ee);
		}
	}
}