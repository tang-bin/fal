/******************************************
 * Finalbug ActionScript Library
 * http://www.finalbug.org/
 *****************************************/
package org.finalbug.framework.css
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.finalbug.core.data.DataModel;
	import org.finalbug.core.events.LoadEvent;
	import org.finalbug.ui.errors.StyleError;
	
	/**
	 * org.finalbug.fal.css.CSSManager
	 *  
	 * @author	Tang Bin (tangbin@finalbug.org)
	 * @since	2010.08
	 */	
	public class CSSManager extends DataModel
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		private static var cm:CSSManager;
		private static var instanceable:Boolean = false;
		
		/**
		 * timer to check checker timeout.
		 */		
		private var timeoutTimer:Timer; 
		
		/**
		 * List of CSS files, each item is a CSSFile instance.
		 */		
		private var fileList:Array = new Array();
		
		private var checked:Boolean = false;
		
		/****************************************
		 * GETTER & SETTER
		 ****************************************/
		
		public static function get instance():CSSManager
		{
			if(cm == null)
			{
				instanceable = true;
				cm = new CSSManager();
				instanceable = false;
			}
			return cm;
		}
		
		/****************************************
		 * org.finalbug.fal.css.CSSCore constructor.
		 ****************************************/
		public function CSSManager()
		{
			super();
			if(!instanceable)
			{
				throw new StyleError(StyleError.CSS_UNREGISTERED);
			}
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * 
		 * PUBLIC
		 * 
		 ****************************************/
		
		public function registerCSS(url:String):void
		{
			// when an new CSS File is registered,
			// checked value will be set as false means manager is not ready.
			checked = false;
			//
			var file:CSSFile = getCSSFile(url);
			if(file == null)file = new CSSFile();
			file.loadFile(url);
			fileList.push(file);
		}
		
		public function unregisterCSS(file:CSSFile):void
		{
			
		}
		
		/**
		 * @param timeout Default timeout 60s
		 */		
		public function check(timeout:Number = 60000):void
		{
			checkCSSReadyHandler();
			//
			if(timeoutTimer != null && timeoutTimer.running)
			{
				timeoutTimer.stop();
				timeoutTimer.removeEventListener(TimerEvent.TIMER, checkTimeoutHandler);
				timeoutTimer = null;
			}
			timeoutTimer = new Timer(timeout, 1);
			timeoutTimer.addEventListener(TimerEvent.TIMER, checkTimeoutHandler);
			timeoutTimer.start();
		}
		
		public function CSSRegistered(CSSPath:String):Boolean
		{
			for each(var file:CSSFile in fileList)
			{
				if(file.url == CSSPath)return true;
			}
			return false;
		}
		
		public function getCSSFile(CSSPath:String):CSSFile
		{
			for each(var file:CSSFile in fileList)
			{
				if(file.url == CSSPath)return file;
			}
			return null;
		}
		
		/****************************************
		 * 
		 * PROTECTED
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * PRIVATE
		 * 
		 ****************************************/
		
		/****************************************
		 * 
		 * HANDLER
		 * 
		 ****************************************/
		
		private function checkCSSReadyHandler(e:TimerEvent = null):void
		{
			var ready:uint = 0;
			var error:uint = 0;
			for each(var file:CSSFile in fileList)
			{
				if(file.ready) ready++;
				else if(file.error) error++;
			}
			//
			var total:uint = fileList.length;
			if(ready + error == total)
			{
				// all loaded / error
				this.checked = true;
				//
				var ee:LoadEvent = new LoadEvent(LoadEvent.LOAD_SUCCESS);
				ee.totalNum = total;
				ee.loadedNum = ready;
				ee.errorNum = error;
				this.dispatchEvent(ee);
			}
			else
			{
				var checkTimer:Timer = new Timer(100, 1);
				checkTimer.addEventListener(TimerEvent.TIMER, checkCSSReadyHandler, false, 0, true);
				checkTimer.start();
			}
		}
		
		private function checkTimeoutHandler(e:TimerEvent):void
		{
			var ee:LoadEvent = new LoadEvent(LoadEvent.TIMEOUT);
			this.dispatchEvent(ee);
		}
	}
}