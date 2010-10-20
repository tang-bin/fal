/******************************************
 * [fb-aslib] Finalbug ActionScript Library 
 * http://www.finalbug.org
 *****************************************/
package org.finalbug.data
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.ByteArray;
	import flash.utils.Proxy;
	import flash.utils.flash_proxy;
	import flash.utils.getQualifiedClassName;
	
	import org.finalbug.events.DataEvent;
	
	/**
	 * @author Tang Bin
	 * @since old version
	 */	
	public class DataModel extends Proxy
	{
		/****************************************
		 * DEFINE
		 ****************************************/
		
		private var dispatcher:EventDispatcher = new EventDispatcher();
		private var data:Object = new Object();
		
		/****************************************
		 * GETTER and SETTER
		 ****************************************/
		
		public function get byteArray():ByteArray
		{
			return null;
		}
		public function set byteArray(value:ByteArray):void
		{
			// not do here.
		}
		
		/****************************************
		 * data.DataModel constructor.
		 ****************************************/
		public function DataModel()
		{
		}
		
		/****************************************
		 * OVERRIDE METHODS
		 * Whit out getter, setter and handler
		 * include public, protected and private.
		 ****************************************/
		
		/****************************************
		 * PUBLIC
		 ****************************************/
		
		public function addEventListener(type:String,
										 listener:Function,
										 useCapture:Boolean = false,
										 priority:int = 0,
										 useWeakReference:Boolean = false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		public function removeEventListener(type:String,
											listener:Function,
											useCapture:Boolean = false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		
		public function dispatchEvent(event:Event):void
		{
			this.dispatcher.dispatchEvent(event);
		}
		
		public function toString():String
		{
			return flash.utils.getQualifiedClassName(this);
		}
		
		override flash_proxy function getProperty(name:*):*
		{
			return data[name];
		}
		
		override flash_proxy function setProperty(name:*, value:*):void
		{
			var ee:DataEvent = new DataEvent(DataEvent.CHANGE_DATA);
			ee.oldData = data[name];
			ee.newData = value;
			data[name] = value;
			this.dispatchEvent(ee);
		}
		
		/****************************************
		 * PROTECTED
		 ****************************************/
		
		/****************************************
		 * PRIVATE
		 ****************************************/
		
		/****************************************
		 * HANDLER
		 ****************************************/
	}
}