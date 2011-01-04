//##########################################################
// ___________.__              .__ ___.
// \_   _____/|__| ____ _____  |  |\_ |__  __ __  ____
//  |    __)  |  |/    \\__  \ |  | | __ \|  |  \/ ___\
//  |   |     |  |   |  \/ __ \|  |_| \_\ \  |  / /_/  >
//  \__ |     |__|___|  (____  /____/___  /____/\___  /
//     \/             \/     \/         \/     /_____/
// [fb-aslib] Finalbug ActionScript Library
// http://www.finalbug.org
//##########################################################
package org.finalbug.net
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	
	import org.finalbug.events.LoadEvent;
	
	/**
	 * This class is the super class for class which is used to load file(s).
	 * 
	 * @author Tang Bin
	 * @since old version
	 */
	public class LoaderObject
	{
		//#######################################
		// OVERRIDE
		//#######################################
		
		//#######################################
		// DEFINE
		//#######################################
		
		/**
		 * 
		 * @default 
		 */
		protected var _loaded:Boolean = false;
		/**
		 * 
		 * @default 
		 */
		protected var _failed:Boolean = false;
		/**
		 * 
		 * @default 
		 */
		protected var _loadrate:Number = 0;
		/**
		 * 
		 * @default 
		 */
		protected var dispatcher:EventDispatcher = new EventDispatcher();
		
		//#######################################
		// GETTER and SETTER
		//#######################################
		
		/**
		 * 
		 * @return 
		 */
		public function get loaded():Boolean
		{
			return _loaded;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get failed():Boolean
		{
			return _failed;
		}
		
		/**
		 * 
		 * @return 
		 */
		public function get rate():Number
		{
			return _loadrate;
		}
		
		//#######################################
		// CONSTRUCTOR
		//#######################################
		
		//#######################################
		// PUBLIC
		//#######################################
		
		/**
		 * 
		 * @param type
		 * @param listener
		 * @param useCapture
		 * @param priority
		 * @param useWeakReference
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		//#######################################
		// PROTECTED
		//#######################################
		
		/**
		 * 
		 * @param target
		 */
		protected function dispatchEvent(target:*):void
		{
			target.addEventListener(Event.COMPLETE, onLoadSuccess);
			target.addEventListener(ProgressEvent.PROGRESS, onLoading);
			target.addEventListener(IOErrorEvent.IO_ERROR, onLoadFailed);
		}
		
		/**
		 * 
		 * @param e
		 */
		protected function onLoadSuccess(e:Event):void
		{
			_loaded = true;
			_failed = false;
			_loadrate = 1;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
			dispatcher.dispatchEvent(ee);
		}
		
		/**
		 * 
		 * @param e
		 */
		protected function onLoading(e:ProgressEvent):void
		{
			_loaded = false;
			_failed = false;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOADING);
			ee.bytesLoaded = e.bytesLoaded;
			ee.bytesTotal = e.bytesTotal;
			ee.loadedRate = ee.bytesLoaded / ee.bytesTotal;
			_loadrate = ee.loadedRate;
			dispatcher.dispatchEvent(ee);
		}
		
		/**
		 * 
		 * @param e
		 */
		protected function onLoadFailed(e:IOErrorEvent):void
		{
			_loaded = false;
			_failed = true;
			_loadrate = 0;
			var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_FAILED);
			dispatcher.dispatchEvent(ee);
		}
		
		//#######################################
		// PRIVATE
		//#######################################
		
		//#######################################
		// HANDLER
		//#######################################
	}
}